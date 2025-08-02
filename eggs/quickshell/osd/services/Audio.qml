pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
  id: root

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property bool muted: sink?.audio.muted ?? false
  readonly property real volume: sink?.audio.volume ?? 0

  // Bind the pipewire node so its volume will be tracked
  PwObjectTracker {
    objects: [ root.sink ]
  }
}
