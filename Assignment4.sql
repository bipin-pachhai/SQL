--1. List all (unique) colors for each part.
    SELECT DISTINCT P_Color
    FROM Part 
    WHERE P_Color IS NOT NULL
    ORDER BY P_Color

--2. Find the number of unique colors for each part.
     SELECT P_Color, COUNT(*)
     FROM Part
     GROUP BY P_Color
     ORDER BY P_Color
     

--3. Find all cities that have more than one customer.
      SELECT C_City, COUNT(*)
        FROM Customer
        GROUP BY C_City
        HAVING COUNT(*) > 1
        
    
--4. Find the price per size for all blue parts.
       SELECT ROUND(SUM(P_Price)/SUM(P_Size),2) AS PricePerSize
       FROM Part
       GROUP BY P_Color
       HAVING P_Color = 'Blue'
    

--5. Find the total cost of all orders in the year 2015 for red and green parts.
     
      SELECT SUM(P_Price) AS TOTALCOST
      FROM Part, Orders
      WHERE P_ID = O_PartID
      AND (O_Date BETWEEN '01-JAN-2015' AND '31-DEC-2015') 
      AND (P_Color = 'Green' OR P_Color = 'Red')
      

    
--6. Find the average cost of all orders for each day where the supplier is from Houston or Detroit.
 --TO DO
 SELECT O_Date,AVG(P_Price)
 FROM Orders, Part, Supplier
 WHERE O_SuppID = S_ID AND O_PartID = P_ID 
 AND (S_City IN ('Houston', 'Detroit'))
 GROUP BY O_Date
 ORDER BY O_DATE
 

--7. Find the total cost of all orders by each customer city and supplier city.
     SELECT  S_City,C_City , ROUND(AVG(P_Price),2)
      FROM Customer, Orders, Part, Supplier
      WHERE O_CustID = C_ID AND O_SuppID = S_ID AND O_PartID = P_ID
      GROUP BY S_City,C_City 
      ORDER BY  S_City,C_City 
     

