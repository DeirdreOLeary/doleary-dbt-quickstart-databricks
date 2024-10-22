WITH Payments AS (
    SELECT *
    FROM {{ ref('stg_stripe_payments') }}
)
SELECT OrderId
    ,SUM(PaymentAmount) AS TotalAmount
FROM Payments
GROUP BY OrderId
HAVING TotalAmount < 0