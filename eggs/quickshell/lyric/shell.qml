import QtQuick
import Quickshell

Scope {
  Component.onCompleted: {
    Qt.application.name = "quickshell-lyrics";
    Qt.application.displayName = "quickshell-lyrics"; // qmllint disable missing-property
  }

  LyricsWindow {}
}
