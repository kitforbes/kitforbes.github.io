# [kitforbes.github.io][site]

## Theme
This site uses the [Minimal Mistakes][theme] created by Michael Rose.

## Usage
This site can not be tested locally when using Docker, which the `site.bat` file depends upon. This is due to the use of the `absolute_url` Liquid filter within the theme that will serve files on `0.0.0.0` rather than `127.0.0.1`. I will look into fixing this at some point.

<!-- References -->
[site]: https://kitforbes.github.io
[theme]: https://mademistakes.com/work/minimal-mistakes-jekyll-theme/
