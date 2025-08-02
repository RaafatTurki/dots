.pragma library

function parseTimestamp(timestamp) {
  const parts = timestamp.split(":");

  if (parts.length !== 2) {
    return -1;
  }

  const minutes = Number(parts[0]);
  const seconds = Number(parts[1]);

  if (!isFinite(minutes) || !isFinite(seconds)) {
    return -1;
  }

  return minutes * 60 + seconds;
}

// Returns [{ time, text }] sorted by time, one entry per timestamp tag.
function parseSyncedLyrics(text) {
  const parsed = [];
  const rows = String(text || "").split("\n");
  const pattern = /\[([0-9]{1,2}:[0-9]{2}(?:\.[0-9]{1,3})?)\]/g;

  for (let i = 0; i < rows.length; i++) {
    const row = rows[i].trim();
    const lyric = row.replace(pattern, "").trim();
    let match;

    pattern.lastIndex = 0;
    while ((match = pattern.exec(row)) !== null) {
      const time = parseTimestamp(match[1]);

      if (time >= 0) {
        parsed.push({ time: time, text: lyric });
      }
    }
  }

  parsed.sort(function(a, b) {
    return a.time - b.time;
  });

  return parsed;
}
