-- 1NF: Achieving First Normal Form

-- SQL Query to Achieve 1NF
SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7) n
WHERE CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1
ORDER BY OrderID, n.n;


-- 2NF: Achieving Second Normal Form

-- Step 1: Create CustomerDetails Table
CREATE TABLE CustomerDetails (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Step 2: Insert Data into CustomerDetails Table
INSERT INTO CustomerDetails (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Step 3: Create OrderDetailsNormalized Table
CREATE TABLE OrderDetailsNormalized (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES CustomerDetails(OrderID)
);

-- Step 4: Insert Data into OrderDetailsNormalized Table
INSERT INTO OrderDetailsNormalized (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
