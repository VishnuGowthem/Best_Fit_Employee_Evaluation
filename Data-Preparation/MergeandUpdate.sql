create table glassdoor (input text, glassdoorName text, overall_rating integer, culture_value_rating integer, senior_leadership_rating integer, compensation_benefits_rating integer, career_opportunities_rating integer, worklife_balance_rating integer, recommend_to_friend_rating integer)

select count(*)
from (
select
	education."public-profile-url",
	max(education."degree"),
	max(education."field-of-study"),
	max(education."school-name"),
	max(a.maxdate)
from
	education,
	(select 
		"public-profile-url" url,
		max(DATE("end-date")) maxdate,
		count(*) count
	from
		education
	group by
		"public-profile-url") a
where
	a.url = education."public-profile-url" and
	a.maxdate = education."end-date"
group by
	education."public-profile-url"
)

create table education_details (public_profile_url text, degree text, field_of_study text, school_name text, grad_date text);


SELECT "public-profile-url-2",
	"company-name-2",
	"title-2",
	"start-date-2",
	"end-date-2",
	ifnull(enddate, 2015) - ifnull(startdate, 2015) years
FROM (
	SELECT "public-profile-url-2",
		"company-name-2",
		"title-2",
		"start-date-2",
		"end-date-2",
		cast(substr("start-date", 1, 4) AS INTEGER) startdate,
		cast(substr("end-date", 1, 4) AS INTEGER) enddate
	FROM graph
	WHERE "company-name" != "company-name-2"
		AND "public-profile-url" = "public-profile-url-2"
	ORDER BY "public-profile-url",
		"start-date",
		"end-date"
	)

update education_details set degree_score = (case when (lower(degree) like '%mas%' or lower(degree) like '%ms%' or lower(degree) like '%ph%' or lower(degree) like '%mba%') then 5 when (lower(degree) like '%bach%' or lower(degree) like '%be%'  or lower(degree) like '%tech%' or lower(degree) like '%bs%') then 3 else 1 end);

update education_details set school_score = length(school_name)%5


CREATE TABLE position_details(
  "public-profile-url" TEXT,
  "company-name" TEXT,
  "title" TEXT,
  "start-date" TEXT,   
  "end-date" TEXT,
  "past_company" TEXT,
  "past_experience" INTEGER
);

update position_details set duration = ifnull(cast(substr("end-date", 1, 4) AS INTEGER), 2015) - ifnull(cast(substr("start-date", 1, 4) AS INTEGER), 2015)

	update position_details set duration = case when duration = 0 then 1 else duration end

update position_details set duration = 4 where duration = -2011;
update position_details set duration = 3 where duration = -2012;
update position_details set duration = 8 where duration = -2007;
update position_details set duration = 5 where duration = -2010;
update position_details set duration = 6 where duration = -2009;
update position_details set duration = 7 where duration = -2008;
update position_details set duration = 13 where duration = -2002;
update position_details set duration = 9 where duration = -2006;
update position_details set duration = 10 where duration = -2005;
update position_details set duration = 11 where duration = -2004;
update position_details set duration = 14 where duration = -2001;
update position_details set duration = 12 where duration = -2003;
update position_details set duration = 15 where duration = -2000;
update position_details set duration = 16 where duration = -1999;
update position_details set duration = 17 where duration = -1998;
update position_details set duration = 18 where duration = -1997;
update position_details set duration = 19 where duration = -1996;
update position_details set duration = 20 where duration = -1995;
update position_details set duration = 21 where duration = -1994;
update position_details set duration = 22 where duration = -1993;
update position_details set duration = 24 where duration = -1991;
update position_details set duration = 25 where duration = -1990;
update position_details set duration = 27 where duration = -1988;
update position_details set duration = 41 where duration = -1974;

create table crunchbase (
shortname text,
name text,
type text,
short_description text,
founded_on text,
founded_on_trust_code integer,
num_employees_max integer,
num_employees_min integer,
total_funding_usd integer,
number_of_investments integer,
number_of_employees integer
)

.import crunchbase.csv crunchbase

CREATE TABLE glassdoor_copy as select * from glassdoor


alter table glassdoor add column crunchbase_type text
alter table glassdoor add column crunchbase_founded_on text
alter table glassdoor add column crunchbase_founded_on_trust_code integer;
alter table glassdoor add column crunchbase_num_employees_max integer;
alter table glassdoor add column crunchbase_num_employees_min  integer;
alter table glassdoor add column crunchbase_total_funding_usd integer;
alter table glassdoor add column crunchbase_number_of_investments integer;
alter table glassdoor add column crunchbase_number_of_employees integer;


update glassdoor set crunchbase_type = (select cb.type from crunchbase cb where glassdoor.input = cb.shortname) 
where exists (select cb.type from crunchbase cb where glassdoor.input = cb.shortname) 

update glassdoor set crunchbase_founded_on = (select crunchbase.founded_on from crunchbase where glassdoor.input = crunchbase.shortname) where exists (select crunchbase.founded_on from crunchbase where glassdoor.input = crunchbase.shortname) 

update glassdoor set crunchbase_founded_on_trust_code = (select crunchbase.founded_on_trust_code from crunchbase  where glassdoor.input = crunchbase.shortname) where exists (select crunchbase.founded_on_trust_code from crunchbase where glassdoor.input = crunchbase.shortname) 

update glassdoor set crunchbase_num_employees_max = (select crunchbase.num_employees_max from crunchbase  where glassdoor.input = crunchbase.shortname) 
where exists (select crunchbase.num_employees_max from crunchbase where glassdoor.input = crunchbase.shortname) 

update glassdoor set crunchbase_num_employees_min = (select crunchbase.num_employees_min from crunchbase  where glassdoor.input = crunchbase.shortname) 
where exists (select crunchbase.num_employees_min from crunchbase where glassdoor.input = crunchbase.shortname) 

update glassdoor set crunchbase_total_funding_usd = (select crunchbase.total_funding_usd from crunchbase  where glassdoor.input = crunchbase.shortname) 
where exists (select crunchbase.total_funding_usd from crunchbase where glassdoor.input = crunchbase.shortname) 

update glassdoor set crunchbase_number_of_investments = (select crunchbase.number_of_investments from crunchbase  where glassdoor.input = crunchbase.shortname) 
where exists (select crunchbase.number_of_investments from crunchbase where glassdoor.input = crunchbase.shortname) 

update glassdoor set crunchbase_number_of_employees = (select crunchbase.number_of_employees from crunchbase where glassdoor.input = crunchbase.shortname) 
where exists (select crunchbase.number_of_employees from crunchbase where glassdoor.input = crunchbase.shortname) 

select count(*) from (
select 
	employee."public-profile-url",
	employee."first-name",
	employee."last-name",
	employee."skills",
	employee."location",
	'10' timetocommute,
	employee."num-connections",
	position."company-name",
	position_details."company-name",
	position_details."title",
	position_details."past_experience",
	position_details.duration,
	education_details.degree,
	education_details.degree_score,
	education_details.field_of_study,
	education_details.school_name,
	education_details.school_score,
	education_details.grad_date,
	glassdoor.glassdoorName,
	glassdoor.overall_rating,
	glassdoor.culture_value_rating,
	glassdoor.senior_leadership_rating,
	glassdoor.compensation_benefits_rating,
	glassdoor.career_opportunities_rating,
	glassdoor.worklife_balance_rating,
	glassdoor.recommend_to_friend_rating,
	glassdoor.crunchbase_founded_on_trust_code,
	glassdoor.crunchbase_num_employees_max,
	glassdoor.crunchbase_num_employees_min,
	glassdoor.crunchbase_total_funding_usd, 
	glassdoor.crunchbase_number_of_investments,
	glassdoor.crunchbase_number_of_employees,
	glassdoor_past.glassdoorName glassdoorName_past,
	glassdoor_past.overall_rating overall_rating_past,
	glassdoor_past.culture_value_rating culture_value_rating_past,
	glassdoor_past.senior_leadership_rating senior_leadership_rating_past,
	glassdoor_past.compensation_benefits_rating compensation_benefits_rating_past, 
	glassdoor_past.career_opportunities_rating careewillr_opportunities_rating_past,
	glassdoor_past.worklife_balance_rating worklife_balance_rating_past,
	glassdoor_past.recommend_to_friend_rating recommend_to_friend_rating_past,
	glassdoor_past.crunchbase_founded_on_trust_code crunchbase_founded_on_trust_code_past,
	glassdoor_past.crunchbase_num_employees_max crunchbase_num_employees_max_past,
	glassdoor_past.crunchbase_num_employees_min crunchbase_num_employees_min_past,
	glassdoor_past.crunchbase_total_funding_usd crunchbase_total_funding_usd_past, 
	glassdoor_past.crunchbase_number_of_investments crunchbase_number_of_investments_past,
	glassdoor_past.crunchbase_number_of_employees crunchbase_number_of_employees_past
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
