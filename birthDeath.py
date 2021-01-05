def convertTxt(txtFile):
 txtData = open(txtFile,'r')
 txtText = txtData.read()
 txtArray = []
 txtArray2 = txtText.splitlines()
 for i in range(0, len(txtArray2)):
 tempArray = txtArray2[i].split(" ")
 ranking = tempArray.pop(0)
 for j in range(0, len(tempArray)):
 tempArray[j].strip()
 if tempArray[j] != "" and tempArray[j] != " ":
 stringArray = tempArray[j].split(", ")
 firstWordArray = stringArray[0].split()
 firstWord = " ".join(firstWordArray)
 first = stringArray.pop(0)
 stringArray.insert(0, firstWord)
 if len(stringArray) == 2:
 stringArray.reverse()
 string = " ".join(stringArray)
 else:
 string = ", ".join(stringArray)
 txtArray.append(string)
 return txtArray

def combineTxt(txtBirth, txtDeath):
 birthArray = convertTxt(txtBirth)
 deathArray = convertTxt(txtDeath)
 completeArray = []
 for i in range(0, len(birthArray)):
 if i%2 == 0:
 for j in range(0, len(deathArray)):
 if deathArray[j] == birthArray[i]:
 completeArray.append(birthArray[i])
 completeArray.append(birthArray[i+1])
 completeArray.append(deathArray[j+1])
 return completeArray

def writeTxt(txtBirth, txtDeath, txtNew):
 array = combineTxt(txtBirth, txtDeath)
 string = "_".join(array)
 newFile = open(txtNew,"w")
 newFile.write(string) 
 newFile.close()

writeTxt("rawdata_2054.txt", "rawdata_2066.txt", "birthDeath.txt")
