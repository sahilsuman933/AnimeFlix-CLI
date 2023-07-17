#!/bin/bash

function query_nyaa() {
    local query=$(printf '%s' "$*" | tr ' ' '+')

    # Scrape the Nyaa Page and save it into scraped_data.txt
    curl -s "https://nyaa.iss.ink/?f=0&c=1_0&q=$query&s=downloads&o=desc" |
        pup "table > tbody > tr > td:nth-child(2) > a, table > tbody > tr > td:nth-child(3) > a:nth-child(2)" >>data.txt

    # Create a text file containing Anime Title and MagnetURL
    grep -oP '(?<=title=").+?(?=")' data.txt | grep -v "comment" >>anime_name.txt
    grep -oP 'magnet:[^"]+' data.txt >>anime_magnet.txt

    rm data.txt
}

function select_anime() {
    local animeNameLine=$(cat ./anime_name.txt | nl | fzf --with-nth 2.. | awk '{print $1}')
    animeName=$(cat ./anime_name.txt | sed -n "${animeNameLine}p")
    MagnetURL=$(cat ./anime_magnet.txt | sed -n "${animeNameLine}p")

    rm ./anime_name.txt ./anime_magnet.txt
}

function stream_or_download() {
    if echo "$animeName" | grep -q -E '\.(mkv|mp4|avi|mov)$'; then
        (webtorrent "$MagnetURL" --mpv)
    else
        index=$(webtorrent "$MagnetURL" --select | grep -vE "fetching torrent metadata from [0-9]+ peers|verifying existing torrent data...|To select a specific file, re-run 'webtorrent' with \"--select \[index\]\"|Example: webtorrent download \"magnet:...\" --select 0|webtorrent is exiting...|Select a file to download:|To select a specific file, re-run \`webtorrent\` with \"--select \[index\]\""   | fzf | awk '{print $1}')
        (webtorrent "$MagnetURL" --select $index --mpv)
    fi
}

if [ -z "$1" ]; then
    echo "Usage: $0 <search_query>"
    exit 1
fi

query_nyaa "$@"
select_anime
stream_or_download
