pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// Claude subscription usage limits, from the endpoint behind Claude Code's `/usage`.
Singleton {
  id: root

  // Fractions of each limit used, 0-1; -1 until the first successful read.
  property real session: -1
  property real weekly: -1
  // When each window resets, in ms since the epoch; 0 when the window hasn't started.
  property real sessionResetsAt: 0
  property real weeklyResetsAt: 0
  // The last refresh failed, so the values may be from an older cached response.
  property bool failed: false

  function refresh() {
    if (!fetchProcess.running) {
      fetchProcess.running = true;
    }
  }

  Process {
    id: fetchProcess
    command: [ Quickshell.shellPath("scripts/claude-usage.sh"), Quickshell.cachePath("claude-usage.json") ]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        try {
          const usage = JSON.parse(text);

          // A window with no usage yet comes back as null.
          root.session = (usage.five_hour?.utilization ?? 0) / 100;
          root.weekly = (usage.seven_day?.utilization ?? 0) / 100;
          root.sessionResetsAt = Date.parse(usage.five_hour?.resets_at) || 0;
          root.weeklyResetsAt = Date.parse(usage.seven_day?.resets_at) || 0;
        } catch (error) {
          // Nothing cached yet, or an unexpected response: keep the last values.
        }
      }
    }
    onExited: function(exitCode) {
      root.failed = exitCode !== 0;
    }
  }

  // claude-usage.sh caches for 2 minutes.
  Timer {
    interval: 2 * 60 * 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }
}
