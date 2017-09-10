---
title: "GitHub Pages and Hover"
---

One of the tasks for migrating from Blogger to GitHub Pages was to reconfigure the DNS
settings with my hosting provider, [Hover][1]. GitHub has written a fair amount of
[documentation][2] on how to do this in a variety of setups.

## Update DNS records on Hover.com

* Login and navigate to the DNS section of your domain.
* Select "Reset to default" to remove previous changes.
* Remove Hover's default A record with the "@" host value.
* Add CNAME forwards with a "www" host for the GitHub address with and without trailing slash.
* Add GitHub A records with "@" host for "192.30.252.153" and "192.30.252.154"

![Hover DNS dashboard after changes][hover-dns]

## Add CNAME to repository

* Create a `CNAME` file in the repository root
* Add the desired URL to the file

<!-- References -->
[1]: https://www.hover.com/ "Hover.com"
[2]: https://help.github.com/articles/using-a-custom-domain-with-github-pages/ "Using a Custom Domain with GitHub Pages"

<!-- Images -->
[hover-dns]: /assets/images/articles/hover-dns.png "Hover DNS dashboard after changes"
