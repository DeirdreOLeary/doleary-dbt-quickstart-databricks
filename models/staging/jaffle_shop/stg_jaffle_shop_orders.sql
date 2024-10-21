SELECT 
    id AS OrderId
    ,user_id AS CustomerId
    ,order_date AS OrderDate
    ,status AS Status
FROM {{ source('jaffle_shop', 'jaffle_shop_orders') }}