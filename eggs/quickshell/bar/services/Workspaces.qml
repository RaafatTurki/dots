pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// herbstluftwm tags, kept in sync via `herbstclient --idle`.
Singleton {
  id: root

  property var items: []
  property bool refreshPending: false

  function switchTo(name) {
    switchProcess.exec([ "herbstclient", "use", name ]);
  }

  function parseTagStatus(status) {
    const parsed = [];
    const lines = status.trim().split("\n");

    for (let i = 0; i < lines.length; i++) {
      if (lines[i].length === 0) {
        continue;
      }

      const parts = lines[i].split("\t");
      const state = parts[0] || ".";
      const count = Number(parts[2] || 0);

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

  function refresh() {
    if (statusProcess.running) {
      root.refreshPending = true;
      return;
    }

    root.refreshPending = false;
    statusProcess.exec(statusProcess.command);
  }

  Process {
    id: statusProcess
    command: [ "bash", "-c", "herbstclient tag_status | tr '\\t' '\\n' | while IFS= read -r tag; do [ -n \"$tag\" ] || continue; state=${tag:0:1}; name=${tag:1}; count=$(herbstclient attr \"tags.by-name.$name.client_count\" 2>/dev/null || echo 0); printf '%s\\t%s\\t%s\\n' \"$state\" \"$name\" \"$count\"; done" ]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        root.items = root.parseTagStatus(text);

        if (root.refreshPending) {
          root.refresh();
        }
      }
    }
  }

  Process {
    id: eventProcess
    command: [ "herbstclient", "--idle", "(tag_changed|tag_flags|tag_added|tag_removed|tag_renamed|reload)" ]
    running: true
    stdout: SplitParser {
      splitMarker: "\n"
      onRead: root.refresh()
    }
  }

  Process {
    id: switchProcess
  }

  Component.onCompleted: root.refresh()
}
