CREATE TABLE products (
         product_id INT, 
         product_name VARCHAR(100), 
         category_id INT
     );
     CREATE TABLE categories (
         category_id INT, 
         category_name VARCHAR(100)
     );
     CREATE TABLE online_reviews (
         review_id INT, 
         product_id INT, 
         customer_id INT
     );
     CREATE TABLE physical_reviews (
         review_id INT, 
         product_id INT, 
         customer_id INT
     );
     INSERT INTO categories VALUES 
         (1, 'Electronics'), 
         (2, 'Books'), 
         (3, 'Clothing'), 
         (4, 'Home Appliances');
     INSERT INTO products VALUES 
         (1, 'Smartphone', 1), 
         (2, 'Laptop', 1), 
         (3, 'Novel', 2), 
         (4, 'Shirt', 3), 
         (5, 'Washing Machine', 4);
     INSERT INTO online_reviews VALUES 
         (1, 1, 1), 
         (2, 1, 2), 
         (3, 2, 1), 
         (4, 3, 3);
     INSERT INTO physical_reviews VALUES 
         (1, 1, 3), 
         (2, 2, 1), 
         (3, 3, 2), 
         (4, 4, 4);


SELECT * FROM CATEGORIES
SELECT * FROM PRODUCTS
SELECT * FROM ONLINE_REVIEWS
SELECT * FROM PHYSICAL_REVIEWS


/*
List all products sold in different categories that have received reviews from 
at least 3 unique customers across both online and physical stores.
*/

--PRODUCTS
--CATEGORIES
--3 UNIQUE CUSTOMERS
--ONLINE
--PHYSICAL
	
WITH CTE1 AS (
    SELECT 
        C.CATEGORY_NAME,
        P.PRODUCT_NAME,
        P.PRODUCT_ID
    FROM 
        CATEGORIES C
    JOIN 
        PRODUCTS P ON C.CATEGORY_ID = P.CATEGORY_ID
),
CTE2 AS (
    SELECT 
        CUSTOMER_ID,
        PRODUCT_ID
    FROM 
        ONLINE_REVIEWS
    UNION 
    ALL
    SELECT 
        CUSTOMER_ID,
        PRODUCT_ID
    FROM 
        PHYSICAL_REVIEWS
)
SELECT 
    CTE1.PRODUCT_NAME,
    CTE1.CATEGORY_NAME,
    COUNT(DISTINCT CTE2.CUSTOMER_ID) AS NUMBER_OF_CUSTOMERS
FROM 
    CTE1
JOIN 
    CTE2 ON CTE1.PRODUCT_ID = CTE2.PRODUCT_ID
GROUP BY 
    CTE1.PRODUCT_NAME,
    CTE1.CATEGORY_NAME
HAVING 
    COUNT(DISTINCT CTE2.CUSTOMER_ID) >= 3;


