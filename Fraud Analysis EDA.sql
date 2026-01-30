-- Exploratory Data Analysis

SELECT * FROM transactions_staging;

-- Total transactions
SELECT COUNT(*) AS total_transactions
FROM transactions_staging;

-- Total fraud vs legit transactions
SELECT
    fraud_flag,
    COUNT(*) AS transaction_count
FROM transactions_staging
GROUP BY fraud_flag;

-- Fraud Rate(%)
SELECT
    ROUND(
        SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
    2) AS fraud_rate_percentage
FROM transactions_staging;

-- Average transaction amount fraud vs legit transactions
SELECT
    fraud_flag,
    COUNT(*) AS transactions,
    ROUND(AVG(amount), 2) AS avg_amount
FROM transactions_staging
GROUP BY fraud_flag;

-- Fraud by transaction_type
SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(
        SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
    2) AS fraud_rate
FROM transactions_staging
GROUP BY transaction_type
ORDER BY fraud_rate DESC;

-- Fraud by merchant_category
SELECT
    merchant_category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) AS fraud_count
FROM transactions_staging
GROUP BY merchant_category
ORDER BY fraud_count DESC;

-- Fraud by country
SELECT
    country_name,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) AS fraud_count
FROM transactions_staging
GROUP BY country_name
ORDER BY fraud_count DESC;

-- Fraud by hour
SELECT
    hour,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) AS fraud_count
FROM transactions_staging
GROUP BY hour
ORDER BY hour;

-- Fraud by time_segment
SELECT
    time_segment,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) AS fraud_count
FROM transactions_staging
GROUP BY time_segment;

-- Average Risk Scores (Fraud Vs Legit)
SELECT
    fraud_flag,
    ROUND(AVG(device_risk_score), 2) AS avg_device_risk,
    ROUND(AVG(ip_risk_score), 2) AS avg_ip_risk
FROM transactions_staging
GROUP BY fraud_flag;

-- Fraud by device risk band
SELECT
    device_risk_band,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) AS fraud_count
FROM transactions_staging
GROUP BY device_risk_band
ORDER BY fraud_count DESC;

-- High-risk Transaction Identification
SELECT
    transaction_id,
    amount,
    transaction_type,
    country_name,
    device_risk_score,
    ip_risk_score
FROM transactions_staging
WHERE
    device_risk_score >= 0.7
    AND ip_risk_score >= 0.7
    AND fraud_flag = 'Yes';
    
-- Fraud contribution by transaction
SELECT
    transaction_type,
    SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) AS fraud_count,
    ROUND(
        SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END) * 100.0 /
        SUM(SUM(CASE WHEN fraud_flag = 'Yes' THEN 1 ELSE 0 END)) OVER (),
    2) AS fraud_contribution_percentage
FROM transactions_staging
GROUP BY transaction_type
ORDER BY fraud_contribution_percentage DESC;


