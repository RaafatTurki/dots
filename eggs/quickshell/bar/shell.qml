//@ pragma UseQApplication

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Scope {
  id: root

  readonly property int barHeight: 20
  readonly property int trayItemSize: 16

  readonly property color colBg: "transparent"
  readonly property color colOn: "#FFF"
  readonly property color colOff: "#333"
  readonly property color colHalf: "#999"
  readonly property color colUrg: "#E7365D"

  readonly property color colorHoverOverlay: "#22ffffff"

  property var workspaces: []
  property bool workspaceRefreshPending: false

  function parseTagStatus(status) {
    var parsed = [];
    var lines = status.trim().split("\n");

    for (var i = 0; i < lines.length; i++) {
      if (lines[i].length === 0) {
        continue;
      }

      var parts = lines[i].split("\t");
      var state = parts[0] || ".";
      var count = Number(parts[2] || 0);

      parsed.push({
        state: state,
        name: parts[1] || "",
        count: count,
        active: state === "#",
        urgent: state === "!",
        occupied: count > 0
      });
    }

    return parsed;
  }

  function refreshWorkspaces() {
    if (tagStatusProcess.running) {
      root.workspaceRefreshPending = true;
      return;
    }

    root.workspaceRefreshPending = false;
    tagStatusProcess.exec(tagStatusProcess.command);
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Process {
    id: tagStatusProcess
    command: [ "bash", "-c", "herbstclient tag_status | tr '\\t' '\\n' | while IFS= read -r tag; do [ -n \"$tag\" ] || continue; state=${tag:0:1}; name=${tag:1}; count=$(herbstclient attr \"tags.by-name.$name.client_count\" 2>/dev/null || echo 0); printf '%s\\t%s\\t%s\\n' \"$state\" \"$name\" \"$count\"; done" ]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        root.workspaces = root.parseTagStatus(text);

        if (root.workspaceRefreshPending) {
          root.refreshWorkspaces();
        }
      }
    }
  }

  Process {
    id: tagEventProcess
    command: [ "herbstclient", "--idle", "(tag_changed|tag_flags|tag_added|tag_removed|tag_renamed|reload)" ]
    running: true
    stdout: SplitParser {
      splitMarker: "\n"
      onRead: root.refreshWorkspaces()
    }
  }

  Process {
    id: tagSwitchProcess
  }

  Timer {
    interval: 1
    running: true
    repeat: false
    onTriggered: root.refreshWorkspaces()
  }

  PanelWindow {
    id: bar

    anchors {
      top: true
      left: true
      right: true
    }
    exclusiveZone: root.barHeight
    implicitHeight: root.barHeight
    color: root.colBg

    Rectangle {
      id: background

      anchors.fill: parent
      color: root.colBg

      Item {
        id: leftSection

        anchors {
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }

        RowLayout {
          anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
          }
          height: parent.height

          Repeater {
            model: SystemTray.items

            MouseArea {
              id: trayButton

              required property var modelData
              readonly property string fallbackText: {
                var text = modelData.tooltipTitle || modelData.title || modelData.id || "?";
                return text.length > 0 ? text[0].toUpperCase() : "?";
              }

              Layout.preferredWidth: root.trayItemSize
              Layout.preferredHeight: root.trayItemSize
              acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
              hoverEnabled: true

              function openMenu() {
                if (!modelData.hasMenu) {
                  return false;
                }

                var point = mapToItem(background, width / 2, height);
                modelData.display(bar, point.x, point.y);

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
                color: trayButton.containsMouse ? root.colorHoverOverlay : root.colBg
              }

              IconImage {
                id: trayIcon

                anchors.centerIn: parent
                width: root.trayItemSize
                height: root.trayItemSize
                implicitSize: root.trayItemSize
                source: trayButton.modelData.icon
              }
            }
          }
        }
      }

      Item {
        id: centerSection

        anchors {
          horizontalCenter: parent.horizontalCenter
          top: parent.top
          bottom: parent.bottom
        }

        Text {
          anchors.centerIn: parent
          color: root.colOn
          font.pixelSize: 16
          text: Qt.formatDateTime(clock.date, "ddd MMM d  HH:mm:ss")
        }
      }

      Item {
        id: rightSection

        anchors {
          right: parent.right
          top: parent.top
          bottom: parent.bottom
          rightMargin: 10
        }

        RowLayout {
          anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
          }

          Repeater {
            model: root.workspaces

            MouseArea {
              id: workspaceButton

              required property var modelData

              Layout.preferredWidth: 8
              Layout.preferredHeight: 16
              acceptedButtons: Qt.LeftButton
              hoverEnabled: true

              onClicked: tagSwitchProcess.exec([ "herbstclient", "use", modelData.name ])

              Rectangle {
                anchors.fill: parent
                color: root.colBg
              }

              Text {
                id: workspaceLabel

                anchors.centerIn: parent
                color: modelData.urgent ? root.colUrg : modelData.active ? root.colOn : modelData.occupied ? root.colHalf : root.colOff
                font.pixelSize: 16
                text: modelData.name
              }
            }
          }
        }
      }
    }
  }
}
