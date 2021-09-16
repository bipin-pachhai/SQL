
--1. Retrieve the names of all employees in department 5 who work more than 14 hours per week on the ProductX project.
  SELECT Fname, Minit, Lname, Dnumber, Pname,  Hours
  FROM EMPLOYEE, DEPARTMENT, PROJECT, WORKS_ON
  WHERE Dno = Dnumber AND Ssn = Essn AND Pnumber = Pno
  AND Dnumber = 5 AND Hours > 14 AND Pname = 'ProductX'

--2. List the names of all employees who have a son with the same first name as themselves.
      SELECT Fname
      FROM EMPLOYEE, DEPENDENT
      WHERE Ssn = Essn
      AND (Fname = Dependent_Name) AND (Relationship = 'Son')

--3. Find the names of all employees who are directly supervised by 'Franklin T Wong'. Note: You must use the name. Do not hardcode an SSN.
        
    SELECT * 
    FROM EMPLOYEE
    WHERE Super_ssn = (SELECT Ssn FROM EMPLOYEE WHERE Fname = 'Franklin' AND Minit = 'T' AND Lname = 'Wong')

--4. For each project, list the project name, project number, and the total hours per week (by all employees) spent on that project.
     SELECT Pname, Pnumber,SUM(Hours) AS Total_Hours
     FROM PROJECT, WORKS_ON
     WHERE Pnumber = Pno
     GROUP BY Pname

--5. Retrieve the names of all employees who work on at least one of the projects. (In other words, look at the list of projects given in the PROJECT table, and retrieve the names of all employees who work on at least one of them.)
    SELECT *
    FROM WORKS_ON
    RIGHT OUTER JOIN EMPLOYEE
    ON  Essn  = Ssn
    WHERE Essn IS NOT NULL;      

--6. Retrieve the names of all employees who do not work on any project.  (In other words, look at the list of projects given in the PROJECT table, and retrieve the names of all employees who work on none of them.)
    SELECT *
    FROM WORKS_ON
    RIGHT OUTER JOIN EMPLOYEE
    ON  Essn  = Ssn
    WHERE Essn IS NULL;

--7. For each department, retrieve the department name and the average salary of all employees working in that department.  Order the output by department number in ascending order.
        SELECT Dname, AVG(Salary)
        FROM DEPARTMENT, EMPLOYEE
        WHERE Dnumber = Dno
        GROUP BY Dname

--8. Retrieve the average salary of all female employees.  
     SELECT AVG(Salary)
     FROM EMPLOYEE
     WHERE Sex = 'F'
     
--9. List the last names of all department managers who have no dependents.

   SELECT Lname 
   FROM EMPLOYEE, DEPARTMENT
   WHERE Ssn = Mgr_Ssn
   AND Ssn IN ( SELECT Ssn
    FROM DEPENDENT
    RIGHT OUTER JOIN EMPLOYEE
    ON  Essn  = Ssn
    WHERE Essn IS NULL)

--10. Find the average salary for employees who have exactly 3 dependents.
            SELECT AVG(Salary)
            FROM EMPLOYEE, DEPENDENT
            WHERE Ssn = Essn
            AND Ssn IN (
                 SELECT Essn
                 FROM DEPENDENT 
                 GROUP BY Essn
                 HAVING COUNT(*) = 3 
                 )
            
                 

--11. For each department whose average salary is greater than $42,000, retrieve the department name and the number of employees in that department.
        SELECT Dname, AVG(Salary)
        FROM EMPLOYEE, DEPARTMENT
        WHERE Dno = Dnumber
        GROUP BY Dname
        HAVING AVG(Salary) > 42000

--12. Retrieve the names of all employees who work in the department that has the employee with the lowest salary among all employees.
SELECT * 
FROM EMPLOYEE, DEPARTMENT
WHERE Dno = Dnumber 
AND Dname IN (
        SELECT Dname
        FROM EMPLOYEE, DEPARTMENT
        WHERE Dno = Dnumber
        GROUP BY Dname    
        HAVING Min(Salary) = ( SELECT  Min(Salary)
        FROM EMPLOYEE
       ) 
      )

--13. Retrieve the names of all employees whose supervisor's supervisor has '888665555' for his/her Ssn.
SELECT *
FROM EMPLOYEE
WHERE Super_Ssn  IN (
        SELECT Ssn
        FROM EMPLOYEE
        WHERE Super_Ssn = '888665555'
        )     
 


--14. Find the total number of employees and the total number of dependents for every department (the dependents for the department are the dependents of all employees working for that department).
   
    SELECT Dname,COUNT(Ssn) AS TotalEmployees, COUNT(Essn) AS TotatDependents
    FROM EMPLOYEE, DEPENDENT, DEPARTMENT
    WHERE Ssn = Essn AND Dno = Dnumber
    GROUP BY Dname
    



--15. Retrieve the names of employees whose salary is within $25,000 of the salary of the employee who is paid the most in the company (e.g., if the highest salary in the company is $85,000, retrieve the names of all employees that make at least $60,000.  Note that you don’t have to worry about anyone making more than $85,000 because in this case $85,000 is the highest salary.). 
    SELECT * 
    FROM EMPLOYEE
    WHERE Salary >( (SELECT Max(Salary)
                    FROM EMPLOYEE )-25000)     
    

--16. Find the names and addresses of all employees whose departments have no location in Houston (that is, whose departments do not have a Dlocation of Houston) but who work on at least one project that is located in Houston (that is, who work on at least one project that has a Plocation of Houston). Note that the first condition is not equivalent to the employee's department having some Dlocation that is not in Houston -- the department must not have any Dlocation that is in Houston in order to be included in the result.
      
      SELECT Fname, Minit, Lname
      FROM EMPLOYEE, DEPT_LOCATIONS,WORKS_ON, PROJECT
      WHERE Dno = Dnumber AND Ssn = Essn AND Pno = Pnumber
      AND Dlocation NOT IN ('Houston') AND Plocation IN ('Houston')
    

   
