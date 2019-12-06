# Dota 2 In-House League Bi-week Stat Calculator

### REQUIREMENTS
==================================

1. Bash
2. Python
3. Java

### HOW TO USE
==================================

1. Edit config with the appropriate dotabuff players url for a league
2. Run command: `./dotabuff.sh` every 2 weeks or as necessary
3. Final text file will be under the "final/" folder as `YYYY-MM-DD.txt` or YYYY-MM-DD.csv`, which is the current date.
 
### CONFIGURATION + OTHER INFO
==================================

* Project can create .txt (Default) or .csv files
* To create a .csv file, set the csv from `false` to `true` in config
* Project can calculate total of ALL matches rather than just the ones that occur during a time period
* To do this, set the allMatches flag from `0` to `1` in config
* TODO - Maybe make this a Discord bot or something

### KNOWN POTENTIAL ISSUES
==================================
* Do not call the script multiple times within a short time fram (5 or so minutes between each call)
* Any files under the `YYYY-MM-DD.txt` or `YYYY-MM-DD.csv` for the current date will be overriden when the script is called.
* To resolve this, create backups of any previous data in a seperate directory

##### Developer(s): Camilo III P. Ortillo