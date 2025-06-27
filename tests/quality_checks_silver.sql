--[Clean, Transformation and Load(crm_cust_info) in Bronze to Silver Layer]
--===========================================================================
-- Check for Nulls or Duplicates in primary key
-- Expectation: No result

-- Quality check: S primary key must be unique and not null
Select 
cst_id,
COUNT(*)
from bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) >1 OR cst_id IS NULL


SELECT * FROM(
SELECT 
*,
-- ROW_NUMBER(): Assign a unique number to each row in a
-- result set, based on a defined order
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC)
AS flag_last
FROM bronze.crm_cust_info
where cst_id IS NOT NULL
)t where flag_last = 1

-- Quality check:Check for unwanted spaces in string values
-- Expectation: found results
SELECT 
cst_firstname
FROM bronze.crm_cust_info
where cst_firstname != TRIM(cst_firstname)
-- Expectation: found results
SELECT 
cst_lastname
FROM bronze.crm_cust_info
where cst_lastname != TRIM(cst_lastname)

-- Expectation: no results
SELECT 
cst_gndr
FROM bronze.crm_cust_info
where cst_gndr != TRIM(cst_gndr)
-- Expectation: no results
SELECT 
cst_key
FROM bronze.crm_cust_info
where cst_key != TRIM(cst_key)


-- Now tranform and cleanup space 
SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname)AS cst_lastname,
cst_gndr,
cst_material_status,
cst_create_date
FROM(
SELECT 
*,
-- ROW_NUMBER(): Assign a unique number to each row in a
-- result set, based on a defined order
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC)
AS flag_last
FROM bronze.crm_cust_info
where cst_id IS NOT NULL
)t where flag_last = 1


-- Quality check: Check the consistency of value 
-- in low cardinality columns

-- Data standardization and consistency
SELECT DISTINCT cst_gndr
from bronze.crm_cust_info


SELECT DISTINCT cst_material_status
from bronze.crm_cust_info



--- Now quality data will be insert in bronze layer to silver layer   
-- Truncate use for not inserting duplicate date for continues 
-- execuring our code
    PRINT '>> Truncating Data Into:silver.crm_cust_info';
    TRUNCATE TABLE silver.crm_cust_info;
    PRINT '>> Inserting Data Into:silver.crm_cust_info';
    INSERT INTO silver.crm_cust_info(
     cst_id,
     cst_key,
     cst_firstname,
     cst_lastname,
     cst_gndr,
     cst_material_status,
     cst_create_date
    )
    SELECT 
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname)AS cst_lastname,
    CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
         WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
         ELSE 'n/a'
         -- in our warehouse, we use the default value 'n/a' fro missing values
    END cst_gndr,

    CASE WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
         WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
         ELSE 'n/a'
         -- in our warehouse, we use the default value 'n/a' fro missing values
    END cst_material_status,
    cst_create_date
    FROM(
    SELECT 
    *,
    -- ROW_NUMBER(): Assign a unique number to each row in a
    -- result set, based on a defined order
    ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC)
    AS flag_last
    FROM bronze.crm_cust_info
    where cst_id IS NOT NULL
    )t where flag_last = 1


-- Quality of Silver: Re-run the quality check queries
-- from the bronze layer to verify the quality of data
-- in the silver layer.

-------------------------------------------------------------------------------
-- Check for Nulls or Duplicates in primary key
-- Expectation: No result
Select 
cst_id,
COUNT(*)
from silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) >1 OR cst_id IS NULL


-- Quality check:Check for unwanted spaces in string values
-- Expectation: no results
SELECT 
cst_firstname
FROM silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)

-- Expectation: no results
SELECT 
cst_lastname
FROM silver.crm_cust_info
where cst_lastname != TRIM(cst_lastname)

-- Expectation: no results
SELECT 
cst_gndr
FROM silver.crm_cust_info
where cst_gndr != TRIM(cst_gndr)

-- Expectation: no results
SELECT 
cst_key
FROM bronze.crm_cust_info
where cst_key != TRIM(cst_key)
---------------------------------------------------------------------
-- FINAL LOOK OF crm_cust_info in SILVER layer
SELECT * FROM silver.crm_cust_info






--[Clean, Transformation and Load(crm_prd_info) in Bronze to Silver Layer]
--========================================================================

select 
  prd_id,
  prd_key,
  REPLACE(SUBSTRING(prd_key, 1, 5),'-','_' )AS cat_id, -- new column
  SUBSTRING(prd_key, 7, LEN(prd_key))AS prd_key,
  prd_nm,
  ISNULL(prd_cost,0) AS prd_cost,
  CASE UPPER(TRIM(prd_line)) 
       WHEN 'M' THEN 'Mountain'
       WHEN 'R' THEN 'Road'
       WHEN 'S' THEN 'Other Sales'
       WHEN 'T' THEN 'Touring'
       ELSE 'n/a'
  END prd_line,
  -- WE don't need time info just need date
  CAST(prd_start_dt AS date) AS prd_start_dt,
  CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY 
  prd_start_dt)-1 AS DATE)AS prd_end_dt
from bronze.crm_prd_info
-- Checking --
--WHERE REPLACE(SUBSTRING(prd_key, 1, 5),'-','_' ) NOT IN(
 --select distinct id from bronze.erp_px_cat_g1v2)
  
-- Checking --
--where SUBSTRING(prd_key, 7, LEN(prd_key)) in(
-- select sls_prd_key from bronze.crm_sales_details)

select sls_prd_key from bronze.crm_sales_details
/*
Here is a problem issues: crm_prd_info TABLE 
here cat_id namming like CO-RF but in erp TABLE
it look like CO_RF. We need to fixed it. So use REPLACE function
*/

-- Check for Nulls or Duplicates in primary key
-- Expectation: No result
Select 
prd_id,
COUNT(*)
from silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) >1 OR prd_id IS NULL


-- Check for unwanted spaces
-- Expectation: NO result
select prd_nm
from bronze.crm_prd_info
where prd_nm != TRIM(prd_nm)


-- Check for null or negative numbers
-- Expectation: NO result
select prd_cost
from bronze.crm_prd_info
where prd_cost < 0 or prd_cost is null
-- hadnling null by ISNULLL


-- Data Standardization and consistency
SELECT DISTINCT prd_line
from bronze.crm_prd_info
-- Handling it by CASE statement logic


-- Check for Invalid date orders
SELECT * 
FROM bronze.crm_prd_info
where prd_end_dt < prd_start_dt
-- Here END date must not be earlier than the start date
/*
-- For complex transformations in SQL, 
I typically narrow it down to a specific example and branstrom multiple solution approch

# Solution-1: Switch END date and START Date 
BUT here is an issues like The dates are overlapping 
another issues(NULL) is Each record must has a Start date

# Solution-2: Derive the End data from the start date
END DATE = START DATE of the Next Record - 1

WE CAN USE lead() and lag function
*/

Select 
   prd_id,
   prd_key,
   prd_nm,
   prd_start_dt,
   prd_end_dt,
   LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY 
   prd_start_dt)-1 AS prd_end_dt_test
from bronze.crm_prd_info
where prd_key IN ('AC-HE-HL-U509-R','AC-HE-HL-U509')



-- After solving the prd_start_dt and prd_end_dt issues
-- now we need to modify in our Silver.crm_prd_info table
-- so we need to perform DDL
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info
CREATE TABLE silver.crm_prd_info(
     prd_id      INT,
     cat_id      NVARCHAR(50),
     prd_key     NVARCHAR(50),
     prd_nm      NVARCHAR(50),
     prd_cost    INT,
     prd_line    NVARCHAR(50),
     prd_start_dt  DATE,
     prd_end_dt    DATE,
     dwh_create_date DATETIME2 DEFAULT GETDATE()
);





-- Now after completed solving all issues than we are insert
-- in to bronze to silver.crm_prd_info table



-- Truncate use for not inserting duplicate date for continues 
-- execuring our code
PRINT '>> Truncating Data Into:silver.crm_prd_info';
TRUNCATE TABLE silver.crm_prd_info;
PRINT '>> Inserting Data Into:silver.crm_prd_info';
INSERT INTO silver.crm_prd_info(
 prd_id, 
 cat_id, 
 prd_key,
 prd_nm,
 prd_cost,
 prd_line,
 prd_start_dt,
 prd_end_dt
)
select 
  prd_id,
  REPLACE(SUBSTRING(prd_key, 1, 5),'-','_' )AS cat_id, -- new column
  SUBSTRING(prd_key, 7, LEN(prd_key))AS prd_key,
  prd_nm,
  ISNULL(prd_cost,0) AS prd_cost,
  CASE UPPER(TRIM(prd_line)) 
       WHEN 'M' THEN 'Mountain'
       WHEN 'R' THEN 'Road'
       WHEN 'S' THEN 'Other Sales'
       WHEN 'T' THEN 'Touring'
       ELSE 'n/a'
  END prd_line,
  -- WE don't need time info just need date
  CAST(prd_start_dt AS date) AS prd_start_dt,
  CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY 
  prd_start_dt)-1 AS DATE)AS prd_end_dt
from bronze.crm_prd_info


---------------------------------------------------------------------
-- FINAL LOOK OF crm_prd_info in SILVER layer
SELECT * FROM silver.crm_prd_info




--[Clean, Transformation and Load(crm_sales_details) in Bronze to Silver Layer]
--=============================================================================

-- Truncate use for not inserting duplicate date for continues 
-- execuring our code
PRINT '>> Truncating Data Into:silver.crm_sales_details';
TRUNCATE TABLE silver.crm_sales_details;
PRINT '>> Inserting Data Into:silver.crm_sales_details';
INSERT INTO silver.crm_sales_details(
    sls_ord_num, 
    sls_prd_key,
    sls_cust_id, 
    sls_order_dt, 
    sls_ship_dt, 
    sls_due_dt,
    sls_sales, 
    sls_quantity, 
    sls_price 
)
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
--sls_order_dt,
CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt)  != 8 THEN NULL
     ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
END AS sls_order_dt,
-- sls_ship_dt,
CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt)  != 8 THEN NULL
     ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
END AS sls_ship_dt,
--sls_due_dt,
CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt)  != 8 THEN NULL
     ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
END AS sls_due_dt,
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales !=
sls_quantity * ABS(sls_price)
     THEN sls_quantity * ABS(sls_price)
    ELSE sls_sales
END AS sls_sales,
sls_quantity,
CASE WHEN sls_price IS NULL OR sls_price <=0 
     THEN sls_sales / NULLIF(sls_quantity,0)
    ELSE sls_price
END AS sls_price
from bronze.crm_sales_details
--where sls_ord_num != Trim(sls_ord_num)
--where sls_prd_key not in (select prd_key from silver.crm_prd_info)
--where sls_cust_id not in (select cst_id from silver.crm_cust_info)


-- Check for invalid ORDER dates

select 
NULLIF(sls_order_dt, 0) sls_order_dt
from bronze.crm_sales_details
where sls_order_dt<=0 OR 
len(sls_order_dt) != 8 or
sls_order_dt>20500101 or
sls_order_dt<19000101

-- Check for invalid SHIPPING dates

select 
NULLIF(sls_ship_dt, 0) sls_ship_dt
from bronze.crm_sales_details
where sls_ship_dt<=0 OR 
len(sls_ship_dt) != 8 or
sls_ship_dt>20500101 or
sls_ship_dt<19000101


-- Check for invalid DUE dates

select 
NULLIF(sls_due_dt, 0) sls_due_dt
from bronze.crm_sales_details
where sls_due_dt<=0 OR 
len(sls_due_dt) != 8 or
sls_due_dt>20500101 or
sls_due_dt<19000101





-- Check Order date must always be earlier than the shipping 
-- date or due date
-- Expectation: NO mistake
select
*
from bronze.crm_sales_details
where sls_order_dt > sls_ship_dt OR
sls_order_dt > sls_due_dt



-- Check Sales , quantity and price
-->> Business rule: Total Sales = Quantity * Price
-->> Negative, zeros, null are not allowed!!!

select DISTINCT
sls_sales AS old_sales_value,
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales !=
sls_quantity * ABS(sls_price)
     THEN sls_quantity * ABS(sls_price)
    ELSE sls_sales
END AS sls_sales,
sls_quantity,
sls_price AS old_sales_price,
CASE WHEN sls_price IS NULL OR sls_price <=0 
     THEN sls_sales / NULLIF(sls_quantity,0)
    ELSE sls_price
END AS sls_price
from bronze.crm_sales_details
where sls_sales != sls_quantity * sls_price OR
sls_sales IS NULL OR
sls_quantity IS NULL OR
sls_price IS NULL OR
sls_sales <=0 OR sls_quantity<=0 OR sls_price<=0
ORDER BY sls_sales, sls_quantity, sls_price

/*
#1 Solution: Data issues will fixed direct in source system
#2 Solution: Data issues has to be fixed in data warehouse

RULES:
If Sales is negative, zero or null, derive it using Quantity and price
If Price is zero or null, calculate it using Sales and Quantity
If Price is negative, convert it to a positive value

*/


-- Create DDL table
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()

);


--- After inserting data than again we check any quality issues

select DISTINCT
sls_sales,
sls_quantity,
sls_price
from silver.crm_sales_details
where sls_sales != sls_quantity * sls_price OR
sls_sales IS NULL OR
sls_quantity IS NULL OR
sls_price IS NULL OR
sls_sales <=0 OR sls_quantity<=0 OR sls_price<=0
ORDER BY sls_sales, sls_quantity, sls_price


-- No issues found

-- FINAL CHECK
SELECT * FROM silver.crm_sales_details







--[Clean, Transformation and Load(erp_cust_az12) in Bronze to Silver Layer]
--=============================================================================

-- Truncate use for not inserting duplicate date for continues 
-- execuring our code
PRINT '>> Truncating Data Into:silver.erp_cust_az12';
TRUNCATE TABLE silver.erp_cust_az12;
PRINT '>> Inserting Data Into:silver.erp_cust_az12';
INSERT INTO silver.erp_cust_az12(cid, bdate, gen)
select 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
       ELSE cid
END cid,
CASE WHEN bdate > GETDATE() then NULL
     ELSE bdate
END AS bdate,
CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'FEMALE'
     WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'MALE'
     ELSE 'n/a'
END AS gen
from bronze.erp_cust_az12
--where cid LIKE '%AW00011000%'
/*
WHERE CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
       ELSE cid
END NOT IN (SELECT DISTINCT cst_key from silver.crm_cust_info)
*/
--NASAW00011000

-- We need to handle NAS



-- Indentify Out-of-range DATES
-- Chcek for very old customers and birthday in the future

SELECT DISTINCT
bdate
from bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

-- here have bad data quality



--- Data Standarization and Consistency
SELECT DISTINCT 
gen,
CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'FEMALE'
     WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'MALE'
     ELSE 'n/a'
END AS gen
from bronze.erp_cust_az12



--- After inserting final check of silver.erp_cust_az12


SELECT * FROM  silver.erp_cust_az12







--[Clean, Transformation and Load(erp_loc_a101) in Bronze to Silver Layer]
--=========================================================================

-- Truncate use for not inserting duplicate date for continues 
-- execuring our code
PRINT '>> Truncating Data Into:silver.erp_loc_a101';
TRUNCATE TABLE silver.erp_loc_a101;
PRINT '>> Inserting Data Into:silver.erp_loc_a101';
INSERT INTO silver.erp_loc_a101(cid, cntry)
Select
--cid,
REPLACE(cid, '-', '')cid,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
     WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
     ELSE TRIM(cntry)
END AS cntry
from bronze.erp_loc_a101 
-- CHECK MINUS is present or not
--where REPLACE(cid, '-', '') NOT IN
--(select cst_key from silver.crm_cust_info)

select
cst_key
from silver.crm_cust_info

-- here is an issues like AW-00011000 <-> AW00011000
-- we need to remove minus from bronze.erp_loc_a101,cid column




-- Data Standarization and consistency

select distinct 
cntry as old_cntry,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
     WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
     ELSE TRIM(cntry)
END AS cntry
from bronze.erp_loc_a101
order by cntry
-- here have issued we need to handle cntry column


--- After inserting final check of silver.erp_loc_a101
select * from silver.erp_loc_a101





--[Clean, Transformation and Load(erp_px_cat_g1v2 ) in Bronze to Silver Layer]
--=============================================================================

-- Truncate use for not inserting duplicate date for continues 
-- execuring our code
PRINT '>> Truncating Data Into:silver.erp_px_cat_g1v2';
TRUNCATE TABLE silver.erp_px_cat_g1v2;
PRINT '>> Inserting Data Into:silver.erp_px_cat_g1v2';
INSERT INTO silver.erp_px_cat_g1v2(id,cat,subcat,maintenance)
select 
id,
cat,
subcat,
maintenance
from bronze.erp_px_cat_g1v2


-- silver.crm_prd_info
select cat_id 
from silver.crm_prd_info


-- cheking unwanted spaces
select 
*
from bronze.erp_px_cat_g1v2
where cat != TRIM(cat) or subcat != TRIM(subcat)
or maintenance != TRIM(maintenance)


-- Data Standarization and consistency
select distinct
cat, subcat, maintenance
from bronze.erp_px_cat_g1v2



-- Overall Here no data quality issues found


--- After inserting final check of silver.erp_loc_a101
select * from silver.erp_px_cat_g1v2
