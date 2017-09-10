---
title: "SSH Tunnel"
categories: Bash
---

A nice simple way to view a web UI on something like Consul is with an SSH Tunnel.

```bash
# Usage:
ssh -i "<path-to-private-key>" -N -f -L \
  <local-port>:<remote-loopback-address>:<remote-port> \
  <user>@<host>

# Example:
ssh -i "/home/user/.ssh/id_rsa.pem" -N -f -L \
  9000:localhost:8500 \
  centos@1.2.3.4

# In a browser, go to 'localhost:9000'
```
