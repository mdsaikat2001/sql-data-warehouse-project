
/*
===============================================
Epic Task-2: Coding: Data Integration
===============================================
                   +
===============================================
Epic Task-3: Validating: Data Integration Checks
===============================================

*/

-- Create Dimension Customers --
SELECT
    ci.cst_id as customer_id,
    ci.cst_key as customer_number,
    ci.cst_firstname as first_name,
    ci.cst_lastname as last_name,
    la.cntry as country,
    ci.cst_material_status as material_status,
    CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
         ELSE COALESCE(ca.gen,'n/a')
    END AS gender,
    --ci.cst_gndr,
    ca.bdate as birthdate,
    ci.cst_create_date as create_date
    --ca.gen,
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid

-- TIP: After joinning table, check if any duplicates were
-- introduced by the join logic


--- CHECKING DUPLICATES
SELECT cst_id, COUNT(*) FROM(
SELECT
    ci.cst_id,
    ci.cst_key,
    ci.cst_firstname,
    ci.cst_lastname,
    ci.cst_material_status,
    ci.cst_gndr,
    ci.cst_create_date,
    ca.bdate,
    ca.gen,
    la.cntry
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
)t GROUP BY cst_id
HAVING COUNT(*)>1


--- Cheking data integration

SELECT DISTINCT 
    ci.cst_gndr,
    ca.gen,
    CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
         ELSE COALESCE(ca.gen,'n/a')
    END AS new_gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
ORDER BY 1,2

-- Here have some issues like information not match in some row
-- NULLs often come from joined tables!
-- NULL will appear if SQL finds no match
-- We need to go to an expert and asked question like
   -- Which source is the master for these values?
   -- ans: The master source of customer data is CRM

-- Sort the columns in to logical groups to improve readability


-- Dimension vs Fact??

-- We create new primary key in warehouse for dimension table
-- which is also called Surrogate Key(System-generate unique
-- identifier assigned to each record in a ta)
-- DDL-based generation
-- Query-based using windows function(Row_number)

-- Create Dimension Products --
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers as 
    SELECT
        --Surrogate Key
        ROW_NUMBER() OVER (ORDER BY cst_id) as customer_key,
        ci.cst_id as customer_id,
        ci.cst_key as customer_number,
        ci.cst_firstname as first_name,
        ci.cst_lastname as last_name,
        la.cntry as country,
        ci.cst_material_status as material_status,
        CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
             ELSE COALESCE(ca.gen,'n/a')
        END AS gender,
        --ci.cst_gndr,
        ca.bdate as birthdate,
        ci.cst_create_date as create_date
        --ca.gen,
    FROM silver.crm_cust_info ci
    LEFT JOIN silver.erp_cust_az12 ca
    ON ci.cst_key = ca.cid
    LEFT JOIN silver.erp_loc_a101 la
    ON ci.cst_key = la.cid
GO

-- Quality check of the gold table
SELECT * FROM gold.dim_customers







-- Create Dimension Products--
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO
CREATE VIEW gold.dim_products AS
    SELECT
      --Surrogate Key
      ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) as product_key,
      pn.prd_id as product_id,
      pn.prd_key as product_number,
      pn.prd_nm as product_name,
      pn.cat_id as category_id,
      pc.cat as category,
      pc.subcat as subcategory,
      pc.maintenance,
      pn.prd_cost as cost,
      pn.prd_line as product_line,
      pn.prd_start_dt as start_dt,
      pn.prd_end_dt
    FROM silver.crm_prd_info pn
    LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id

GO

-- Check Quality issues
SELECT prd_key, COUNT(*) FROM(
SELECT
  pn.prd_id,
  pn.cat_id,
  pn.prd_key,
  pn.prd_nm,
  pn.prd_cost,
  pn.prd_line,
  pn.prd_start_dt,
  pn.prd_end_dt,
  pc.cat,
  pc.subcat,
  pc.maintenance
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
where prd_end_dt IS NULL
)t group by prd_key 
HAVING COUNT(*)>1

-- if END date is NULL then it is current info of the product!


-- Final Quality check of the gold table
SELECT * FROM gold.dim_products










-- Create Fact Sales Table --
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT 
    sd.sls_ord_num as order_number,
    pr.product_key,
    cu.customer_key,
    sd.sls_order_dt as order_date,
    sd.sls_ship_dt as shipping_date,
    sd.sls_due_dt as due_date,
    sd.sls_sales as sales_amount,
    sd.sls_quantity as quantity,
    sd.sls_price as price
FROM
    silver.crm_sales_details sd
    LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
    LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id
GO
-- Sort the col into logical groups to improve readability
-- Buildinf Fact: Use the dimension's surrogate keys
-- instead of IDs to easily connect facts with dimensions

--here product_key and customer_key = Dimensions key

-- Quality check of the gold table

-- Foreign key integrity(Dimensions)
SELECT * 
FROM gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
left join gold.dim_products p
on p.product_key = f.product_key
WHERE p.product_key IS NULL



-- Final Quality check of the gold table
SELECT * FROM gold.fact_sales





