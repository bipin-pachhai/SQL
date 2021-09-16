/*
Intro to Views
*/

DROP VIEW View1;
DROP VIEW View2;
DROP VIEW View3;

CREATE VIEW View1 
AS SELECT * FROM Supplier;

CREATE VIEW View2 
AS SELECT S_Name FROM Supplier WHERE S_City LIKE '%on';

CREATE VIEW View3 
AS SELECT S_Name, C_Name 
FROM Supplier, Orders, Customer
WHERE S_ID = O_SuppID
AND O_CustID = C_ID
AND C_City = 'Chicago';

SELECT * FROM View1;
SELECT * FROM View2;
SELECT * FROM View3;
SELECT * FROM View3 WHERE S_Name LIKE 'R%';


/*
Updating Views
*/

DROP VIEW AddressView;
DROP VIEW WorkView;
DROP TABLE Workers;

CREATE TABLE Workers(
  W_Name VARCHAR(20) PRIMARY KEY,
  W_Address VARCHAR(25),
  W_Salary NUMBER
);  

CREATE VIEW WorkView
AS SELECT W_Name FROM Workers;

CREATE VIEW AddressView
AS SELECT W_Name, W_Address FROM Workers;

--1. What will be returned?
SELECT * FROM WorkView;
INSERT INTO Workers VALUES('Alice', '123 Main St', 60000);
SELECT * FROM WorkView;

--2. What will this do?
INSERT INTO WorkView VALUES('Bob');
SELECT * FROM WorkView;
SELECT * FROM Workers;

--3. What will this do?
UPDATE AddressView 
SET W_Address = '243 S Wabash' 
WHERE W_Address IS NULL;

SELECT * FROM AddressView;
SELECT * FROM Workers;

--4. What will this do?
INSERT INTO AddressView(W_Address) VALUES('243 S Wabash');
SELECT * FROM AddressView;
SELECT * FROM Workers;



DROP TABLE RegEx;
CREATE TABLE RegEx(
  TextID NUMBER,
  Text VARCHAR(50)
);
INSERT INTO RegEx VALUES(1, 'indianajones@uno.edu');
INSERT INTO RegEx VALUES(2, 'indianajones@gmail.com');
INSERT INTO RegEx VALUES(3, 'ijones@uno.edu');
INSERT INTO RegEx VALUES(4, 'ijones444@uno.edu');
INSERT INTO RegEx VALUES(5, 'indianajones@yahoo.com');
INSERT INTO RegEx VALUES(6, '111-22-3333');
INSERT INTO RegEx VALUES(7, '123-45-6789');
INSERT INTO RegEx VALUES(8, '222-33-4444');
INSERT INTO RegEx VALUES(9, '098-76-5432');
INSERT INTO RegEx VALUES(10, '999-88-7777');
INSERT INTO RegEx VALUES(11, '(846)123-4567');
INSERT INTO RegEx VALUES(12, '(846)123-9876');
INSERT INTO RegEx VALUES(13, '(846)222-3333');
INSERT INTO RegEx VALUES(14, '(312)123-4567');
INSERT INTO RegEx VALUES(15, '(312)222-3333');
commit;


--Dot: Match any single character
-- \ will escape the character
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, 'indianajones@.....\.com');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, 'indianajones@......com');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, 'indianajones@.');


--Plus: Match one or more occurrence of the preceding expression
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, 'jones+');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, 'uno+');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, 'u+');

--Question Mark: Match zero or one (and only one) occurrence of preceding character/subexpression
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, 'indianajones@?uno.edu');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, 'indiana@?jones@uno.edu');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, 'i(ndiana)?jones@uno.edu');


--Star: Match zero or more occurrences of the preceding character or subexpression
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '111-22-333*');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '1*-2*-3*');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '2*-3*-4*');


-- Match the character or subexpression an exact number of times
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '1{3}-2{2}-3{4}');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '2{3}-3{2}-4{4}');

--What records will this regex return?
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '\(...\)2{3}-3{4}');


-- Match any character in a list. "-" can be used as a range.
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '[0-9]{3}-[0-9]{2}-[0-9]{4}');

--How would you write a regex to match phone numbers?
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '\([0-9]{3}\)[0-9]{3}-[0-9]{4}');

-- | can be used for alternate expressions
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '(uno)|(gmail)');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '(uno)|(gmail)|(yahoo)');


-- Beginning/End of String ^/$
SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '^1.*');

SELECT * 
FROM RegEx
WHERE REGEXP_LIKE(Text, '.*3333$');





