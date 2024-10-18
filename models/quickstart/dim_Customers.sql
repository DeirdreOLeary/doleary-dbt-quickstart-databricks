{{

    config(
        materialized='table'
    )

}}

WITH Customers AS (

    SELECT 
        CustomerId
        ,FirstName
        ,LastName
    FROM {{ ref('stg_jaffle_shop_customers') }}
        -- Can SELECT * but best practice is to limit what is queried to only those columns required as the source may change in future
    
),
Orders AS (

    SELECT 
        OrderId
        ,CustomerId
        ,OrderDate
        ,Status
    FROM {{ ref('stg_jaffle_shop_orders') }}

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