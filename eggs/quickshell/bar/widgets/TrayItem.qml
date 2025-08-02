import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs

MouseArea {
  id: root

  required property var modelData
  readonly property string fallbackText: {
    const text = modelData.tooltipTitle || modelData.title || modelData.id || "?";
    return text.length > 0 ? text[0].toUpperCase() : "?";
  }

  Layout.preferredWidth: Theme.trayItemSize
  Layout.preferredHeight: Theme.trayItemSize
  acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
  hoverEnabled: true

  function openMenu() {
    if (!modelData.hasMenu) {
      return false;
    }

    const point = QsWindow.mapFromItem(root, width / 2, height);
    modelData.display(QsWindow.window, point.x, point.y);

    return true;
  }

  onPressed: function(mouse) {
    if (mouse.button === Qt.RightButton) {
      mouse.accepted = openMenu();
    }
  }

  onClicked: function(mouse) {
    if (mouse.button === Qt.RightButton) {
      return;
    } else if (mouse.button === Qt.MiddleButton) {
      modelData.secondaryActivate();
    } else if (modelData.onlyMenu) {
      openMenu();
    } else {
      modelData.activate();
    }
  }

  Rectangle {
    anchors.fill: parent
    color: root.containsMouse ? Theme.colorHoverOverlay : Theme.colBg
  }

  IconImage {
    anchors.centerIn: parent
    width: Theme.trayItemSize
    height: Theme.trayItemSize
    implicitSize: Theme.trayItemSize
    source: root.modelData.icon
  }
}
