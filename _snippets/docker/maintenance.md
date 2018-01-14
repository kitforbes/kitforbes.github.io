---
title: "Maintenance"
excerpt: "A selection of commands for cleaning up a Docker host."
child_collection: docker
---

**Stop all containers**

```bash
docker stop $(docker ps -aq)
```

**Remove all containers**

```bash
docker rm -f $(docker ps -aq)
```

**Attempt to Remove all images**

```bash
docker rmi $(docker images -q)
```

**Remove all containers and images**

```bash
docker rm -f $(docker ps -aq) && docker rmi $(docker images -q)
```

**Remove "dangling" images**

```bash
docker rmi $(docker images -f "dangling=true" -q)
```
