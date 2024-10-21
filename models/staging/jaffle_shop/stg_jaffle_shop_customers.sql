SELECT 
    id AS CustomerId
    ,first_name AS FirstName
    ,last_name AS LastName
FROM {{ source('jaffle_shop', 'jaffle_shop_customers') }}