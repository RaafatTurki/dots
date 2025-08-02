import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.services

// Two side-by-side cells, each with its percentage, the time left until it resets and
// a thin progress line underneath: the 5-hour session limit, then the weekly limit.
// Every field has a fixed width, so the cells never shift as the values change.
Row {
  id: root

  readonly property real now: clock.date.getTime()
  readonly property color tint: ClaudeUsage.failed ? Theme.colHalf : Theme.colOn
  readonly property real sessionRatio: ratio(ClaudeUsage.session, ClaudeUsage.sessionResetsAt)
  readonly property real weeklyRatio: ratio(ClaudeUsage.weekly, ClaudeUsage.weeklyResetsAt)

  visible: ClaudeUsage.session >= 0
  spacing: 10

  // "42m", "2h 13m" or "1d 4h"; empty once the reset time has passed.
  function timeLeft(resetsAt) {
    const minutes = Math.ceil((resetsAt - now) / 60000);
    if (minutes <= 0) {
      return "";
    }
    const days = Math.floor(minutes / 1440);
    const hours = Math.floor(minutes % 1440 / 60);
    if (days > 0) {
      return days + "d " + hours + "h";
    }
    return hours > 0 ? hours + "h " + minutes % 60 + "m" : minutes + "m";
  }

  // The cached usage is from before the reset, so a window past its reset is empty.
  function ratio(used, resetsAt) {
    return resetsAt > 0 && resetsAt <= now ? 0 : used;
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  // The widest each field can get; digits are measured as zeros.
  TextMetrics {
    id: percentMetrics
    font.pixelSize: Theme.usageLabelSize
    text: "000%"
  }

  TextMetrics {
    id: timeMetrics
    font.pixelSize: Theme.usageLabelSize
    text: "00h 00m"
  }

  component LimitCell: Item {
    id: cell

    property real ratio: 0
    property real resetsAt: 0

    implicitWidth: percentMetrics.width + 4 + timeMetrics.width
    implicitHeight: Theme.barHeight

    Text {
      id: percent
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        verticalCenterOffset: -1
      }
      width: percentMetrics.width
      horizontalAlignment: Text.AlignRight
      color: root.tint
      font.pixelSize: Theme.usageLabelSize
      font.bold: true
      text: Math.round(cell.ratio * 100) + "%"
    }

    Text {
      anchors {
        left: percent.right
        leftMargin: 4
        verticalCenter: percent.verticalCenter
      }
      color: Theme.colHalf
      font.pixelSize: Theme.usageLabelSize
      text: root.timeLeft(cell.resetsAt)
    }

    Rectangle {
      anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        bottomMargin: 2
      }
      height: Theme.usageBarHeight
      radius: height / 2
      color: Theme.colOff

      Rectangle {
        anchors {
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }
        width: parent.width * Math.min(1, cell.ratio)
        radius: parent.radius
        color: ClaudeUsage.failed ? Theme.colHalf : cell.ratio >= 0.9 ? Theme.colUrg : Theme.colOn
      }
    }
  }

  Text {
    anchors.verticalCenter: parent.verticalCenter
    color: root.tint
    font.pixelSize: Theme.fontSize
    // \u{f06a9} is the Nerd Font robot icon (nf-md-robot).
    text: "\u{f06a9}"
  }

  LimitCell {
    anchors.verticalCenter: parent.verticalCenter
    ratio: root.sessionRatio
    resetsAt: ClaudeUsage.sessionResetsAt
  }

  LimitCell {
    anchors.verticalCenter: parent.verticalCenter
    ratio: root.weeklyRatio
    resetsAt: ClaudeUsage.weeklyResetsAt
  }
}
