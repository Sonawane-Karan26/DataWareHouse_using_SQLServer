/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs a comprehensive series of data quality checks 
    and transformations across the 'Bronze' and 'Silver' layers. It ensures:
    - No null or duplicate primary keys.
    - Removal of unwanted leading/trailing spaces in string fields.
    - Standardization and normalization of categorical values.
    - Validation of date formats, ranges, and logical ordering.
    - Business rule checks for calculated fields (e.g., Sales = Qty * Price).
    - Identification and handling of negative or zero values.

Usage Notes:
    - Run these validations after Bronze Layer ingestion and before promotion 
      to Silver Layer.
    - Investigate and correct any data anomalies or inconsistencies.
    - Transformations such as `ROW_NUMBER`, `TRIM`, `REPLACE`, and derived 
      column logic are suggested for cleanup and standardization.

===============================================================================
*/




-- ======================================================
-- 1. CRM Customer Info - Data Deduplication & Cleanup
-- ======================================================

-- Check for duplicate or null customer IDs
SELECT cst_id, COUNT(*)
FROM Bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- View all records
SELECT *
FROM Bronze.crm_cust_info;

-- Retain latest record for each cst_id based on creation date
SELECT * 
FROM (
	SELECT *,
		ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date) AS flag_last
	FROM Bronze.crm_cust_info
) t
WHERE flag_last = 1;

-- Detect leading/trailing whitespaces in firstname
SELECT cst_firstname
FROM Bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

-- Detect leading/trailing whitespaces in key
SELECT cst_key
FROM Bronze.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Review unique gender values for consistency
SELECT DISTINCT cst_gndr
FROM Bronze.crm_cust_info;


-- ====================================================
-- 2. Product Info Quality Checks
-- ====================================================

-- Check for duplicate or null product IDs
SELECT prd_id, COUNT(*)
FROM Bronze.crm_prod_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Detect leading/trailing whitespaces in product name
SELECT prdnm
FROM Bronze.crm_prod_info
WHERE prdnm != TRIM(prdnm);

-- Validate for negative/null product cost
SELECT prd_cost
FROM Bronze.crm_prod_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Review unique product lines
SELECT DISTINCT prd_line
FROM Bronze.crm_prod_info;

-- Check if end date is before start date
SELECT *
FROM Bronze.crm_prod_info
WHERE prd_end_date < prd_start_date;


-- ====================================================
-- 3. Sales Details - Data Validation
-- ====================================================

-- View all sales details
SELECT * FROM Bronze.crm_sales_details;

-- Validate Order Date format and range
SELECT NULLIF(sls_order_dt, 0) AS sls_order_dt
FROM Bronze.crm_sales_details
WHERE sls_order_dt <= 0 
	OR LEN(sls_order_dt) != 8 
	OR sls_order_dt > 20500101 
	OR sls_order_dt < 19000101;

-- Validate Ship Date
SELECT NULLIF(sls_ship_dt, 0) AS sls_ship_dt
FROM Bronze.crm_sales_details
WHERE sls_ship_dt <= 0 
	OR LEN(sls_ship_dt) != 8 
	OR sls_ship_dt > 20500101 
	OR sls_ship_dt < 19000101;

-- Validate Due Date
SELECT NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM Bronze.crm_sales_details
WHERE sls_due_dt <= 0 
	OR LEN(sls_due_dt) != 8 
	OR sls_due_dt > 20500101 
	OR sls_due_dt < 19000101;

-- Logical Check: Order date should not be after shipping or due date
SELECT *
FROM Bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

-- Validate business rules on Sales Data
-- sls_sales = sls_quantity * sls_price
-- No NULLs, Zeroes or Negatives
SELECT DISTINCT sls_sales, sls_quantity, sls_price
FROM Bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
	OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
	OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;


-- ====================================================
-- 4. ERP Customer Info (Silver Layer)
-- ====================================================

-- Validate birthdates between 1924-01-01 and today
SELECT DISTINCT bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE();

-- Review distinct gender values
SELECT DISTINCT gen FROM silver.erp_cust_az12;
SELECT DISTINCT gender FROM Bronze.erp_cust_az12;


-- ====================================================
-- 5. ERP Location Data
-- ====================================================

-- Replace hyphens in Customer IDs
-- REPLACE(cid, '-', '') AS cid -- Transformation Logic

-- Review and standardize country values
SELECT DISTINCT cntry
FROM Bronze.erp_loc_a101;


-- ====================================================
-- 6. ERP Product Category Cleanup
-- ====================================================

-- Trim unwanted spaces in category columns
SELECT cat FROM Bronze.erp_px_cat_g1v2 WHERE cat != TRIM(cat);
SELECT subcat FROM Bronze.erp_px_cat_g1v2 WHERE subcat != TRIM(subcat);
SELECT maintenance FROM Bronze.erp_px_cat_g1v2 WHERE maintenance != TRIM(maintenance);

-- Review distinct values for normalization
SELECT DISTINCT cat FROM Bronze.erp_px_cat_g1v2;
SELECT DISTINCT subcat FROM Bronze.erp_px_cat_g1v2;
SELECT DISTINCT maintenance FROM Bronze.erp_px_cat_g1v2;
