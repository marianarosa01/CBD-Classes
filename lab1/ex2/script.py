

countingNames = {}
data = [line.strip() for line in open("names.txt", 'r')]
for name in data:
    firstLetter = name[0]
    if firstLetter in countingNames:
        lastCount = countingNames.get(firstLetter)
        countingNames[firstLetter] = lastCount + 1
    else:
        countingNames[firstLetter] = 1

for key, value in countingNames.items() :
    print (key, value)
    f = open ('results.txt','w')
    
with open ('results_initials','w') as doc_writer:
    for key, value in countingNames.items() :
        doc_writer.write(f"SET {key}  {value}\n")