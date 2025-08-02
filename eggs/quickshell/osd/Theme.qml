pragma Singleton

import QtQuick
import Quickshell

Singleton {
  readonly property int osdWidth: 400
  readonly property int osdHeight: 50
  readonly property int iconSize: 20
  readonly property int hideDelay: 500

  readonly property color colorBackground: "#80000000"
  readonly property color colorTrack: "#77ffffff"
  readonly property color colorFill: "#77ffffff"
  readonly property color colorText: "#ffffff"
}
