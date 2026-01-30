# Fraud Data Analysis Project

## Table of contents
- [Project Overview](#project-overview)
- [Business Problem](#business-problem)
- [Objectives](#objectives)
- [Dataset](#dataset)
- [Methodology](#methodology)
- [Tools and Skills Used](#tools-and-skills-used)
- [Key Findings and Insights](#key-findings-and-insights)
- [Business Recommendations](#business-recommendations)
- [Future Improvements](#future-improvements)
- [Outcomes](#outcomes)
  
## Project Overview
This project focuses on analysing financial transaction data to identify fraud patterns and high-risk behaviours. Using MySQL for data cleaning, Exploratory Data Analysis and Microsoft Power BI for visualisation, the project simulates a real-world fraud analytics workflow used by financial institutions.

## Data Source
Synthetic Fraud data: The data that is used for cleaning,EDA and visualisation is a "synthetic_fraud.csv" sourced from Kaggle.com

## Business Problem
Financial institutions face increasing fraud risks across digital and card-based payment channels. Detecting fraud efficiently while minimizing false positives is critical to protecting customers and reducing financial losses.

## Objectives

	1. Clean and prepare transactions data using MySQL(Workbench) for analysis.
  2. Explore and understand fraud patterns using Exploratory Data Analysis (EDA).
  3. Identify key risk indicators linked to fraudulent transactions.
  4. Visualise insights clearly using Power BI dashboards.
  5. Generate actionable business recommendations to reduce fraud exposure.
    
## Dataset
	- 10000 records
  - #### Key attributes:
    - Transaction id – Unique transaction identifier.
    - User id – Customer identifier.
    - Amount – Transaction value.Transaction type – ATM, POS, Online, QR.
    - Merchant category – Food, Travel, Clothing, Grocery, Electronics.
    - Country – Transaction location.
    - Hour – Hour of transaction (0–23).
    - Device risk score – Risk score of the device (0–1).
    - Ip risk score – Risk score of IP address (0–1).
    - Is fraud – Fraud flag (1 = Fraud, 0 = Legitimate).
      
## Methodology
1.	### Data Cleaning (MySQL Workbench).
   -  Checked for missing or null values.
   -  Verified data types (numeric vs categorical).
   -  Rounded off (Device risk score and Ip risk score) to two decimal places and Amount to 0 decimal places.
   - Standardized categorical fields (transaction types, countries).
   - Created derived columns, such as:
     - Risk bands (Low / Medium / High).
     - Time segments (Morning, Afternoon, Night, Evening).
     - Country name (Full names of the countries).
     - Fraud flag (Yes/No).
      
2.	### Exploratory Data Analysis
   
EDA focused on identifying patterns and anomalies, including:
- #### Fraud distribution across:
  - Transaction types.
  - Merchant categories.
  - Countries.
  - Time of day.

- #### Comparison of:
  - Average transaction amount (Fraud vs Legit).
  - Device and IP risk scores.
    
3.	### Data Visualisation (Microsoft Power BI).
-	Imported data cleaned data from MySQL workbench
-	Created DAX measures.
-	I built visuals KPI cards, charts, and slicers.
-	I also added a Tooltip.
  
### Dashboard Components:
- #### KPIs
  - Total Transactions.
  - Fraud Transactions.
  - Fraud Rate (%).
  - Total Fraud Amount.
  - Average Fraud Amount.

- #### Charts
  - Fraud by Transaction Type.
  - Fraud by Merchant Category.
  - Fraud by Country.
  -  Fraud by Hour of Day.
  -  Total Transactions by Device Risk Band.
  
- #### Slicer
  - Country name.
    
-	#### Tooltip
  - Total Transactions.
  - Fraud Transactions.
  - Total Fraud Amount.
  - Average Fraud Amount.

## Tools and Skills Used
-	MySQL Workbench – Data cleaning, transformation, and EDA.
-	Power BI – Data modelling, DAX calculations, and visualisation.
-	SQL – Data querying and aggregation.
-	DAX – KPI and fraud metric calculations.
  
## Key Findings and Insights
1.	### Fraud Characteristics:
  - Fraudulent transactions tend to have significantly higher device and IP risk scores.
  - Certain transaction types (e.g., ATM and Online) show higher fraud concentration.
  - Fraud occurs more frequently during night and morning hours.
  - Higher-value transactions are more likely to be fraudulent.
  - Some merchant categories (e.g., Clothing and Travel) exhibit elevated fraud risk.


2.  ### Legitimate Transactions
  
#### Most non-fraud transactions have:
- Low device and IP risk scores.
- Smaller transaction amounts.
- Occur during normal business hours.
  

      
## Business Recommendations
-	Apply stricter authentication for high-risk transactions.
-	Monitor late-night and high-value transactions more closely.
-	Use risk scores to prioritize fraud investigations.
  
## Future Improvements.
- Enhancing risk scoring with machine learning features.
- Building a fraud prediction model (Logistic Regression / Random Forest).
- Adding customer behaviour history (frequency, velocity checks).

## Outcomes
-	### From the analysis, the business gains:
  - Clear visibility into where and how fraud occurs.
  - Ability to prioritize monitoring on high-risk transactions.
  - #### Data-backed insights to support:
    - Fraud rules.
    - Risk scoring models.
    - Resource allocation for fraud investigations.

