use hranalytics;

# To intiate the change of the date format, safe update modes needs to be disabled and can be enabled back at the end
SET SQL_SAFE_UPDATES = 0;

# Change the date format from string to date
UPDATE employment_dates
SET `hire_date` = STR_TO_DATE(`hire_date`, '%d/%m/%Y');

# Change the date format from string to date, the where function considered just cells with values
UPDATE employment_dates
SET `term_date` = STR_TO_DATE(`term_date`, '%d/%m/%Y')
WHERE `term_date` <> '';

# What is the size of the work force?
# What is the department's current number of employed staffs?
# Which  month has shown the highest employment, this could help pinpoint when the organization does most of its talent recruitment?
# which month does the organization have the highest resignation or termination, this can lead to further analysis as to why the staff are leaving at that month, you can also drill down to year
# which staff has spent more thaN 10 YEARS with the firm, and which level of work is he currently
# from the current month, which staff has spent 10 years

# The company has 4831 employees
SELECT COUNT(DISTINCT(EMPLOYEE_ID)) AS Total_employee FROM EMPLOYEEOTHERDETAILS;

# Current employment by department
SELECT A.department, COUNT(B.active_status) AS Currently_Employeed
FROM employeeotherdetails A
LEFT JOIN employment_dates B
ON A.employee_id = B.employee_id
WHERE B.active_status = 1
GROUP BY  A.department
ORDER BY Currently_Employeed DESC;

# Most employment was carried were carried out in July and the least in February, however it seems the distribution is same all year long
SELECT MONTHNAME(B.hire_date) AS Months, COUNT(*) AS Newly_employed
FROM employeeotherdetails A
LEFT JOIN employment_dates B
ON A.employee_id = B.employee_id
GROUP BY Months
ORDER BY Newly_employed DESC;

-- In terms of years, employment dropped by 16% from prepandemic levels
SELECT YEAR(B.hire_date) AS `Year`, COUNT(*) AS Newly_employed
FROM employeeotherdetails A
LEFT JOIN employment_dates B
ON A.employee_id = B.employee_id
GROUP BY `Year`
ORDER BY Newly_employed DESC;


# Most resignation occurred within the first quarter of the year of the year, with the first four months accounting for 35% of total annual resignation
SELECT MONTHNAME(B.term_date) AS Months, COUNT(*) AS Resigned_termination
FROM employeeotherdetails A
LEFT JOIN employment_dates B
ON A.employee_id = B.employee_id
WHERE `term_date` <> ''
GROUP BY Months
ORDER BY Resigned_termination DESC;

-- In terms of years, current resignation rate has tripled the prepandemic - 2019 levels by approximately 123%
SELECT YEAR(B.term_date) AS `Year`, COUNT(*) AS Resigned_termination
FROM employeeotherdetails A
LEFT JOIN employment_dates B
ON A.employee_id = B.employee_id
WHERE B.active_status = 0
GROUP BY `Year`
ORDER BY Resigned_termination DESC;

# Maximum number of years the longest staff has stayed within the firm is 11 years
SELECT
    MAX(FLOOR((DATEDIFF(CURRENT_DATE(), B.hire_date)/365.25))) AS Tenure_year 
FROM employment_dates B
WHERE B.active_status = 1
ORDER BY Tenure_year DESC;

# Particular staff with more than or equals 10 years with service 
SELECT   
		A.employee_id, A.department, 
        CONCAT(FLOOR(DATEDIFF(CURRENT_DATE(), B.hire_date)/365.25), ' Years') AS Tenure_year
	FROM employeeotherdetails A
	LEFT JOIN employment_dates B ON A.employee_id = B.employee_id
	WHERE B.active_status = 1 AND CONCAT(FLOOR(DATEDIFF(CURRENT_DATE(), B.hire_date)/365.25), ' Years') >= 10
	GROUP BY A.department,A.employee_id,B.hire_date;


# In terms of departmental retention, how many staffs has stayed ABOVE 10 Years 
WITH CTE AS
	(SELECT   
		A.department, 
        MAX(CONCAT(FLOOR(DATEDIFF(CURRENT_DATE(), B.hire_date)/365.25), ' Years')) AS Tenure_year
	FROM employeeotherdetails A
	LEFT JOIN employment_dates B ON A.employee_id = B.employee_id
	WHERE B.active_status = 1 AND CONCAT(FLOOR(DATEDIFF(CURRENT_DATE(), B.hire_date)/365.25), ' Years') >= 10
	GROUP BY A.department, B.hire_date
	)

SELECT 
    department, Tenure_year, COUNT(*) AS num_of_staff
FROM CTE
GROUP BY department, Tenure_year
ORDER BY department;














