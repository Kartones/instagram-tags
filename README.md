# Instagram-Tags

Browse latest instagram photos by tags. Grabs N photos matching any of the specified tags and creates a simple HTML file
listing them (with links to original items).

## Getting Started

Just copy `config.sample.rb` to `config.rb`, fill your Client & token details (sorry, no oauth process coded,
must manually do before), and edit `main.rb` to setup your tags.

## Roadmap

* Rate limit error handling (not hit building this, though)
* AND logic to only add if 2+ tags present
* NOT logic to exlude if present any of 1+ tags

## No-Roadmap (aka "won't do")

* Better general error handling: Know what you type (filenames, tags, etc.)
* Better CSS: Call it minimalistic