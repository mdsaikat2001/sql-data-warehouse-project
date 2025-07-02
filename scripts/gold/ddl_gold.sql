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


-- Final Quality check of the gold table
SELECT * FROM gold.fact_sales






