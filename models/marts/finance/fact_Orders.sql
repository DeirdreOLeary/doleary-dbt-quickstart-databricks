WITH Orders AS (

    SELECT 
        OrderId
        ,CustomerId
    FROM {{ ref('stg_jaffle_shop_orders') }}

),
Payments AS (

    SELECT
        OrderId
        ,PaymentAmount
    FROM {{ ref('stg_stripe_payments') }}

)
SELECT
    Orders.OrderId
    ,Orders.CustomerId
    ,COALESCE(Payments.PaymentAmount, 0) AS PaymentAmount
FROM Orders
LEFT JOIN Payments USING (OrderId)