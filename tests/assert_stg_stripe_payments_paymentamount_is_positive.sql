-- Test that all orders have a positive amount (i.e. returns are not greater than purchases per OrderId)

WITH Payments AS (
    SELECT *
    FROM {{ ref('stg_stripe_payments') }}
)
SELECT OrderId
    ,SUM(PaymentAmount) AS TotalAmount
FROM Payments
GROUP BY OrderId
HAVING TotalAmount < 0