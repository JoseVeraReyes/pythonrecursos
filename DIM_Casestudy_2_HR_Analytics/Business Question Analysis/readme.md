# <p align="center" style="margin-top: 0px;"> Human Resources Case Study 🏚️ 
## <p align="center">     Business Question Analysis

 ```python
  # You can install the library using cmd, with pip install pypyodbc

import pyodbc as  odbc
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# What driver do you want to access
driver = "{SQL Server}"

# What server name do you want to connect, you can easily get this with: SELECT @@SERVERNAME;
server = "LAPTOP\SQLEXPRESS"

# What database are you interested in connecting, I am interested in my Data in Motion case study
database = "DATA_IN_MOTION" 

# Create the connection                   
conn = odbc.connect('DRIVER=' + driver + ';SERVER=' + server + ';DATABASE=' + database + ';') 
 ```

## Question 1
*Find the longest ongoing project for each department*
 
  ```python
sql = """SELECT 
        B.name AS department,
        DATEDIFF(day,A.start_date, A.end_date) AS date_difference
        FROM projects A
        LEFT JOIN departments B
        ON A.department_id = B.id
        GROUP BY A.id, B.name, A.start_date, A.end_date;"""
 
df = pd.read_sql_query(sql, connr)
df.head()
  ```
 
## Question 2
*Find all employees who are not managers*
 
  ```python
sql = """SELECT 
            B.name AS department,
            A.name,
            A.hire_date,
            A.job_title
        FROM employees A
        LEFT JOIN departments B
        ON A.department_id = B.id
        WHERE job_title NOT LIKE '%Manager%';
        """
 
df = pd.read_sql_query(sql, connr)
df.head()

``` 

## Question 3
*Find all employees who have been hired after the start of a project in their department*
 
  ```python
sql = """WITH CTE AS (
            SELECT 
                department_id,
                -- Note, minimum was used here as the objective doesn't specify what 
                -- project date to be focused on
                MIN(start_date) AS project_start
            FROM projects
            GROUP BY department_id),
            
checks AS (
        SELECT 
            A.name AS department,
            B.name,
            CTE.project_start,
            B.hire_date,
        CASE 
            WHEN B.hire_date > CTE.project_start THEN 'true'
            ELSE 'false'
        END AS hired_after_project_start
        FROM employees B
        JOIN departments A ON B.department_id = A.id
        JOIN CTE ON B.department_id = CTE.department_id)

        SELECT * FROM checks
        WHERE hired_after_project_start = 'true';
        """
 
df = pd.read_sql_query(sql, connr)
df.head()

``` 


## Question 4
*Rank employees within each department based on their hire date (earliest hire gets the highest rank)*
 
  ```python
sql = """
        SELECT 
            B.name AS department,
            A.job_title,
            A.name,
            A.hire_date,
            RANK() OVER(PARTITION BY B.name ORDER BY A.hire_date ASC) AS earliest_hire
        FROM employees A
        LEFT JOIN departments B
        ON A.department_id = B.id;
        """ 
 
df = pd.read_sql_query(sql, connr)
df.head()

``` 
 

## Question 5
*Find the duration between the hire date of each employee and the hire date of the next employee hired in the same department*
 
  ```python
sql = """
    SELECT 
        B.name AS department,
        A.job_title,
        A.name,
        A.hire_date,
        LEAD(A.hire_date) OVER(PARTITION BY B.name ORDER BY A.hire_date ASC) AS next_hire_date,
        DATEDIFF(MONTH, A.hire_date, LEAD(A.hire_date) OVER(PARTITION BY B.name ORDER BY A.hire_date
        ASC)) AS date_diff
    FROM employees A
    LEFT JOIN departments B 
    ON A.department_id = B.id;"""
 
df = pd.read_sql_query(sql, connr)
df.head()

```  
 
 
 
 
 
 
 
 
 
 
 
 
 
