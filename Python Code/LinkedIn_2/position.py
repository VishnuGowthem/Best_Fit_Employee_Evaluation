'''
@author: jayakumara
position - All files in a dir
'''
from itertools import chain
import json
import csv
import os
import sys
import time
import datetime

dicts = list()

def json_to_csv(top_dir, output_file_path):
    print "Top Dir - " + top_dir
    print "O/P file - " + output_file_path + "\n\n"
    print "List of files in the dir\n"
    objects = list()

    for root, dirs, files in os.walk(top_dir):
        for f in files:
            if os.path.join(root, f).endswith((".json")):
                with open(os.path.join(root, f)) as input_file:
                    json_str = input_file.read()
                    print(os.path.join(root, f))
                    objects = json.loads(json_str)
                    dicts.extend(json_to_dicts(objects))

    with open(output_file_path, "wb") as output_file:
        dicts_to_csv(dicts, output_file)


def json_to_dicts(objects):
    position_list = list()
    
    for employee in objects:
        for position in employee.get('positions', ''):
            position['public-profile-url'] = employee.get('public-profile-url', '')
            position_list.append(position)
            
    return position_list


def dicts_to_csv(source, output_file):
    def build_row(dict_obj, keys):
        return [dict_obj.get(k) for k in keys]

    keys = sorted(set(chain.from_iterable([o.keys() for o in source])))
    rows = [build_row(d, keys) for d in source]

    cw = csv.writer(output_file)
    cw.writerow(keys)

    for row in rows:
        cw.writerow([c.encode('utf-8') if isinstance(c, str)
                     or isinstance(c, unicode) else c for c in row])


def write_csv(headers, rows, file):
    cw = csv.writer(file)
    cw.writerow(headers)

    for row in rows:
        cw.writerow([c.encode('utf-8') if isinstance(c, str)
                     or isinstance(c, unicode) else c for c in row])


def get_std_time(ts):
    return datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')

########################
# print "Start Time: " + get_std_time(time.time()) + "\n" 
# dir = "C:\\Users\\jayakumara\\Downloads\\1339943811\\test"
# outputCSV = "C:\\Users\\jayakumara\\Downloads\\1339943811\\test\\employeeInfo.csv"
#   
# json_to_csv(dir, outputCSV)
# 
# print "End Time: " + get_std_time(time.time()) + "\n"
########################

########################
if __name__ == '__main__':
    args = sys.argv
    if len(args) == 3:
        print "Start Time: " + get_std_time(time.time()) + "\n"
        json_to_csv(args[1], args[2])
        print '\nFinished\n'
        print "End Time: " + get_std_time(time.time()) + "\n"
    else:
        print 'Usage:'
        print 'python position.py "{JSON_ROOT_DIR}" "{OUTPUT_FILE_NAME}"'
########################