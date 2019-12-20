import sys

config = open("config")
for i in range(2):
  line = config.readline().strip()
line = config.readline().strip()
line = line[line.index("=") + 1:]
sanitizeFlag = line.lower() == "1"
config.close()
rawDir = "raw/{}"
delimeter = ("\t", ",")[sanitizeFlag]
headers = delimeter.join(["ID", "Player", "Wins", "Losses", "KDA", "Kills", "Deaths", "Assists", "LH", "DN", "GPM", "XPM"])
filename = "{}/{}.{}".format("final", sys.argv[1][:sys.argv[1].index(".")], ("txt", "csv")[sanitizeFlag])

def createPlayersDict(inFile):
  inF = open(inFile)
  d = {}
  for line in inF:
    line = line.strip().split("\t")
    d[line[0]] = line[1:]
  inF.close()
  return d

def statDifference(playerID):
  global currentDict
  global previousDict
  currentStats = currentDict[playerID]
  previousStats = previousDict[playerID]
  biweekStats = []
  for i in range(len(currentStats)):
    try:
      biweekStats.append(double(currentStats[i]) - double(previousStats[i]))
    except:
      biweekStats.append(0)
  return biweekStats

def joinData(playerID, stats):
  data = sanitize(playerID)
  for stat in stats:
    data += sanitize(stat)
  return data + "\n"

def sanitize(aStr):
  global sanitizeFlag
  global delimeter
  if sanitizeFlag:
    return "\"{}\"{}".format(aStr, delimeter)
  else:
    return "{}{}".format(aStr, delimeter)

currentDict = createPlayersDict(rawDir.format(sys.argv[1]))
previousDict = None
if len(sys.argv) == 3:
  previousDict = createPlayersDict(rawDir.format(sys.argv[2]))
  
outF = open(filename, "w")
outF.write(headers + "\n")

for playerID in currentDict:
  if previousDict == None:
    outF.write(joinData(playerID, currentDict[playerID]))
  else:
    outF.write(joinData(playerID, statDifference(playerID)))
outF.close()
