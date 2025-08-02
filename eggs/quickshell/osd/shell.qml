import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root

  // Bind the pipewire node so its volume will be tracked
  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio

    function onVolumeChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }
  }

  property bool shouldShowOsd: false

  Timer {
    id: hideTimer
    interval: 500
    onTriggered: root.shouldShowOsd = false
  }

  // NOTE: The OSD window will be created and destroyed based on shouldShowOsd.
  // PanelWindow.visible could be set instead of using a loader.
  // using a loader will reduce the memory overhead when the window isn't open.
  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.top: true
      margins.top: screen.height / 15
      exclusiveZone: 0

      implicitWidth: 400
      implicitHeight: 50
      color: "transparent"

      // NOTE an empty click mask prevents the window from blocking mouse events.
      mask: Region {}


      Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: "#80000000"

        RowLayout {
          anchors {
            fill: parent
            leftMargin: 15
            rightMargin: 15
          }

          IconImage {
            implicitSize: 20
            source: Quickshell.iconPath("audio-volume-high-symbolic")
          }

          Rectangle {
            // Stretches to fill all left-over space
            Layout.fillWidth: true

            implicitHeight: 5
            radius: height / 2
            color: "#77ffffff"

            Rectangle {
              id: progressBar

              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }

              property double volumRatio: Pipewire.defaultAudioSink?.audio.volume ?? 0
              // property double volumRatioOver: 1.0
              property double volumRatioMax: 2.0
              // property bool isOver: volumRatio > volumRatioOver

              // color: isOver ? "#77ff0000" : "#77ffffff"
              color: "#77ffffff"
              implicitWidth: parent.width/volumRatioMax * Math.min(volumRatioMax, volumRatio)
              radius: parent.radius
            }
          }

          Text {
            text: (100 * progressBar.volumRatio).toFixed(0)
            color: "#ffffff"
          }
        }
      }
    }
  }
}
