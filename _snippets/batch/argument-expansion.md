---
title: "Argument Expansion"
excerpt: "Expand arguments in Batch files to get file names, paths, extensions, etc."
child_collection: batch
---

Replace `n` with argument number (`0`, `1`, etc).
Most useful when working with `%0`, the Batch file itself.

- `%~n`  - expands `%n` removing any surrounding quotes (")
- `%~fn` - expands `%n` to a fully qualified path name
- `%~dn` - expands `%n` to a drive letter only
- `%~pn` - expands `%n` to a path only
- `%~nn` - expands `%n` to a file name only
- `%~xn` - expands `%n` to a file extension only
