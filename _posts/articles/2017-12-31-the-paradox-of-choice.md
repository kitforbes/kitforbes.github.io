---
title: "The Paradox of Choice"
excerpt: "Making decisions is the hardest thing to do at times."
categories:
  - articles
---

Throughout the year I've jumped between many different personal projects without finishing any of them. There are a number of reasons why this has been the case.

I have always been bad at focusing on a task when it is purely down to my own motivation. Additionally, having too many things to work on leaves me struggling to decide which project to work on - similar to when you spend an evening looking through Netflix for something to watch rather than watching something!

When I need to learn something new for work, I'll tend to jump on to that topic and may not return to the previous one for some time, if at all.

My intention is to make these projects public, as a bit of a portfolio, so I am often concerned about the presentation of my work or I'm not satisfied with the quality.

## This Year

Here are some of the things that I worked on through the year.

### Terraform Wrapper

A C# command line tool to wrap over Terraform's binary to improve the workflow of Terraform and integrate it with other tools.

### Terraform Environments in AWS and Azure

A modular configuration for launching environments into AWS and Azure. This included the creation of Consul, Vault, and Nomad clusters.

### DotNet Core Applications

* A Console Application to explore the new processes.
* An ASP .NET API to aggregate information from a number of different APIs.
* Windows containers using Docker for immutable deployments.

### Chef Cookbooks

* Learned the basics of Ruby.
* Worked on a boilerplate cookbook incorporating recipes, unit tests, integration tests, and a CI pipeline

### Ansible Playbooks

Idempotent playbooks for installing Consul, Packer, Terraform, Vault, and Nomad.

### Docker Containers

* Docker container for Ansible and Packer, to create AWS AMIs without installing the binaries.
* Docker container for GitHub Pages/Jekyll, to easily develop a Jekyll site locally.

### PowerShell Modules

Modules created through dotsourced PowerShell functions as well as through C# assemblies.

### Vagrant

* Numerous Vagrantfiles for different development and hosting environments.
* Primarily running on Hyper-V to work with Docker for Windows.

### GitHub Pages Blog

Modified Jekyll templates to add custom features.

## Next Year

In the coming year, I'd like to make more of an effort to plan - and actually finish - a small selection of projects. Here are my initial thoughts on what I would like to tackle.

### GitHub Pages

I should abandon my custom blog and just settle on a pre-made theme. I may return to making my own in the future - perhaps in a few years - but for now I just want it to look better than the default Jekyll theme.

* Investigate available themes.
* Migrate files into new theme.

### Terraform Environment in AWS and Azure

Complete my work with Terraform by establishing a basic configuration for my AWS and Azure accounts. It should:

* Layout a network between the two clouds, connected with an optional VPN.
* Initialize a Consul, Nomad, and Vault cluster.
* Configuration management handled by Ansible.
* Store remote state in S3, bootstrapped from a separate configuration.

### Dotnet Core Microservices

Create a microservice in Dotnet Core. What the microservice will do, I don't know. At the moment, it doesn't matter.

* A CI pipeline in Circle CI.
* Artifacts stored in MyGet/DockerHub.
* Deployed into the cloud through Terraform, and deployed locally for development with Docker and/or Vagrant.
* Generate versioned API documentation with Swagger and Swashbuckle.

### Game

Since going to university on a Games Development degree, I haven't actually made any. I'd like to start working on one this year.

This is a project that will take a long time, so I don't expect to complete it in 2018.

## Resolutions

I've never been the type to bother with new year's resolutions, but I'll use it this year to make an agreement with myself for my personal projects. Going forward, I intend to:

* develop projects in public.
* tackle one project at a time.
* not worry about mistakes - fix them later.
* deploy projects early and add features later.
