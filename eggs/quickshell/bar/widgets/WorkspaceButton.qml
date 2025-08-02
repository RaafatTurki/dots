import QtQuick
import QtQuick.Layouts
import qs
import qs.services

MouseArea {
  id: root

  required property var modelData

  Layout.preferredWidth: 8
  Layout.preferredHeight: 16
  acceptedButtons: Qt.LeftButton
  hoverEnabled: true

  onClicked: Workspaces.switchTo(modelData.name)

  Text {
    anchors.centerIn: parent
    color: root.modelData.urgent ? Theme.colUrg : root.modelData.active ? Theme.colOn : root.modelData.occupied ? Theme.colHalf : Theme.colOff
    font.pixelSize: Theme.fontSize
    text: root.modelData.name
  }
}
