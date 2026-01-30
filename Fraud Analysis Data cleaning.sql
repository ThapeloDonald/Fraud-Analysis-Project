-- Data cleaning

-- Creating a new data base

CREATE DATABASE fraud_analysis;

-- Select database 

USE fraud_analysis;

-- Data inspection
DESCRIBE transactions;
SELECT * FROM transactions LIMIT 10;

-- Creating a staging table 
CREATE TABLE transactions_staging
Like transactions;

SELECT * FROM transactions_staging;

-- Inserting the same data from transactions table into transaction staging to avoid messing with the raw data
INSERT transactions_staging
SELECT *
FROM transactions;

-- Checking for missing values
SELECT
    SUM(amount IS NULL) AS missing_amount,
    SUM(transaction_type IS NULL) AS missing_type,
    SUM(device_risk_score IS NULL) AS missing_device_risk
FROM transactions_staging;

-- Checking  invalid transaction amounts
SELECT * 
FROM transactions_staging 
WHERE amount <=0;

-- Checking duplicate transactions 
SELECT *
FROM transactions_staging t1
JOIN transactions_staging t2
ON t1.transaction_id = t2.transaction_id
AND t1.transaction_id > t2.transaction_id;

-- Converting country codes into country full names
ALTER TABLE transactions_staging ADD country_name VARCHAR(50);  -- adding a column named country_name

-- Updating the country codes into the country name column with their country full name
UPDATE transactions_staging
SET country_name =
CASE country
    WHEN 'US' THEN 'United States'
    WHEN 'UK' THEN 'United Kingdom'
    WHEN 'NG' THEN 'Nigeria'
    WHEN 'TR' THEN 'Turkey'
    WHEN 'DE' THEN 'Germany'
    WHEN 'FR' THEN 'France'
    ELSE 'Other'
END;

-- Standardising categorical text fields
UPDATE transactions_staging
SET
    transaction_type = UPPER(transaction_type),
    merchant_category = UPPER(merchant_category),
    country = UPPER(country);
    
-- Rounding risk_scores to 2 decimal places 
UPDATE transactions_staging 
SET
    device_risk_score = ROUND(device_risk_score, 2),
    ip_risk_score = ROUND(ip_risk_score, 2);
    
-- Rounding amount to 0 decimal places 
UPDATE transactions_staging 
SET
    amount = ROUND(amount, 0);
    
-- Creating a time segment column from the hour column for easy EDA
ALTER TABLE transactions_staging ADD time_segment VARCHAR(20);

UPDATE transactions_staging
SET time_segment =
CASE
    WHEN hour BETWEEN 6 AND 11 THEN 'Morning'
    WHEN hour BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN hour BETWEEN 18 AND 22 THEN 'Evening'
    ELSE 'Night'
END;

-- Creating a device risk band column based on the device risk score
ALTER TABLE transactions_staging ADD device_risk_band VARCHAR(10);

UPDATE transactions_staging
SET device_risk_band =
CASE
    WHEN device_risk_score < 0.3 THEN 'Low'
    WHEN device_risk_score < 0.7 THEN 'Medium'
    ELSE 'High'
END;

-- Adding a new column fraud_flag and converting is_fraud binary (0/1) into (yes/no) on the new column
ALTER TABLE transactions_staging ADD fraud_flag VARCHAR(5);

UPDATE transactions_staging
SET fraud_flag =
CASE
    WHEN is_fraud = 1 THEN 'Yes'
    ELSE 'No'
END;

-- Final data validation check
SELECT * FROM transactions_staging;




    



