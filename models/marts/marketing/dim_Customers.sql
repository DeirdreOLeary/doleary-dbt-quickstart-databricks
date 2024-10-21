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
    GROUP BY CustomerId

),
OrderValue AS (

    SELECT
        CustomerId
        ,SUM(PaymentAmount) AS LifetimeValue
    FROM {{ ref('fact_Orders') }}
    GROUP BY CustomerId

)
SELECT 
    Customers.CustomerId
    ,Customers.FirstName
    ,Customers.LastName
    ,CustomerOrders.FirstOrderDate
    ,CustomerOrders.MostRecentOrderDate
    ,COALESCE(CustomerOrders.NumberOfOrders, 0) AS NumberOfOrders
    ,COALESCE(OrderValue.LifetimeValue, 0) AS LifetimeValue
FROM Customers
LEFT JOIN CustomerOrders USING (CustomerId)
    -- USING (CustomerId) is equivalent to ON Customers.CustomerId = CustomerOrders.CustomerId
LEFT JOIN OrderValue USING (CustomerId)