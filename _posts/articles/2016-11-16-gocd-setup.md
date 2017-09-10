---
title: "Getting Started with GoCD"
---

[GoCD][1] from ThoughtWorks, is an open source build server which puts more
emphasis on the continuous delivery process than just continuous integration.

We've decided to start using GoCD at work, and I've been looking at preparing
the infrastructure and installation with Packer and Terraform; More on those later.
I initially looked at hosting both the GoCD Server and GoCD Agents within Docker
containers, but had an odd issue with SSH that set me back a bit.
Until I GoCD back to figure out what I did wrong, I decided to deploy GoCD on CentOS
the old fashioned way.

## Installation
GoCD has pretty good [documentation][2], which made a nice change from some other
documentation that I've been reading through recently. I have now scripted the
installation on CentOS and installed GoCD manually on Windows.
While the documentation is nice, it still lacks a lot of information to improve
the initial user experience. Once I have spent more time with GoCD,
I'll make some contributions to help improve things where I can.
A lot of my hurdles are likely due to my lack of experience with Linux.

### GoCD Server
To help give people a leg up, I'll share the installation script that I'm using
to create my Packer image. Before this script, I `sudo yum -y update` and
disable SE Linux with `sudo setenforce permissive` as it interferes with GoCD's
installation process. It'll be back on after a restart.

```sh
echo "
[gocd]
name     = GoCD YUM Repository
baseurl  = https://download.go.cd
enabled  = 1
gpgcheck = 1
gpgkey   = https://download.go.cd/GOCD-GPG-KEY.asc
" | sudo tee /etc/yum.repos.d/gocd.repo
sudo yum -y install curl git go-server

# The next steps in my script failed without the below sleep.
sudo sleep 60
```

### Plugins
With the server installed, we now want to grab all of the plugins.
I'll show an example with the [Yaml config plugin][3].

```sh
GOCD_PLUGINS_DIR=/var/lib/go-server/plugins/external
VERSION=0.2.0

sudo curl -sL -o $GOCD_PLUGINS_DIR/yaml-config-plugin-$VERSION.jar \
  https://github.com/tomzo/gocd-yaml-config-plugin/releases/download/$VERSION/yaml-config-plugin-$VERSION.jar
```

Change ownership of the plugins to the `go` user that was added by the install.

```sh
sudo chown -R go:go $GOCD_PLUGINS_DIR
```

At this point, you may want to copy over some configuration files,
such as an initial password file, `cruise-config.xml`, or additional plugin
configuration. I'll come back to this at a later time once I have refined it.

### Prepare Git
Next, we'll generate an SSH key for the server.

```sh
GOCD_SSH_DIR=/var/go/.ssh

sudo mkdir $GOCD_SSH_DIR
echo "
github.com,192.30.253.112 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
" | sudo tee $GOCD_SSH_DIR/known_hosts
sudo ssh-keygen -q -t rsa -b 4096 -C "gocd" -f $GOCD_SSH_DIR/id_rsa -N ''

# Change ownership to go user.
sudo chown -R go:go $GOCD_SSH_DIR

# Output the public key to make your life easier...
sudo cat $GOCD_SSH_DIR/id_rsa.pub
```

### Cleanup
We now need to relabel the filesystem as we disabled SE Linux earlier.
The `sleep` is needed for Packer to maintain a connection after a restart.

```sh
sudo touch /.autorelabel
sudo reboot
sudo sleep 60
```

With all of that done, we now have a basic GoCD installation on CentOS,
with plugins installed and Git ready to use.
Access the web UI at `localhost:8153`.

<!-- References -->
[1]:  https://www.go.cd/ "GoCD"
[2]:  https://docs.go.cd/current/ "GoCD Documentation"
[3]:  https://github.com/tomzo/gocd-yaml-config-plugin "Yaml Config Plugin"
