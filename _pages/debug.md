---
title: "Jekyll Debugging"
layout: single
permalink: /debug/
author_profile: true
---

This page has a lot of content on it and generally runs slowly. Only slog through it if you need to!

## Inspect a Variable

Output the content of a variable with the `inspect` keyword.

```liquid
{{ "{{ site | inspect " }}}}
```

## Jekyll Variables

### `site` Object

```json
{{ site | inspect | replace: '&quot;', '"' }}
```

### `collection` Object

```json
{
  "label": "collection_name",
  "files": [],
  "directory": "/srv/jekyll/_collection_name",
  "output": true,
  "docs": [
    "Page content as HTML",
    "Page content as HTML"
  ],
  "relative_directory": "_collection_name",
  "permalink": "/:collection/:path/"
}
```
