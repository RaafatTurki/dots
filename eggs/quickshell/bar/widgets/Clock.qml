import QtQuick
import Quickshell
import qs

Text {
  color: Theme.colOn
  font.pixelSize: Theme.fontSize
  text: Qt.formatDateTime(clock.date, "ddd MMM d  HH:mm:ss")

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
