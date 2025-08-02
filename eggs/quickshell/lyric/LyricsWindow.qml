pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs
import qs.services
import qs.widgets

// Quickshell's qmltypes only expose stubs for PanelWindow and screen, so qmllint
// flags valid code here; the qmllint disable comments silence those false positives.
PanelWindow { // qmllint disable uncreatable-type
  id: root

  anchors {
    top: true
  }
  margins.top: 150 // qmllint disable missing-property
  exclusiveZone: 0
  aboveWindows: false
  focusable: false
  implicitWidth: Math.min(Theme.panelWidth, screen.width - 24) // qmllint disable missing-property
  implicitHeight: Theme.panelHeight
  color: Theme.colorTransparent
  mask: Region {}

  function lyricDistance(index) {
    const active = Math.max(Lyrics.activeLineIndex, 0);
    return Math.abs(index - active);
  }

  function scrollAnchorIndex() {
    const active = Math.max(Lyrics.activeLineIndex, 0);
    const lastCenteredIndex = Math.max(0, Lyrics.lines.length - 3);

    return Math.min(Math.max(active, 2), lastCenteredIndex);
  }

  Item {
    id: lyricViewport

    anchors.fill: parent
    clip: true

    Text {
      anchors.centerIn: parent
      width: parent.width
      horizontalAlignment: Text.AlignHCenter
      color: Theme.colorMuted
      elide: Text.ElideRight
      maximumLineCount: 1
      font.pixelSize: Theme.fontSize
      font.weight: Font.DemiBold
      visible: Lyrics.lines.length === 0
      text: Lyrics.statusText || "..."
    }

    Column {
      id: lyricColumn

      width: parent.width
      visible: Lyrics.lines.length > 0
      y: (lyricViewport.height / 2) - ((root.scrollAnchorIndex() + 0.5) * Theme.lineHeight)

      Behavior on y {
        NumberAnimation {
          duration: 420
          easing.type: Easing.OutCubic
        }
      }

      Repeater {
        model: Lyrics.lines

        LyricLine {
          required property var modelData
          required property int index

          width: lyricColumn.width
          distance: root.lyricDistance(index)
          text: modelData.text || ""
        }
      }
    }
  }
}
