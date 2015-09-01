select
	url,
	timetocommute,
	num-connections,
	companyname,
	title,
	pastexperience,
	duration,
	degreescore,
	schoolscore,
	overallrating,
	culture,
	leadership,
	compensation,
	career,
	worklife,
	recommend,
	maxemployees,
	minemployees,
	totalfunding,
	investments,
	employees,
	overallpast,
	culturepast,
	leadershippast,
	compensationpast, 
	careerpast,
	worklifepast,
	recommendpast,
	maxemployeespast,
	minemployeespast,
	totalfundingpast, 
	investmentspast,
	employeespast,
	(overallrating-overallpast)*(6-overallrating)
	(culture-culturepast)*(6-culture)
	(leadership-leadershippast)*(6-leadership)
	(compensation-compensationpast)*(6-compensation)
	(career-careerpast)*(6-career)
	(worklife-worklifepast)*(6-worklife)
	(recommend-recommendpast)*(6-recommend),
from
(
select 
	employee."public-profile-url" url,
	employee."first-name" firstname,
	employee."last-name" lastname,
	employee."skills" skills,
	employee."location" location,
	'10' timetocommute,
	employee."num-connections" num-connections,
	position."company-name" companyname,
	position_details."company-name" ,
	position_details."title",
	position_details."past_experience" pastexperience, 
	position_details.duration duration,
	education_details.degree,
	isnull(education_details.degree_score,1) degreescore,
	education_details.field_of_study,
	education_details.school_name,
	isnull(education_details.school_score,1) schoolscore,
	education_details.grad_date,
	glassdoor.glassdoorName,
	isnull(glassdoor.overall_rating,1) overallrating,
	isnull(glassdoor.culture_value_rating,1) culture,
	isnull(glassdoor.senior_leadership_rating,1) leadership,
	isnull(glassdoor.compensation_benefits_rating,1) compensation,
	isnull(glassdoor.career_opportunities_rating,1) career,
	isnull(glassdoor.worklife_balance_rating,1) worklife,
	isnull(glassdoor.recommend_to_friend_rating,1) recommend,
	glassdoor.crunchbase_founded_on_trust_code,
	isnull(glassdoor.crunchbase_num_employees_max,1) maxemployees,
	isnull(glassdoor.crunchbase_num_employees_min,1) minemployees,
	isnull(glassdoor.crunchbase_total_funding_usd,1) totalfunding,  
	isnull(glassdoor.crunchbase_number_of_investments,1) investments,
	isnull(glassdoor.crunchbase_number_of_employees,1) employees,
	glassdoor_past.glassdoorName glassdoorName_past,
	isnull(glassdoor_past.overall_rating,1) overallpast,
	isnull(glassdoor_past.culture_value_rating,1) culturepast ,
	isnull(glassdoor_past.senior_leadership_rating,1) leadershippast,
	isnull(glassdoor_past.compensation_benefits_rating,1) compensationpast, 
	isnull(glassdoor_past.career_opportunities_rating,1) careerpast,
	isnull(glassdoor_past.worklife_balance_rating,1) worklifepast,
	isnull(glassdoor_past.recommend_to_friend_rating,1) recommendpast,
	glassdoor_past.crunchbase_founded_on_trust_code crunchbase_founded_on_trust_code_past,
	isnull(glassdoor_past.crunchbase_num_employees_max,1) maxemployeespast,
	isnull(glassdoor_past.crunchbase_num_employees_min,1) minemployeespast,
	isnull(glassdoor_past.crunchbase_total_funding_usd,1) totalfundingpast, 
	isnull(glassdoor_past.crunchbase_number_of_investments,1) investmentspast,
	isnull(glassdoor_past.crunchbase_number_of_employees,1) employeespast
from
	position_details
		join position on (position_details."public-profile-url" = position."public-profile-url" and position_details."title" = position."title" and position_details."start-date" = position."start-date")
	
		join employee on position."public-profile-url" = employee."public-profile-url" 
		left join education_details on employee."public-profile-url" = education_details.public_profile_url
		join linkedin_company_shortname_map_temp on position."company-name" = linkedin_company_shortname_map_temp.actualname 
		join glassdoor on linkedin_company_shortname_map_temp.shortname = glassdoor.input
	
		join (select distinct "public-profile-url", "company-name" company_name from position) position_past on (position_details."public-profile-url" = position_past."public-profile-url" and trim(replace(lower(substr(position_past.company_name,1,6)), ",", "-")) = position_details.past_company) 
		join linkedin_company_shortname_map_temp linkedin_company_past on position_past.company_name = linkedin_company_past.actualname 
		join glassdoor glassdoor_past on linkedin_company_past.shortname = glassdoor_past.input
)		

