import sys
import xml.dom.minidom as minidom
from datetime import date

document = minidom.parse(sys.argv[1])
saveFolder = sys.argv[2]
today = date.today().strftime("%Y-%m-%d")
delimeter = "\t"
filename = "{}/{}.txt".format(saveFolder, today)

def getPlayerData(tr):
  """Returns a string containing a player's statistics from a tr element"""
  ret = ""
  writeID = True
  for td in tr.getElementsByTagName("td"):
    if writeID:
      ret += delimitString(getID(td))
      writeID = False
    elif td.hasAttribute("class") and td.getAttribute("class") not in ["player-name", "r-tab r-group-1"] and td.hasAttribute("data-value"):
      ret += delimitString(td.getAttribute("data-value"))
    else:
      ret += getSpans(td)
  return ret + "\n"

def getSpans(td):
  """Returns a player's esport's name, wins, and losses from a td element"""
  ret = ""
  for span in td.getElementsByTagName("span"):
    if span.hasAttribute("class"):
      if span.getAttribute("class") in ["player-text player-text-full", "wins", "losses"]:
        if span.hasChildNodes:
          for node in span.childNodes:
            if node.nodeType == node.TEXT_NODE:
              ret += delimitString(node.nodeValue)
  return ret

def getID(td):
  """Returns a player's unique ID from an a element"""
  for a in td.getElementsByTagName("a"):
    if a.hasAttribute("class") and a.getAttribute("class") == "esports-player esports-link player-link" and a.hasAttribute("href"):
      hrefValue = a.getAttribute("href").split("/")[-1]
      hrefValue = hrefValue.split("-")[0]
      return hrefValue

def delimitString(aStr):
  """Sanitize a string for a csv if necessary"""
  return "{}{}".format(aStr, delimeter)

outF = open(filename, "w", encoding="utf-8")
for table in document.getElementsByTagName("table"):
  if table.hasAttribute("class") and table.getAttribute("class") == "table sortable table-striped table-condensed r-tab-enabled":
    for tbody in table.getElementsByTagName("tbody"):
      for tr in tbody.getElementsByTagName("tr"):
        outF.write(getPlayerData(tr))
