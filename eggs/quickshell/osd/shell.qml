import QtQuick
import Quickshell
import qs
import qs.services

Scope {
  id: root

  property bool shouldShowOsd: false

  function show() {
    root.shouldShowOsd = true;
    hideTimer.restart();
  }

  Connections {
    target: Audio.sink?.audio ?? null

    function onVolumeChanged() {
      root.show();
    }

    function onMutedChanged() {
      root.show();
    }
  }

  Timer {
    id: hideTimer
    interval: Theme.hideDelay
    onTriggered: root.shouldShowOsd = false
  }

  // NOTE: The OSD window will be created and destroyed based on shouldShowOsd.
  // PanelWindow.visible could be set instead of using a loader.
  // using a loader will reduce the memory overhead when the window isn't open.
  LazyLoader {
    active: root.shouldShowOsd

    VolumeOsd {}
  }
}
