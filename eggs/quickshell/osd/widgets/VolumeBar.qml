import QtQuick
import qs

Rectangle {
  id: root

  property double volumeRatio: 0
  // property double volumRatioOver: 1.0
  property double volumeRatioMax: 2.0
  // property bool isOver: volumRatio > volumRatioOver
  property bool muted: false

  implicitHeight: 5
  radius: height / 2
  color: Theme.colorTrack
  opacity: muted ? 0.4 : 1.0

  Rectangle {
    anchors {
      left: parent.left
      top: parent.top
      bottom: parent.bottom
    }

    // color: root.isOver ? "#77ff0000" : Theme.colorFill
    color: Theme.colorFill
    implicitWidth: parent.width / root.volumeRatioMax * Math.min(root.volumeRatioMax, root.volumeRatio)
    radius: parent.radius
  }
}
