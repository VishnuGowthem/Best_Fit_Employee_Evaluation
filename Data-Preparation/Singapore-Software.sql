SELECT DISTINCT position."company-name"
FROM employee,
	position
WHERE employee."public-profile-url" = position."public-profile-url"
	AND lower(employee.location) LIKE '%singapore%'
	AND (
		lower(employee.industry) LIKE '%information%'
		OR lower(employee.industry) LIKE '%informati%'
		OR lower(employee.industry) LIKE '%computer%'
		OR lower(employee.industry) LIKE '%telecom%'
		OR lower(employee.industry) LIKE '%network%'
		)
LIMIT 5


SELECT DISTINCT location, count(*) cnt
FROM employee
WHERE 		
		lower(employee.industry) LIKE '%informati%'
		OR lower(employee.industry) LIKE '%computer%'
		OR lower(employee.industry) LIKE '%telecom%'
		OR lower(employee.industry) LIKE '%network%'
		OR lower(employee.industry) LIKE '%software%'
		OR lower(employee.industry) LIKE '%internet%'
		OR lower(employee.industry) LIKE '%data%'
		OR lower(employee.industry) LIKE '%web%'	
		OR lower(employee.industry) LIKE '%system%'		
group by
	location
order by cnt desc
	
