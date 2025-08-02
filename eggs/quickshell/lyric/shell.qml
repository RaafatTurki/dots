import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

Scope {
  id: root

  readonly property int panelWidth: 1000
  readonly property int visibleLineCount: 10
  readonly property int lineHeight: 30
  readonly property int panelHeight: lineHeight * visibleLineCount + 20
  readonly property color colorTransparent: "transparent"
  readonly property color colorBackground: "#cc101317"
  readonly property color colorForeground: "#f4f7fb"
  readonly property color colorMuted: "#99f4f7fb"
  readonly property color colorAccent: "#4FB7F6"

  property string trackTitle: ""
  property string trackArtist: ""
  property string trackKey: ""
  property string statusText: ""
  property string lyricsLookupKey: ""
  property double positionSeconds: 0
  property int activeLineIndex: -1
  property var lyricLines: []
  property var activePlayer: null
  property bool pendingLyricsFetch: false
  readonly property bool appIdentitySet: {
    Qt.application.name = "quickshell-lyrics";
    Qt.application.displayName = "quickshell-lyrics";
    return true;
  }

  function resetLyrics(message) {
    lyricLines = [];
    activeLineIndex = -1;
    statusText = message || "";
  }

  function parseTimestamp(timestamp) {
    var parts = timestamp.split(":");

    if (parts.length !== 2) {
      return -1;
    }

    var minutes = Number(parts[0]);
    var seconds = Number(parts[1]);

    if (!isFinite(minutes) || !isFinite(seconds)) {
      return -1;
    }

    return minutes * 60 + seconds;
  }

  function parseSyncedLyrics(text) {
    var parsed = [];
    var rows = String(text || "").split("\n");
    var pattern = /\[([0-9]{1,2}:[0-9]{2}(?:\.[0-9]{1,3})?)\]/g;

    for (var i = 0; i < rows.length; i++) {
      var row = rows[i].trim();
      var lyric = row.replace(pattern, "").trim();
      var match;

      pattern.lastIndex = 0;
      while ((match = pattern.exec(row)) !== null) {
        var time = parseTimestamp(match[1]);

        if (time >= 0) {
          parsed.push({ time: time, text: lyric });
        }
      }
    }

    parsed.sort(function(a, b) {
      return a.time - b.time;
    });

    return parsed;
  }

  function updateDisplayedLine() {
    if (lyricLines.length === 0) {
      activeLineIndex = -1;
      return;
    }

    var activeIndex = -1;

    for (var i = 0; i < lyricLines.length; i++) {
      if (positionSeconds + 0.15 >= lyricLines[i].time) {
        activeIndex = i;
      } else {
        break;
      }
    }

    activeLineIndex = activeIndex;
  }

  function lyricDistance(index) {
    var active = Math.max(activeLineIndex, 0);
    return Math.abs(index - active);
  }

  function scrollAnchorIndex() {
    var active = Math.max(activeLineIndex, 0);
    var lastCenteredIndex = Math.max(0, lyricLines.length - 3);

    return Math.min(Math.max(active, 2), lastCenteredIndex);
  }

  function fetchLyrics() {
    if (!trackTitle || !trackArtist) {
      return;
    }

    if (lyricsProcess.running) {
      pendingLyricsFetch = true;
      return;
    }

    statusText = "Searching lyrics";
    lyricsLookupKey = trackKey;
    pendingLyricsFetch = false;
    lyricsProcess.exec([
      "bash",
      "-c",
      "curl -fsSL --get --data-urlencode track_name=\"$1\" --data-urlencode artist_name=\"$2\" https://lrclib.net/api/search",
      "lrclib",
      trackTitle,
      trackArtist
    ]);
  }

  function selectActivePlayer() {
    var players = Mpris.players.values;
    var selected = null;

    for (var i = 0; i < players.length; i++) {
      if (players[i].isPlaying) {
        selected = players[i];
        break;
      }
    }

    if (!selected && players.length > 0) {
      selected = players[0];
    }

    activePlayer = selected;
    updateTrackFromMpris();
  }

  function updateTrackFromMpris() {
    if (!activePlayer) {
      trackTitle = "";
      trackArtist = "";
      trackKey = "";
      positionSeconds = 0;
      resetLyrics("No MPRIS player");
      return;
    }

    var title = activePlayer.trackTitle || "";
    var artist = activePlayer.trackArtist || activePlayer.trackArtists || "";
    var key = activePlayer.uniqueId + "\n" + title + "\n" + artist;

    if (!title || !artist) {
      trackTitle = "";
      trackArtist = "";
      trackKey = "";
      positionSeconds = activePlayer.position || 0;
      resetLyrics("No song metadata");
      return;
    }

    if (key === trackKey) {
      positionSeconds = activePlayer.position || 0;
      updateDisplayedLine();
      return;
    }

    trackTitle = title;
    trackArtist = artist;
    trackKey = key;
    positionSeconds = activePlayer.position || 0;
    resetLyrics("Searching lyrics");
    fetchLyrics();
  }

  Timer {
    interval: 250
    running: root.activePlayer && root.activePlayer.isPlaying
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      root.positionSeconds = root.activePlayer.position || 0;
      root.updateDisplayedLine();
    }
  }

  Connections {
    target: Mpris.players

    function onValuesChanged() {
      root.selectActivePlayer();
    }
  }

  Connections {
    target: root.activePlayer

    function onTrackChanged() {
      root.updateTrackFromMpris();
    }

    function onMetadataChanged() {
      root.updateTrackFromMpris();
    }

    function onTrackTitleChanged() {
      root.updateTrackFromMpris();
    }

    function onTrackArtistChanged() {
      root.updateTrackFromMpris();
    }

    function onIsPlayingChanged() {
      root.selectActivePlayer();
      root.updateDisplayedLine();
    }

    function onPositionChanged() {
      root.positionSeconds = root.activePlayer.position || 0;
      root.updateDisplayedLine();
    }
  }

  Component.onCompleted: selectActivePlayer()

  Process {
    id: lyricsProcess

    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        if (root.lyricsLookupKey !== root.trackKey) {
          root.fetchLyrics();
          return;
        }

        try {
          var results = JSON.parse(text);
          var selected = null;

          for (var i = 0; i < results.length; i++) {
            if (results[i].syncedLyrics && results[i].syncedLyrics.length > 0) {
              selected = results[i];
              break;
            }
          }

          if (!selected) {
            root.resetLyrics("No synced lyrics found");
            return;
          }

          root.lyricLines = root.parseSyncedLyrics(selected.syncedLyrics);
          root.statusText = root.lyricLines.length > 0 ? "" : "No synced lyrics found";
          root.activeLineIndex = -1;
          root.updateDisplayedLine();
        } catch (error) {
          root.resetLyrics("Lyrics lookup failed");
        }

        if (root.pendingLyricsFetch) {
          root.fetchLyrics();
        }
      }
    }
  }

  PanelWindow {
    anchors {
      top: true
    }
    margins.top: 150
    exclusiveZone: 0
    aboveWindows: false
    focusable: false
    implicitWidth: Math.min(root.panelWidth, screen.width - 24)
    implicitHeight: root.panelHeight
    color: root.colorTransparent
    mask: Region {}

    function setWindowTitle() {
      if (_backingWindow) {
        _backingWindow.title = "quickshell-lyrics";
      }
    }

    onWindowConnected: setWindowTitle()
    Component.onCompleted: setWindowTitle()

    Rectangle {
      anchors.fill: parent
      color: "transparent"

      Item {
        id: lyricViewport

        anchors {
          fill: parent
        }
        clip: true

        Text {
          anchors.centerIn: parent
          width: parent.width
          horizontalAlignment: Text.AlignHCenter
          color: root.colorMuted
          elide: Text.ElideRight
          maximumLineCount: 1
          font.pixelSize: 22
          font.weight: Font.DemiBold
          visible: root.lyricLines.length === 0
          text: root.statusText || "..."
        }

        Column {
          id: lyricColumn

          width: parent.width
          visible: root.lyricLines.length > 0
          y: (lyricViewport.height / 2) - ((root.scrollAnchorIndex() + 0.5) * root.lineHeight)

          Behavior on y {
            NumberAnimation {
              duration: 420
              easing.type: Easing.OutCubic
            }
          }

          Repeater {
            model: root.lyricLines

            Text {
              required property var modelData
              required property int index

              width: lyricColumn.width
              height: root.lineHeight
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
              color: root.lyricDistance(index) === 0 ? root.colorForeground : root.colorMuted
              opacity: Math.max(0.32, 1 - (root.lyricDistance(index) * 0.22))
              elide: Text.ElideRight
              maximumLineCount: 1
              font.pixelSize: 22
              font.weight: root.lyricDistance(index) === 0 ? Font.DemiBold : Font.Medium
              text: modelData.text || ""

              Behavior on opacity {
                NumberAnimation {
                  duration: 240
                  easing.type: Easing.OutCubic
                }
              }
            }
          }
        }
      }
    }
  }
}
