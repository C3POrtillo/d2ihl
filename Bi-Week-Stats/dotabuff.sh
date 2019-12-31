#!/bin/bash
# Curls a given Dotabuff league for its Most Successful Players Table

source ./config

tagsoup="tagsoup-1.2.1.jar"
useragent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30"
date=$(date "+%Y-%m-%d")
currentWeek=$(date "+%V")
scrapeFile="dump/$date-$currentWeek"

# Create the necessary folders for files
for dir in "dump" "raw" "final"; do
  if [ ! -d $dir ]; then
    mkdir -m 750 $dir
  fi
done

Download tagsoup if missing
if [ ! -f $tagsoup ]; then
  curl "http://vrici.lojban.org/~cowan/XML/tagsoup/$tagsoup" --output "$tagsoup"
fi

# Check if source has been updated if download exists
zflag=()
if [ -e "$scrapeFile.html" ]; then
  zflag=("-z" "$scrapeFile.html")
fi

curl -A "$useragent" "$url" -o "$scrapeFile.html" ${zflag[@]}
java -jar "$tagsoup" --files "$scrapeFile.html"

# Parse xhtml and create a raw text file
python3 raw.py "$scrapeFile.xhtml"

# Create final file (.csv or .txt) for spreadsheet import
files=($(ls raw/ | sort))
if ((${#files[@]} > 1 && $allMatches == 0)); then
  lastDay="last $day"
  dotw=$(date -d today +%u)
  dotwNum=$(date -d $day +%u) 
  if (( ($currentWeek % 2 == 0 && $dotw >= ($dotwNum + 1) ) || ($currentWeek % 2 == 1 && $dotw < ($dotwNum + 1) ) )); then
    lastDay+="7 days ago"
  fi
  compare=$(date -d "$lastDay" +%Y-%m-%d-%V)
  python3 final.py "${files[-1]}" "$compare.txt"
else  
  python3 final.py "${files[-1]}"
fi
