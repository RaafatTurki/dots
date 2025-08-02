import QtQuick
import QtQuick.Layouts
import qs.services

RowLayout {
  Repeater {
    model: Workspaces.items

    WorkspaceButton {}
  }
}
