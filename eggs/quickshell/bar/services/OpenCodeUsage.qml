pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// OpenCode Go usage limits, from the local opencode server's usage endpoint,
// the meters behind the console's usage page: the 5-hour rolling limit, the
// weekly limit and the monthly allowance.
Singleton {
  id: root

  // Fractions of each limit used, 0-1; -1 until the first successful read.
  property real rolling: -1
  property real weekly: -1
  property real monthly: -1
  // When each window resets, in ms since the epoch; 0 when the window hasn't started.
  property real rollingResetsAt: 0
  property real weeklyResetsAt: 0
  property real monthlyResetsAt: 0
  // True when the server reports a limit is used up.
  property bool rollingLimited: false
  property bool weeklyLimited: false
  property bool monthlyLimited: false
  // The last refresh failed, so the values may be from an older cached response.
  property bool failed: false

  function refresh() {
    if (!fetchProcess.running) {
      fetchProcess.running = true;
    }
  }

  Process {
    id: fetchProcess
    command: [ Quickshell.shellPath("scripts/opencode-usage.sh"), Quickshell.cachePath("opencode-usage.json") ]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        try {
          const usage = JSON.parse(text);
          const go = usage.go;

          root.rolling = (go.rolling?.percent ?? 0) / 100;
          root.weekly = (go.weekly?.percent ?? 0) / 100;
          root.monthly = (go.monthly?.percent ?? 0) / 100;
          // Before the rolling window starts, the server reports it resetting five
          // hours from now; a 0% window hasn't started, so keep its reset time empty.
          root.rollingResetsAt = root.rolling > 0 ? go.rolling?.resetsAt ?? 0 : 0;
          // The weekly and monthly windows are calendar-based, so their reset
          // times are meaningful even at 0%.
          root.weeklyResetsAt = go.weekly?.resetsAt ?? 0;
          root.monthlyResetsAt = go.monthly?.resetsAt ?? 0;
          root.rollingLimited = go.rolling?.limited ?? false;
          root.weeklyLimited = go.weekly?.limited ?? false;
          root.monthlyLimited = go.monthly?.limited ?? false;
        } catch (error) {
          // Nothing cached yet, or an unexpected response: keep the last values.
        }
      }
    }
    onExited: function(exitCode) {
      root.failed = exitCode !== 0;
    }
  }

  // opencode-usage.sh caches for 2 minutes.
  Timer {
    interval: 2 * 60 * 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }
}
