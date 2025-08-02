pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// Tracks the most relevant MPRIS player and its current song.
Singleton {
  id: root

  property var activePlayer: null
  property string trackTitle: ""
  property string trackArtist: ""
  // Changes whenever the player or song changes; empty when there is no usable song.
  property string trackKey: ""
  // Why there is no song, when trackKey is empty.
  property string status: ""
  property double positionSeconds: 0

  // The Mpris qmltypes ship an empty stub for UntypedObjectModel that shadows the
  // real one, so the linter can't see `values`. The qmllint comments below silence that.
  function selectActivePlayer() {
    const players = Mpris.players.values; // qmllint disable missing-property
    let selected = null;

    for (let i = 0; i < players.length; i++) {
      if (players[i].isPlaying) {
        selected = players[i];
        break;
      }
    }

    if (!selected && players.length > 0) {
      selected = players[0];
    }

    activePlayer = selected;
    updateTrack();
  }

  function setTrack(title, artist, key) {
    trackTitle = title;
    trackArtist = artist;
    trackKey = key;
  }

  function updateTrack() {
    if (!activePlayer) {
      status = "No MPRIS player";
      setTrack("", "", "");
      positionSeconds = 0;
      return;
    }

    const title = activePlayer.trackTitle || "";
    const artist = activePlayer.trackArtist || activePlayer.trackArtists || "";

    positionSeconds = activePlayer.position || 0;

    if (!title || !artist) {
      status = "No song metadata";
      setTrack("", "", "");
      return;
    }

    setTrack(title, artist, activePlayer.uniqueId + "\n" + title + "\n" + artist);
    status = "";
  }

  Timer {
    interval: 250
    running: root.activePlayer && root.activePlayer.isPlaying
    repeat: true
    triggeredOnStart: true
    onTriggered: root.positionSeconds = root.activePlayer.position || 0
  }

  Connections {
    target: Mpris.players // qmllint disable incompatible-type

    function onValuesChanged() {
      root.selectActivePlayer();
    }
  }

  Connections {
    target: root.activePlayer

    function onTrackChanged() {
      root.updateTrack();
    }

    function onMetadataChanged() {
      root.updateTrack();
    }

    function onTrackTitleChanged() {
      root.updateTrack();
    }

    function onTrackArtistChanged() {
      root.updateTrack();
    }

    function onIsPlayingChanged() {
      root.selectActivePlayer();
    }

    function onPositionChanged() {
      root.positionSeconds = root.activePlayer.position || 0;
    }
  }

  Component.onCompleted: selectActivePlayer()
}
