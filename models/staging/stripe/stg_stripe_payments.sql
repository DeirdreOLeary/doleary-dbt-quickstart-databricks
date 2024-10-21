SELECT 
    id AS PaymentId
    ,orderid AS OrderId
    ,paymentmethod AS PaymentMethod
    ,status AS Status
    ,amount AS PaymentAmount
    ,created AS PaymentCreatedDate
FROM default.stripe_payments