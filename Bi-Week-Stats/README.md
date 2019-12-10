# Dota 2 In-House League Bi-week Stat Calculator

### Requirements:
=================

1. Bash
2. Python
3. Java

### Config Variables:
=================
1. url: The players url for a league - A String

   EX: `"https://www.dotabuff.com/esports/leagues/11440-d2ihl-season-1/players"`

2. csv: A flag that creates a `csv` file instead of a `txt` file 

   EX: `0` for `txt` files, `1` for `csv` files

3. allMatches: A flag that calculates statistics for all player data, rather than as a difference between two time periods

   EX: `0` for calculate bi-week difference, `1` for calculate total stats
   
4. day: the day of the week to anchor on
   
   EX: `thursday` means the last day of the biweek period ends on a thursday and starts on a friday


### How to use:
=================
1. Run command: `./dotabuff.sh` 
2. Final text file will be under the `final/` folder as `YYYY-MM-DD-WW.txt` or `YYYY-MM-DD-WW.csv`, which is the current date and the week of the year.
 
### Other
=================

* TODO - Maybe make this a Discord bot or something


##### Developer(s): Camilo III P. Ortillo