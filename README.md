# AnimeFlix CLI

AnimeFlix CLI is a command-line interface (CLI) program that allows you to search for anime and stream it using webtorrent. The program fetches anime information from Nyaa and lets you select the anime to watch it.

## Prerequisites

Before using AnimeFlix CLI, make sure you have the following installed on your system:

- [curl](https://curl.se/)
- [pup](https://github.com/ericchiang/pup)
- [fzf](https://github.com/junegunn/fzf)
- [webtorrent-cli](https://github.com/webtorrent/webtorrent-cli)
- [mpv](https://mpv.io/) (optional, required for streaming video files)

## Installation

1. Clone this repository to your local machine:

```bash
git clone https://github.com/your_username/AnimeFlix-CLI.git
cd AnimeFlix-CLI
```

2. Make the script executable

```bash
chmod +x animeflix.sh
```

3. Install the required dependencies (if you haven't already): Please follow the respective links provided in the "Prerequisites" section to install the required tools.

## Usage

To search for and watch an anime with a multi-word title, enclose the query in quotes, for example:

```bash
  ./anime_stream.sh "Attack on Titan"
```

**Note**: The script relies on Nyaa as the data source. In case Nyaa is unreachable or unavailable, the search functionality may not work.
