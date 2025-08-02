pragma Singleton

import QtQuick
import Quickshell

Singleton {
  readonly property int panelWidth: 1000
  readonly property int visibleLineCount: 10
  readonly property int lineHeight: 30
  readonly property int panelHeight: lineHeight * visibleLineCount + 20
  readonly property int fontSize: 22

  readonly property color colorTransparent: "transparent"
  readonly property color colorBackground: "#cc101317"
  readonly property color colorForeground: "#f4f7fb"
  readonly property color colorMuted: "#99f4f7fb"
  readonly property color colorAccent: "#4FB7F6"
}
