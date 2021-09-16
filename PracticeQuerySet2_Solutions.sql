-- Find the number of customers for each city
SELECT C_City, COUNT(*)
FROM Customer
GROUP BY C_City
ORDER BY COUNT(*);


-- Find the city with the most customers
SELECT C_City, COUNT(*)
FROM Customer
GROUP BY C_City
HAVING COUNT(*) = (
        SELECT MAX(COUNT(*)) 
        FROM Customer GROUP BY C_City
        );


-- Find the total price for all orders
SELECT SUM(P_Price)
FROM Part, Orders
WHERE P_ID = O_PartID;


-- Find all suppliers that live in a city that has customers
SELECT S_ID, S_Name
FROM Supplier, Customer
WHERE S_City = C_City;

SELECT S_ID
FROM Supplier
WHERE S_City IN (SELECT C_City FROM Customer);


-- Find all supplier that live in a city without customers
SELECT S_ID, S_Name
FROM Supplier
WHERE S_City NOT IN (SELECT C_City FROM Customer);

SELECT S_ID, S_Name
FROM Supplier LEFT OUTER JOIN Customer
ON S_City = C_City
WHERE C_City IS NULL;




-- Find the average price for each part name
SELECT P_Name, AVG(P_Price)
FROM Part
GROUP BY P_Name;


-- Find the most common part color
SELECT P_Color, COUNT(*) 
FROM Part
GROUP BY P_Color
HAVING COUNT(*) = ( 
    SELECT MAX(COUNT(*)) FROM Part GROUP BY P_Color
    );


-- Find all shipping modes for Gremlins
SELECT DISTINCT O_Shipmode
FROM Orders O, Part P
WHERE O.O_PartID = P.P_ID
AND P_Name = 'Gremlin';

-- Find the most common shipping mode for Gremlins
SELECT O_Shipmode
FROM Orders O, Part P
WHERE O.O_PartID = P.P_ID
AND P_Name = 'Gremlin'
GROUP BY O_Shipmode
HAVING COUNT(*) = (
                    SELECT MAX(COUNT(*))
                    FROM Orders O, Part P
                    WHERE O.O_PartID = P.P_ID
                    AND P_Name = 'Gremlin'
                    GROUP BY O_Shipmode
                    );


-- Find the customer who has ordered the most Gremlins
SELECT C_ID, C_Name, COUNT(*)
FROM Customer Cust, Orders O, Part P
WHERE O.O_CustID = Cust.C_ID
AND O.O_PartID = P.P_ID
AND P.P_Name = 'Gremlin'
GROUP BY C_ID, C_Name
HAVING COUNT(*) = (
                    SELECT MAX(COUNT(*))
                    FROM Orders O, Part P
                    WHERE O.O_PartID = P.P_ID
                    AND P.P_Name = 'Gremlin'
                    GROUP BY O.O_CustID
                  );


-- Find the supplier who has fulfilled the most orders
SELECT S_ID, S_Name, COUNT(*)
FROM Supplier, Orders
WHERE O_SuppID = S_ID
GROUP BY S_ID, S_Name
HAVING COUNT(*) = (
                    SELECT MAX(COUNT(*))
                    FROM Orders
                    GROUP BY O_SuppID
                  );



-- Find the city that ships the most parts by Boat to a customer's city

SELECT S_ID, S_Name, COUNT(*)
FROM Supplier, Orders
WHERE S_ID = O_SuppID
AND O_Shipmode = 'Boat'
GROUP BY S_ID, S_Name
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM Orders WHERE O_Shipmode = 'Boat' GROUP BY O_SuppID);

-- Find the average part size for each shipping mode
SELECT O_Shipmode, AVG(P_Size)
FROM Orders, Part
WHERE O_PartID = P_ID
GROUP BY O_Shipmode;


-- Find all customers who purchased a Gremlin
SELECT C_ID, C_Name
FROm Customer, Orders, Part
WHERE C_ID = O_CustID
AND P_ID = O_PartID
AND P_Name = 'Gremlin';


-- Find all parts with the same size
SELECT *
FROM Part P1, Part P2
WHERE P1.P_Size = P2.P_Size
AND P1.P_ID < P2.P_ID
ORDER BY P1.P_Size;