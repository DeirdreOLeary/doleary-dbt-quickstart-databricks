{{

    config(
        materialized='table'
    )

}}

WITH Customers AS (

    SELECT 
        id AS CustomerId
        ,first_name AS FirstName
        ,last_name AS LastName
    FROM default.jaffle_shop_customers
    ORDER BY CustomerId
    LIMIT 5
    
),
Orders AS (

    SELECT 
        id AS OrderId
        ,user_id AS CustomerId
        ,order_date AS OrderDate
        ,status AS Status
    FROM default.jaffle_shop_orders

),
CustomerOrders AS (

    SELECT 
        CustomerId
        ,MIN(OrderDate) AS FirstOrderDate
        ,MAX(OrderDate) AS MostRecentOrderDate
        ,COUNT(OrderId) AS NumberOfOrders
    FROM Orders
    GROUP BY 1

)
SELECT 
    Customers.CustomerId
    ,Customers.FirstName
    ,Customers.LastName
    ,CustomerOrders.FirstOrderDate
    ,CustomerOrders.MostRecentOrderDate
    ,COALESCE(CustomerOrders.NumberOfOrders, 0) AS NumberOfOrders
FROM Customers
LEFT JOIN CustomerOrders USING (CustomerId)
    -- USING (CustomerId) is equivalent to ON Customers.CustomerId = CustomerOrders.CustomerId