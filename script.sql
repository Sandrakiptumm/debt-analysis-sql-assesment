select * from assignments.international_debt limit 30;

--what is the total amount of debt owed by all countries

select (sum (debt)/1000000)::numeric(12,2) as total_debt_in_millions
from assignments.international_debt; 

--how many distinct countries are recorded in the database

select count (distinct country_name) as number_of_unique_countries
from assignments.international_debt ;

--what are the distinct types of debt indicators, what do they represent 

select distinct indicator_name 
from assignments.international_debt;

--Which country has the highest total debt, and how much does it owe?

select country_name, sum(debt) as total_debt
from assignments.international_debt
where country_name != ''
group by country_name 
order by total_debt  desc
limit 1

--What is the average debt across different debt indicators?

select indicator_name, avg(debt) as average_debt
from assignments.international_debt
group by indicator_name;

--Which country has made the highest amount of principal repayments?

select country_name, sum(debt) as total_principal_repayments
from assignments.international_debt
where indicator_name like'%Principal repayments%' and debt is not null and country_name != ''
group by country_name
order by sum(debt) desc
limit 1;

--What is the most common debt indicator across all countries?

select indicator_name, count(*) as indicator_count
from
(select distinct country_name, indicator_name
from assignments.international_debt 
WHERE indicator_name IS NOT NULL AND indicator_name  <> ''  AND country_name IS NOT NULL AND country_name <> ''
order by country_name) as distinct_pairs
group by indicator_name 
order by indicator_count desc
limit 1;

--Identify any other key debt trends and summarize your findings



