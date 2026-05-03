-- Healthcare Claims Data Pipeline - Athena Query Examples
-- These queries assume the synthetic claims data has been cataloged in AWS Glue
-- and is available through Amazon Athena as a table named claims_sample.

-- 1. View all claims
SELECT *
FROM claims_sample
LIMIT 25;

-- 2. Count claims by status
SELECT
    claim_status,
    COUNT(*) AS claim_count
FROM claims_sample
GROUP BY claim_status
ORDER BY claim_count DESC;

-- 3. Identify exception claims
SELECT
    claim_id,
    claim_date,
    provider_id,
    claim_type,
    claim_status,
    billed_amount,
    allowed_amount,
    paid_amount,
    payment_method
FROM claims_sample
WHERE exception_flag = 'Y'
ORDER BY claim_date;

-- 4. Compare billed, allowed, and paid amounts by claim type
SELECT
    claim_type,
    COUNT(*) AS claim_count,
    SUM(billed_amount) AS total_billed,
    SUM(allowed_amount) AS total_allowed,
    SUM(paid_amount) AS total_paid
FROM claims_sample
GROUP BY claim_type
ORDER BY total_billed DESC;

-- 5. Find unpaid or unresolved claims
SELECT
    claim_id,
    claim_date,
    provider_id,
    claim_status,
    billed_amount,
    allowed_amount,
    paid_amount,
    payment_method
FROM claims_sample
WHERE paid_amount = 0
   OR claim_status IN ('Pending', 'Outstanding', 'Reversed')
ORDER BY claim_date;

-- 6. Payment method summary
SELECT
    payment_method,
    COUNT(*) AS claim_count,
    SUM(paid_amount) AS total_paid
FROM claims_sample
GROUP BY payment_method
ORDER BY total_paid DESC;
