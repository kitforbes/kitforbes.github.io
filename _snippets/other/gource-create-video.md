---
title: "Create Video from Gource"
excerpt: "Turn your Git commit history into a video."
child_collection: other
---

Gource can generate output streams which can be converted into video files.

```batch
rem Change values as appropriate.
gource -1024x768 --stop-position 1.0 --highlight-all-users --hide-filenames --seconds-per-day 5 --output-framerate 60 --output-ppm-stream output.ppm

rem Convert PPM stream to WMV.
ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i output.ppm  -vcodec wmv1 -r 60 -qscale 0 out.wmv
```
