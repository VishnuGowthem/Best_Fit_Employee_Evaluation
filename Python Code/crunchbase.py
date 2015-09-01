import json
import urllib2
file_data = open('distinct-company-shortname.csv', 'r').readlines()
#file_data = ['Accent Micro Technologies Inc.']
for organization_link in file_data:
	data_array = []
	data = {}
	organization_link = organization_link.rstrip('\n')
	organization_link1 = organization_link.replace(' ', '%20')
	url_string = 'https://api.crunchbase.com/v/2/organization/' + organization_link1 + '?user_key=0a05febe23c0476693ccd361d72324a4'
	print url_string
	try:
		response = urllib2.urlopen(url_string)
		data = json.load(response)
	except:
		print "Exception"
		continue
	output_filehandle = open('out.csv', 'a')
	data_array.append(organization_link)
	if('name' in data['data']['properties']):
		data_array.append(data['data']['properties']['name'].encode('ASCII', 'ignore').strip("\n"))
	else :
		data_array.append("")
	if('type' in data['data']):
		data_array.append(data['data']['type'])
	else :
		data_array.append("")
	if('short_description' in data['data']['properties']):
		data_array.append(data['data']['properties']['short_description'].encode('ASCII', 'ignore').strip("\n"))
	else:
		data_array.append("")
	if('founded_on' in data['data']['properties']):
		data_array.append(str(data['data']['properties']['founded_on'].encode('ASCII', 'ignore').strip("\n")))
	else:
		data_array.append("")
	if('founded_on_trust_code' in data['data']['properties']):
		data_array.append(str(data['data']['properties']['founded_on_trust_code']))
	else:
		data_array.append("")
	if('num_employees_max' in data['data']['properties']):
		data_array.append(str(data['data']['properties']['num_employees_max']))
	else:
		data_array.append("")
	if('num_employees_min' in data['data']['properties']):
		data_array.append(str(data['data']['properties']['num_employees_min']))
	else:
		data_array.append("")
	if('total_funding_usd' in data['data']['properties']):
		data_array.append(str(data['data']['properties']['total_funding_usd']))
	else:	
		data_array.append("")
	if('number_of_investments' in data['data']['properties']):
		data_array.append(str(data['data']['properties']['number_of_investments']))
	else:
		data_array.append("")
	if('number_of_employees' in data['data']['properties']):
		data_array.append(str(data['data']['properties']['number_of_employees']))
	else:
		data_array.append("")
	data_string = ','.join(data_array)
	print data_string
	output_filehandle.write(data_string)
	output_filehandle.write("\n")	
	output_filehandle.close()

