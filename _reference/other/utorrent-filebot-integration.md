---
title: "uTorrent Filebot Integration"
categories: Other
---

Disable the annoying pushers in uTorrent with the following steps.

Go to **Options** > **Preferences** > **Advanced**, **Run Program** and
enter the below into **Run this program when a torrent finishes**.

```plaintext
filebot -script fn:amc --action copy --conflict auto --output "E:/Media" -non-strict --log-file "E:/amc.log" --def artwork=n music=n backdrops=n clean=y excludeList=E:/amc.txt plex=127.0.0.1:32400 gmail=username:password movieFormat="{plex}" seriesFormat="{plex}" animeFormat="{plex}" musicFormat="{plex}" "ut_label=%L" "ut_state=%S" "ut_title=%N" "ut_kind=%K" "ut_file=%F" "ut_dir=%D"
```

Or for general purpose use without uTorrent:

```plaintext
filebot -script fn:amc --action move --conflict auto --output "E:/Media" -non-strict "C:\SourceDirectory" --log-file "E:/amc.log" --def artwork=n music=n backdrops=n clean=y excludeList=E:/amc.txt plex=127.0.0.1:32400 gmail=username:password movieFormat="{plex}" seriesFormat="{plex}" animeFormat="{plex}" musicFormat="{plex}"
```
