'''
@author: jayakumara
Basic Info
'''
from itertools import chain
import json
import csv

def json_to_csv(input_file_path, output_file_path):
    with open(input_file_path) as input_file:
        json = input_file.read()
        
    dicts = json_to_dicts(json)
        
    with open(output_file_path, "w") as output_file:
        dicts_to_csv(dicts, output_file)


def json_to_dicts(json_str):
    objects = json.loads(json_str)
    employee_list = list()
    
    for employee in objects:
        employee_dict = {
            'public-profile-url' : employee.get('public-profile-url', ''),
            'last-name' : employee.get('last-name', ''),
            'first-name' : employee.get('first-name', ''),
            'industry' : employee.get('industry', ''),
            'num-connections' : employee.get('num-connections', ''),
            'location' : employee.get('location', ''),
            'summary' : employee.get('summary', ''),
            'skills': ";".join(employee.get('skills', list()))
        }
        employee_list.append(employee_dict)

    return employee_list

def dicts_to_csv(source, output_file):
    def build_row(dict_obj, keys):
        return [dict_obj.get(k) for k in keys]
    
    keys = sorted(set(chain.from_iterable([o.keys() for o in source])))
    rows = [build_row(d, keys) for d in source]

    cw = csv.writer(output_file)
    cw.writerow(keys)
    
    for row in rows:
        cw.writerow([c.encode('utf-8') if isinstance(c, str) or isinstance(c, unicode) else c for c in row])

def write_csv(headers, rows, file):
    cw = csv.writer(file)
    cw.writerow(headers)
    
    for row in rows:
        cw.writerow([c.encode('utf-8') if isinstance(c, str) or isinstance(c, unicode) else c for c in row])


inputJSON = "C:\\Users\\jayakumara\\Downloads\\1339943811\\a-2.json"
outputCSV = "C:\\Users\\jayakumara\\Downloads\\1339943811\\employeeInfo.csv"

json_to_csv(inputJSON, outputCSV)