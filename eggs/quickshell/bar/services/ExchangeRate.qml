pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// USD to IQD rate on the Baghdad parallel market, from IQWealth (iraqsm.com).
Singleton {
  id: root

  // IQD per 1 USD; 0 until the first successful read.
  property int sell: 0
  property int buy: 0
  // IQWealth hasn't had a fresh market reading.
  property bool stale: false
  // The last refresh failed, so the values may be from an older cached response.
  property bool failed: false
  property string publishedAt: ""

  function refresh() {
    if (!fetchProcess.running) {
      fetchProcess.running = true;
    }
  }

  Process {
    id: fetchProcess
    command: [ Quickshell.shellPath("scripts/fx.sh"), Quickshell.cachePath("iqwealth-fx.json") ]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        try {
          const parallel = JSON.parse(text).data.parallel;

          root.sell = parallel.sell;
          root.buy = parallel.buy;
          root.stale = parallel.stale === true;
          root.publishedAt = parallel.publishedAt || "";
        } catch (error) {
          // Nothing cached yet, or an unexpected response: keep the last values.
        }
      }
    }
    onExited: function(exitCode) {
      root.failed = exitCode !== 0;
    }
  }

  // Free key: 100 requests a day, and fx.sh caches for 30 minutes.
  Timer {
    interval: 30 * 60 * 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }
}
