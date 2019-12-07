#!/bin/bash
# Curls a given Dotabuff league for its Most Successful Players Table
source ./config

# Create the necessary folders for files
for dir in "dump" "raw" "final"; do
  if [ ! -d $dir ]; then
    mkdir -m 750 $dir
  fi
done

# Download tagsoup if missing
if [ ! -f $tagsoup ]; then
  curl "http://vrici.lojban.org/~cowan/XML/tagsoup/$tagsoup" --output "$tagsoup"
fi

curl -A "$useragent" "$url" --output "$scrapeFile.html"
java -jar "$tagsoup" --files "$scrapeFile.html"

# Parse xhtml and create a raw text file
python3 raw.py "$scrapeFile.xhtml"

# Create final file (.csv or .txt) for spreadsheet import

files=($(ls raw/ | sort))
if ((${#files[@]} > 1 && !$allMatches == 1)); then
  python3 final.py "${files[-1]}" "${files[-2]}"
else  
  python3 final.py "${files[-1]}"
fi
