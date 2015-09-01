CREATE TABLE glassdoor (input text, glassdoorName text, overall_rating integer, culture_value_rating integer, senior_leadership_rating integer, compensation_benefits_rating integer, career_opportunities_rating integer, worklife_balance_rating integer, recommend_to_friend_rating integer);

CREATE TABLE crunchbase (
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
);

CREATE TABLE employee(
  "first-name" TEXT,
  "industry" TEXT,
  "last-name" TEXT,
  "location" TEXT,
  "num-connections" TEXT,
  "public-profile-url" TEXT,
  "skills" TEXT,
  "summary" TEXT
);

CREATE TABLE education_details (public_profile_url text, degree text, field_of_study text, school_name text, grad_date text, degree_score INTEGER, school_score INTEGER);

CREATE TABLE position_details(
  "public-profile-url" TEXT,
  "company-name" TEXT,
  "title" TEXT,
  "start-date" TEXT,   
  "end-date" TEXT,
  "past_company" TEXT,
  "past_experience" INTEGER
, duration integer);

CREATE TABLE location(
  location text
  timetocommute INTEGER,
  number_of_similar_industry INTEGER);

CREATE TABLE company_shortname_map (actualname text, shortname text);

