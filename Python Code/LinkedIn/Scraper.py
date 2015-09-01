import json, csv

jsonFilePath = "C:\\Users\\jayakumara\\Downloads\\1339943811\\a-2.json"

json_data = open(jsonFilePath, encoding="UTF-8")
data = json.load(json_data)

employeeInfo = list()
education = list()
positions = list()
skills = list()

for index, employee in enumerate(data):
    tempList = [
        employee.get('public-profile-url', ''),
        employee.get('last-name', ''),
        employee.get('first-name', ''),
        employee.get('industry', ''),
        employee.get('num-connections', ''),
        employee.get('location', ''),
        employee.get('summary', ''),
    ]
    
    tempList = [val.encode('UTF-8') for val in tempList]
    employeeInfo.append(tempList)
    
    

# pprint(employeeInfo)

csvFilePath = "C:\\Users\\jayakumara\\Downloads\\1339943811\\employeeInfo.csv"    
with open(csvFilePath, 'w') as fileOpener:
    fileWriter = csv.writer(fileOpener, delimiter= ',')
    fileWriter.writerows(employeeInfo)
    
# pprint(data)
json_data.close()