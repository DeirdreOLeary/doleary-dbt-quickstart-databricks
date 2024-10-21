SELECT 
    id AS PaymentId
    ,orderid AS OrderId
    ,paymentmethod AS PaymentMethod
    ,status AS Status
    ,amount / 100 AS PaymentAmount
    ,created AS PaymentCreatedDate
FROM default.stripe_payments