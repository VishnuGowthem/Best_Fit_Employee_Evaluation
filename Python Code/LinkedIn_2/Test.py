'''
Created on Mar 17, 2015

@author: jayakumara
'''
from itertools import chain
import json
import csv
from pprint import pprint
# import StringIO
import sys

# Scripts cols
# cols = ['public-profile-url', 'last-name', 'first-name', 'industry', 'num-connections', 'location', 'summary']
# cols = ['public-profile-url', 'educations']

def json_to_csv(input_file_path, output_file_path):
    with open(input_file_path) as input_file:
        json = input_file.read()
    dicts = json_to_dicts(json)    
    with open(output_file_path, "w") as output_file:
        dicts_to_csv(dicts, output_file)
        pprint(dicts)
        sys.exit(0)

def json_to_dicts(json_str):
    objects = json.loads(json_str)
    
#     def to_single_dict(lst):
#         result = {}
#         for d in lst:
#             for k in d.keys():
#                 result[k] = d[k]
#         return result;

    return [dict(to_keyvalue_pairs(obj)) for obj in objects]

def to_keyvalue_pairs(source, ancestors=[], key_delimeter='_'):
    def is_sequence(arg):
        return (not hasattr(arg, "strip") and hasattr(arg, "__getitem__") or hasattr(arg, "__iter__"))

    def is_dict(arg):
        return hasattr(arg, "keys")

    if is_dict(source):
        result = [to_keyvalue_pairs(source.get(key, ''), ancestors + [key]) for key in source.keys()]
        return list(chain.from_iterable(result))
    elif is_sequence(source):
        result = [to_keyvalue_pairs(item, ancestors + [str(index)]) for (index, item) in enumerate(source)]
        return list(chain.from_iterable(result))
    else:
        return [(key_delimeter.join(ancestors), source)]

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


# if __name__ == '__main__':
#     args = sys.argv
#     if len(args) == 3:
#         json_to_csv(args[1], args[2])
#         print 'Finished'
#     else:
#         print 'Usage:'
#         print 'python json2csv.py "{JSON_FILE_PATH}" "{OUTPUT_FILE_PATH}"'        
