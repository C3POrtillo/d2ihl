#!/bin/bash

tagsoup="tagsoup-1.2.1.jar"
dump="dump"
raw="raw"
final="final"
useragent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30"
url="https://www.dotabuff.com/esports/leagues/11142-bd2l-season-3-na/players"
week=$(/bin/date +%V)
filename="players-$week"
scrapeFile="$dump/$filename"

# Create folder for xhtml/html files
if [ ! -d $dump ]; then
  mkdir -m 750 $dump
fi

# Create folder to log raw biweekly data
if [ ! -d $raw ]; then
  mkdir -m 750 $raw
fi

# Create folder to log parsed biweekly data
if [ ! -d $final ]; then
  mkdir -m 750 $final
fi

# Download tagsoup if missing
if [ ! -f $tagsoup ]; then
  curl "http://vrici.lojban.org/~cowan/XML/tagsoup/$tagsoup" --output "$tagsoup"
fi

# Curl Dotabuff html, convert to xhtml
cd "$dump"
if [ ! -f "$filename.html" ]; then
  cd ..
  curl -A "$useragent" "$url" --output "$scrapeFile.html"
  java -jar "$tagsoup" --files "$scrapeFile.html"
else
  cd ..
fi

# Parse xhtml and create a raw text file
python3 raw.py "$scrapeFile.xhtml" "$raw"

# Create final file (.csv or .txt) for spreadsheet import
files=($(ls $raw | sort))
if ((${#files[@]} > 1)); then
  python3 final.py "${files[-1]}" "${files[-2]}" "$raw" "$final"
else
  python3 final.py "${files[-1]}" "$raw" "$final"
fi

# Remove temporary files (Optional)
# rm $tagsoup
# rm -rf $dump