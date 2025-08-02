import QtQuick
import qs
import qs.services

// The free IQWealth key requires attribution with a link, so clicking opens the site.
MouseArea {
  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight
  visible: ExchangeRate.sell > 0
  acceptedButtons: Qt.LeftButton

  onClicked: Qt.openUrlExternally("https://iraqsm.com")

  Text {
    id: label

    anchors.centerIn: parent
    color: ExchangeRate.stale || ExchangeRate.failed ? Theme.colHalf : Theme.colOn
    font.pixelSize: Theme.fontSize
    // Quoted the local way: thousands of IQD per 100 USD (1705 IQD/USD -> 170.5).
    // \u{f0116} is the Nerd Font cash-multiple icon (nf-md-cash_multiple).
    text: "\u{f0116} " + Number((ExchangeRate.sell / 10).toFixed(1))
  }
}
