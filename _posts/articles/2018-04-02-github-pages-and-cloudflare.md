---
title: "GitHub Pages and Cloudflare"
excerpt: "Enabling HTTPS on GitHub Pages with a custom domain using Cloudflare."
categories:
  - articles
tags:
  - github-pages
  - cloudflare
  - hover
---

When I first migrated my blog to GitHub Pages back in 2016, I [wrote a small piece]({% post_url 2016-09-17-github-pages-and-hover %}) on the process for using a custom domain name supplied by [Hover][1]. What I neglected to do, was enable HTTPS.

HTTPS is enabled by default on a GitHub Pages site, but not if you have a custom domain name attached. This is clearly stated on the Settings page of your GitHub repository. I missed this, or chose to ignore it.

With the recent focus on having HTTPS everywhere, I thought it was time to remedy this.

## Securing With Cloudflare

To start, I signed up for a free account on [Cloudflare][2]. This was a very easy process and they clearly guide you through every step. They even detect all of the records attached to your domain to tell you which ones Cloudflare will manage and which will remain with the registrar.

Continuing through the step by step guide, Cloudflare now gives us a clear diff on what we need to change to redirect the nameservers.

![Nameserver changes suggested by Cloudflare][cloudflare-nameservers]

## Nameservers on Hover

To change the nameservers, I just logged in to my account on Hover and accessed the settings for my domain.

1. Log in to Hover and navigate to the domain
1. Scroll down to **Nameservers** in the left-hand panel
1. Click **Edit**
1. Update the nameservers:
  * `ns1.hover.com` to `kai.ns.cloudflare.com`
  * `ns2.hover.com` to `kay.ns.cloudflare.com`
1. Click **save nameservers**

## Enforcing HTTPS

Back on Cloudflare, while we wait for the DNS settings to propagate, we need to turn on HTTPS on all requests. This is very straight forward for a blog where we want HTTPS everywhere.

1. Go to the **Crypto** section
1. Scroll down to the **Always use HTTPS** option
1. Toggle this to **On**

It may take a day for the certificate to actually show on your site. This is mentioned on the **Crypto** page under **SSL**.

## Rewriting HTTP Traffic

For safety, we want to enable automatic HTTPS reqriting to capture any lingering mixed content.

1. Go to the **Crypto** section
1. Scroll down to the **Automatic HTTPS Rewrites** option
1. Toggle this to **On**

## Enforcing Modern TLS

An optional step is to enforce modern TLS protocols to increase security. This makes the connections more secure, but it may disable access from visitors with older browsers. As I don't have any readers, this really isn't a concern for me!

1. Go to the **Crypto** section
1. Scroll down to the **Require Modern TLS** option
1. Toggle this to **On**

## Conclusion

Cloudflare makes it very easy to secure a GitHub Pages site with a custom domain at no extra cost!

<!-- References -->
[1]: https://www.hover.com/ "Hover.com"
[2]: https://www.cloudflare.com/ "Cloudflare.com"

<!-- Images -->
[cloudflare-nameservers]: /assets/images/articles/cloudflare-nameservers.png "Nameserver Changes Suggested by Cloudflare"
