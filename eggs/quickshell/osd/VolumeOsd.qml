import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs
import qs.services
import qs.widgets

// Quickshell's qmltypes only expose stubs for PanelWindow and screen, so qmllint
// flags valid code here; the qmllint disable comments silence those false positives.
PanelWindow { // qmllint disable uncreatable-type
  anchors.top: true
  margins.top: screen.height / 20 // qmllint disable missing-property
  exclusiveZone: 0

  implicitWidth: Theme.osdWidth
  implicitHeight: Theme.osdHeight
  color: "transparent"

  // NOTE: an empty click mask prevents the window from blocking mouse events.
  mask: Region {}

  Rectangle {
    anchors.fill: parent
    radius: height / 2
    color: Theme.colorBackground

    RowLayout {
      anchors {
        fill: parent
        leftMargin: 15
        rightMargin: 15
      }

      IconImage {
        implicitSize: Theme.iconSize
        source: Quickshell.iconPath(Audio.muted ? "audio-volume-muted-symbolic" : "audio-volume-high-symbolic")
      }

      VolumeBar {
        // Stretches to fill all left-over space
        Layout.fillWidth: true

        volumeRatio: Audio.volume
        muted: Audio.muted
      }

      Text {
        text: Audio.muted ? "muted" : (100 * Audio.volume).toFixed(0)
        color: Theme.colorText
      }
    }
  }
}
