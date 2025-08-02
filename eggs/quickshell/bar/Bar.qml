import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.widgets

// Quickshell's qmltypes only expose a stub for PanelWindow, so qmllint
// flags it as uncreatable; the qmllint disable comment silences that false positive.
PanelWindow { // qmllint disable uncreatable-type
  anchors {
    top: true
    left: true
    right: true
  }
  exclusiveZone: Theme.barHeight
  implicitHeight: Theme.barHeight
  color: Theme.colBg

  RowLayout {
    anchors {
      left: parent.left
      verticalCenter: parent.verticalCenter
    }
    height: parent.height
    spacing: 20

    Tray {
      Layout.fillHeight: true
    }

    UsdRate {}

    ClaudeLimits {}

    OpenCodeLimits {}
  }

  Clock {
    anchors.centerIn: parent
  }

  WorkspaceList {
    anchors {
      right: parent.right
      verticalCenter: parent.verticalCenter
      rightMargin: 10
    }
  }
}
