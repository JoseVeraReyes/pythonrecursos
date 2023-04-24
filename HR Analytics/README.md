
### Data source
The data source for the analysis can be found within this Github repository: https://github.com/idada29/All-SQL-Analysis/blob/main/HR%20Analytics/Employee.csv

### Business Questions        
1. The business question covered in this analysis:
2. What is the size of the work force?
3. What is the current number of employed staff in each department?
4. Which month and year has shown the highest employment, and how does this pattern vary by department?
5. Which month and year does the organization have the highest resignation or termination, and how does this pattern vary by department?
6. Which staff has spent more than 10 years with the firm, and what is their current job level?
7. Who are the staff with more than or equal to 10 years of service?
8. In terms of departmental retention, how many staff have stayed above 10 years and how does this vary by department?
        
### Preprocessing
The following data preprocessing was carried out for the data in this analysis: 
    
 ```sql
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
 
 ```

### Question 1
```sql
# The company has 4831 employees
SELECT COUNT(DISTINCT(EMPLOYEE_ID)) AS Total_employee FROM EMPLOYEEOTHERDETAILS;
```

### Question 2
```sql
# Current employment by department
SELECT A.department, COUNT(B.active_status) AS Currently_Employeed
FROM employeeotherdetails A
LEFT JOIN employment_dates B
ON A.employee_id = B.employee_id
WHERE B.active_status = 1
GROUP BY  A.department
ORDER BY Currently_Employeed DESC;
```
The following insights was derived from the query:
1. Software engineering has the highest headcount with 737 employees, 366.46% higher than R&D with 158 employees.
2. Following software engineering, Sales and Marketing have the highest  employment levels, while R&D has the lowest employee count, with 158 employees.
3. A significant portion of the organization's workforce is made up of software engineers, accounting for 18.52% of all employees.
4. The number of employees varies across the 12 departments,  ranging from a minumum of 158 to maximum of 737.


### Question 3
```sql
# Most employment was carried were carried out in July and the least in February, however it seems the distribution is same all year long
SELECT MONTHNAME(B.hire_date) AS Months, COUNT(*) AS Newly_employed
FROM employeeotherdetails A
LEFT JOIN employment_dates B
ON A.employee_id = B.employee_id
GROUP BY Months
ORDER BY Newly_employed DESC;
```
The following insights was derived from the query:
1. Most employment were carried out in July and the least in February, however the yearly distribution is even.
2. July had the highest number of newly employed individuals at 425, 19.38% higher than February's 356.
3. As of 2019, there were 520 newly employed individuals, 16.33% higher than the lowest number of 447 in 2021.
4. Employment dropped by 16% from prepandemic level

```sql
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
```
The following insights was derived from the query:
1. A significant proportion of resignations - 35% of the total annual resignations occurred within the first quarter of the year.
2. In comparison to pre-pandemic levels, employment has declined by 16% in recent years.
3. January had the resignations at 89 staff, which is 56.14% higher than the lowest observed sum in November at 57.
    
### All other questions
```sql

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
```
The following insights was derived from the query below:
1. The firm's longest tenured staff member has a maximum tenure of 11 years.
2. Among staff members with over 10 years of service, software engineers constitute 18.93% of the total



<details>
  <summary>Visualizations / Output/collapse</summary>
 ![Picture1](https://user-images.githubusercontent.com/22597020/225591940-5151220a-c50c-4ca8-8fa1-0a082f9806fe.jpg)

![Picture8](https://user-images.githubusercontent.com/22597020/225592060-1c1891eb-b613-4316-9e41-71ca0435d52e.jpg)

![Picture9](https://user-images.githubusercontent.com/22597020/225592120-f9a661c7-5207-4b1f-8a8e-936901f8c318.jpg)

![Picture10](https://user-images.githubusercontent.com/22597020/225592181-43201af5-fb08-471d-b49a-125e9eadbf6f.jpg)

![Picture14](https://user-images.githubusercontent.com/22597020/225592245-5e92d71e-76c0-49f0-bd9b-74303f104466.jpg)

![Picture15](https://user-images.githubusercontent.com/22597020/225592286-296183ff-9220-4cda-b6d9-3125685d58fa.jpg)

![Picture16](https://user-images.githubusercontent.com/22597020/225592315-17d33cb0-47a5-4041-a548-006f395dba23.jpg)

![Picture17](https://user-images.githubusercontent.com/22597020/225592339-4f93dd3c-6ba4-4584-9ffd-8ad890a9d45c.jpg)

![Picture18](https://user-images.githubusercontent.com/22597020/225592363-79db6923-838e-4448-9f30-def3487ee50a.jpg)

![Picture19](https://user-images.githubusercontent.com/22597020/225592403-ba7686cc-c644-4913-be76-c312470b583e.jpg)

![Picture20](https://user-images.githubusercontent.com/22597020/225592432-76454cf8-c112-4c12-807a-415cce75ec97.jpg)

</details>


<div style="text-align:center;">
  <img src="https://media2.giphy.com/media/nnZZfXUevHdz27aH7u/giphy.gif?cid=ecf05e47i9x8jrf3ka23kmf1bdbr0lrmmedbvev9crsr418p&rid=giphy.gif&ct=g" alt="Thank You GIF" width="300" height="300">
</div>



