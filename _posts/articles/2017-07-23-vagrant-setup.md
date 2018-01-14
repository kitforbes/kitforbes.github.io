---
title: "Getting Started with Vagrant and Ansible"
excerpt: "Using Vagrant to create an Ansible control node on Windows."
categories:
  - articles
---

Over the past year, I've been working a lot with [Packer][1] and [Terrafrom][2] from HashiCorp. Terraform is a tool for managing your infrastructure as code and Packer is a tool for building Virtual Machines (VMs) and Containers in a consistent manner. I'll write about my experiences with these in the future. Creating Linux images with Packer is very straight forward; Windows is a lot more involved. Once the connection between Packer and the instance has been established with WinRM (which is the first hurdle), you then need to install and configure everything you need. This can be done with Batch files, PowerShell, PowerShell DSC (Desired State Configuration), or a configuration management tool. I started out with PowerShell, but quickly decided to go ahead and try using a configuration management tool instead.

I took a look at [Ansible][3], [Salt][4], [Chef][5], and [Puppet][6] to see what would be best for my situation. I chose Ansible over the others as it has very few requirements. Once it has been installed on a "Control" machine, you can manage machines purely over SSH or WinRM with no additional dependencies.

The only issue I had getting started was that Ansible can only be installed on Linux. I do all of my development on Windows machines, so this was a bit of a stumbling block. To easily get around this I decided to start using [Vagrant][7] to host a Linux VM on my Windows development machine.

## Vagrant

Vagrant is an abstraction over VM providers that allows easy provisioning and management of VMs from one place. My plan was to describe a CentOS machine that I could use as my Ansible controller. As I also use Docker for Windows - which requires Hyper-V - I wanted to use Hyper-V as my provider for Vagrant.

To get going, I installed Vagrant with Chocolatey (`choco install -y vagrant`) and rebooted to get everything ready. I ran `vagrant init` in my repository root to create a standard `Vagrantfile` to hold my configuration.

I modified the `Vagrantfile` to use CentOS 7 under the Hyper-V provider

**Vagrantfile**

```ruby
Vagrant.configure("2") do |config|
  config.vm.define "control" do |control|
    control.vm.box = "centos/7"
    control.vm.provider "hyperv" do |machine|
      machine.vmname = "centos-control"
    end
  end
end
```

There are currently some limitations with the Hyper-V provider that you need to bear in mind. One of which is not being able to define the virtual network from Vagrant. This means that you need to go into Hyper-V Manager and create an external virtual switch to which you can attach all of your Vagrant VMs during start up. In the right hand panel of Hyper-V Manager, select **Virtual Switch Manager** and then **Create Virtual Switch**. Give it an appropriate name and you're good to go.

With this configuration in place, I was able to test that everything was working by simply running `vagrant up` from the same directory as the `Vagrantfile`. As this was my first time using the `centos/7` box, the file had to be downloaded. Once the VM was up and running I was then able to connect to the machine with `vagrant ssh` and start doing all things Linux.

Another issue I had is that Vagrant is supposed to sync your working directory to `/vagrant` on the guest machine by default. For some reason this wasn't the case for me, so I installed `rsync` on my host machine, and added the following line to my configuration.

**Vagrantfile**

```ruby
control.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: ".git/"
```

Using SMB as synced folder type would be a better choice, but it does not clean up after itself at the moment.

With the modified configuration in place, I applied the changes with `vagrant reload`, which restarts the machine with the changes. I can then see my working directory in the VM in the `/vagrant` directory. This is not a bi-directional link, however. So when you want to update the files on the guest from the host you need to run `vagrant rsync`.

## Provisioning

Now that we have a VM up and running, we want to set it up the way that we'd like. We first want to pass some files and environment variables to the guest. This can be done with the following additions.

**Vagrantfile**

```ruby
$set_environment_variables = <<SCRIPT
tee "/etc/profile.d/ansible.sh" > "/dev/null" <<EOF
export ANSIBLE_STDOUT_CALLBACK=debug
EOF

tee "/etc/profile.d/aws.sh" > "/dev/null" <<EOF
export AWS_DEFAULT_REGION=#{ENV['AWS_DEFAULT_REGION']}
export AWS_ACCESS_KEY_ID=#{ENV['AWS_ACCESS_KEY_ID']}
export AWS_SECRET_ACCESS_KEY=#{ENV['AWS_SECRET_ACCESS_KEY']}
EOF
SCRIPT
```

```ruby
control.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
control.vm.provision "file", source: "~/.ssh/id_rsa", destination: ".ssh/id_rsa"
control.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: ".ssh/id_rsa.pub"

control.vm.provision "shell", run: "always", inline: $set_environment_variables
```

This will allow us to work with AWS and Git in the same way as we would from our host machine. Defining the script in this manner will also handle being executed more than once, which is what we are aiming for with all of this.

## Provisioning with Ansible

The next step is installing Ansible on the guest - which will act as our Control machine - and provisioning it with an Ansible playbook. This will run in "local" mode, which means it will be executing against itself. This is very handy for getting all of the requirements onto the machine.

**Vagrantfile**

```ruby
control.vm.provision "ansible_local" do |ansible|
  ansible.provisioning_path = "/vagrant"
  ansible.playbook = "provision.yml"
  ansible.install_mode = "pip"
  # At the moment, Packer can't work with Ansible above 2.2.1.0. Version 2.4 has a fix for this issue.
  ansible.version = "2.2.1.0"
  ansible.verbose = true
end
```

If we create an Ansible Playbook in the root directory, then we'll be ready to start modifying the machine with a Configuration Management approach.

**provision.yml**

```yaml
---
- name: provision
  hosts: control
  connection: local

  tasks:
  - name: Ensure Git is installed
    yum:
      name: git
      state: present
```

**inventory.ini**

```ini
[control]
127.0.0.1
```

The Ansible local provisioner will install Ansible for us if it detects that it is not already installed on the machine. Specifying a version can only be done when installing with Python Pip. This saves us from creating a script to install Ansible as well as all of it's requirements.

I won't put the full Ansible Playbook content here as there's a lot involved in installing Packer, Terraform, and other packages in an immutable manner. I might show that off later if I go in to more detail on how Ansible roles are structured.

## Conclusion

With all of this in place, we now have a `Vagrantfile` which can create a local CentOS instance capable of running Ansible. There are a few more small steps needed to use Ansible with Packer, but we'll cover that another time.

THe beauty of working with Vagrant is that it's very easy to throw away a VM and start afresh. Just `vagrant destroy -f` and `vagrant up` to start with a clean slate. This gives the freedom to experiment without the worry of harming your own machine.

Vagrant is certainly something I will be using across more projects to easily isolate and manage development dependencies.

<!-- References -->
[1]:  https://www.packer.io/ "Packer"
[2]:  https://www.terraform.io/ "Terraform"
[3]:  https://www.ansible.com/ "Ansible"
[4]:  https://saltstack.com/ "Salt Stack"
[5]:  https://www.chef.io/ "Chef"
[6]:  https://puppet.com/ "Puppet"
[7]:  https://www.vagrantup.com/ "Vagrant"
