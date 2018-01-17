---
title: "Jekyll Themes Using `absolute_url` on Docker"
excerpt: "Using Docker for Windows to serve a Jekyll site has a few issues that you need to be careful of to correctly link assets."
categories:
  - articles
---

## The Problem
While working on adding the [Minimal Mistakes][3] theme to my blog, I was unable to serve the content of my Jekyll site locally through Docker. From looking at the source of the theme files, it looked like it was the `absolute_url` filter that was causing the issue. I confirmed this by overwriting one of the layout files and changing the URLs to use `prepend: base_url`.

## The Fix
As `absolute_url` would be a commonly used approach, I started looking for a fix that wouldn't involve changing the underlying themes. It took me some time, but I eventually came across a [post by Toby Ho][1] that I highly recommend reading if you want more detail on the context.

My issue was very similar to the one outlined by Tony. For me, this involved a couple of small adjustments to address.

I was already overwriting the `url` during local development, so all I did there was rename the file from `_config_local.yml` to `_config.docker.yml` - as Tony had done - because I liked the naming pattern more.

**./_config.docker.yml**
```yaml
url: http://localhost:4000
```

I then extracted my Docker commands from the `site.bat` file into a Docker Compose file to make things more readable. The key takeaway from this is that the `JEKYLL_ENV` must be a value other than `development`. I believe this is where I went wrong, as I wasn't explicitly setting the `JEKYLL_ENV` inside the container itself.

**./docker-compose.yml**
```yaml
version: '3'
services:
  site:
    environment:
      JEKYLL_ENV: docker
    image: jekyll/jekyll
    volumes:
      - .:/srv/jekyll
    ports:
      - 4000:4000
    command: >
      jekyll serve \
        --watch \
        --force_polling \
        --config  _config.yml,_config.docker.yml
```

Finally, I updated my `site.bat` file to trigger the `docker-compose` commands rather than the `docker` commands that I had previously.

**./site.bat**
```powershell
@if '%1' EQU 'up' (
    rm -rf "%~dp0_site"
    docker-compose up -d
    if ERRORLEVEL 0 goto DONE
    goto FAILED
)

@if '%1' EQU 'down' (
    docker-compose down
    if ERRORLEVEL 0 goto DONE
    goto FAILED
)
```

## Conclusion
As always, working on Windows isn't as straight forward as it seems to be on Linux or Mac, but the fix in this case was quite simple.

With those minor adjustments in place, the Jekyll site is now served on `localhost:4000` with assets being linked correctly. My exact change can by seen in this [commit][2] on GitHub.

## References
* [Jekyll, Docker, Windows, and 0.0.0.0][1]
* [Minimal Mistakes][3]

<!-- References -->
[1]: https://tonyho.net/jekyll-docker-windows-and-0-0-0-0/
[2]: https://github.com/kitforbes/kitforbes.github.io/commit/b4f8236835edfe1913ac596c22a5068c6c8f9e9d
[3]: https://mademistakes.com/work/minimal-mistakes-jekyll-theme/
