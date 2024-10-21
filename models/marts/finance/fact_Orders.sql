WITH Orders AS (

    SELECT 
        OrderId
        ,CustomerId
        ,OrderDate
    FROM {{ ref('stg_jaffle_shop_orders') }}

),
Payments AS (

    SELECT
        OrderId
        ,SUM(PaymentAmount) AS PaymentAmount
    FROM {{ ref('stg_stripe_payments') }}
    WHERE Status = 'success'
    GROUP BY OrderId

)
SELECT
    Orders.OrderId
    ,Orders.CustomerId
    ,Orders.OrderDate
    ,COALESCE(Payments.PaymentAmount, 0) AS PaymentAmount
FROM Orders
LEFT JOIN Payments USING (OrderId)