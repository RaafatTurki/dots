pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import "lrc.js" as Lrc

// Synced lyrics for Player's current song, fetched from lrclib.net.
Singleton {
  id: root

  property var lines: []
  property int activeLineIndex: -1
  property string statusText: ""

  property string syncedKey: ""
  property string lookupKey: ""
  property bool pendingFetch: false

  function reset(message) {
    lines = [];
    activeLineIndex = -1;
    statusText = message || "";
  }

  function syncTrack() {
    if (!Player.trackKey) {
      syncedKey = "";
      reset(Player.status);
      return;
    }

    if (Player.trackKey === syncedKey) {
      return;
    }

    syncedKey = Player.trackKey;
    reset("Searching lyrics");
    fetch();
  }

  function updateDisplayedLine() {
    if (lines.length === 0) {
      activeLineIndex = -1;
      return;
    }

    let activeIndex = -1;

    for (let i = 0; i < lines.length; i++) {
      if (Player.positionSeconds + 0.15 >= lines[i].time) {
        activeIndex = i;
      } else {
        break;
      }
    }

    activeLineIndex = activeIndex;
  }

  function fetch() {
    if (!Player.trackTitle || !Player.trackArtist) {
      return;
    }

    if (lyricsProcess.running) {
      pendingFetch = true;
      return;
    }

    statusText = "Searching lyrics";
    lookupKey = Player.trackKey;
    pendingFetch = false;
    lyricsProcess.exec([
      "bash",
      "-c",
      "curl -fsSL --get --data-urlencode track_name=\"$1\" --data-urlencode artist_name=\"$2\" https://lrclib.net/api/search",
      "lrclib",
      Player.trackTitle,
      Player.trackArtist
    ]);
  }

  Connections {
    target: Player

    function onTrackKeyChanged() {
      root.syncTrack();
    }

    function onStatusChanged() {
      root.syncTrack();
    }

    function onPositionSecondsChanged() {
      root.updateDisplayedLine();
    }
  }

  Component.onCompleted: syncTrack()

  Process {
    id: lyricsProcess

    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        if (root.lookupKey !== Player.trackKey) {
          root.fetch();
          return;
        }

        try {
          const results = JSON.parse(text);
          let selected = null;

          for (let i = 0; i < results.length; i++) {
            if (results[i].syncedLyrics && results[i].syncedLyrics.length > 0) {
              selected = results[i];
              break;
            }
          }

          if (!selected) {
            root.reset("No synced lyrics found");
            return;
          }

          root.lines = Lrc.parseSyncedLyrics(selected.syncedLyrics);
          root.statusText = root.lines.length > 0 ? "" : "No synced lyrics found";
          root.activeLineIndex = -1;
          root.updateDisplayedLine();
        } catch (error) {
          root.reset("Lyrics lookup failed");
        }

        if (root.pendingFetch) {
          root.fetch();
        }
      }
    }
  }
}
