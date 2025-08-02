pragma Singleton

import QtQuick
import Quickshell

Singleton {
  readonly property int barHeight: 20
  readonly property int trayItemSize: 16
  readonly property int fontSize: 16
  readonly property int usageBarWidth: 60
  readonly property int usageBarHeight: 2
  readonly property int usageLabelSize: 14

  readonly property color colBg: "transparent"
  readonly property color colOn: "#FFF"
  readonly property color colOff: "#333"
  readonly property color colHalf: "#999"
  readonly property color colUrg: "#E7365D"

  readonly property color colorHoverOverlay: "#22ffffff"
}
