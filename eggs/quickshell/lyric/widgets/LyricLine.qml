import QtQuick
import qs

Text {
  // Lines away from the active line; 0 is the active line.
  property int distance: 0

  height: Theme.lineHeight
  horizontalAlignment: Text.AlignHCenter
  verticalAlignment: Text.AlignVCenter
  color: distance === 0 ? Theme.colorForeground : Theme.colorMuted
  opacity: Math.max(0.32, 1 - (distance * 0.22))
  elide: Text.ElideRight
  maximumLineCount: 1
  font.pixelSize: Theme.fontSize
  font.weight: distance === 0 ? Font.DemiBold : Font.Medium

  Behavior on opacity {
    NumberAnimation {
      duration: 240
      easing.type: Easing.OutCubic
    }
  }
}
