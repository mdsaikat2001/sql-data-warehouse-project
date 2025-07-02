--=================
--- SQL PROJECT----
--=================

/*
1. Data Warehousing Project
--- Organize, Structure, Prepare
    - ETL/ELT Processing
    - Data Architecture
    - Data Integration
    - Data Cleaning
    - Data Load
    - Dala Modeling

2. Exploratory Data Analysis(EDA)
--- Understand Data
    - Basic Queries
    - Data Profiling
    - Simple Aggregation
    - Subquery

3. Advanced Data Analytics
--- Answer Business Question
    - Complex Queries
    - Window Functions
    - CTE
    - Subquery
    - Report
*/



/*
--- What is DATA WAREHOUSE?
Ans: A subject-oriented(mead it always focus on buisness 
area..like sales, customers, finance and so on), 
integrated(means include multitple source system of data),
time-variant and non-volatile(data is not deleted)
collection of data in support of management's decision-making process.



--- What is ETL(Extract Transfer Load)?
Ans: First Extract data from source without manupulating,
then transform data(like data manipulation will be happen) after
new format is ready than Load or  inserted to the Target(Data warehouse)

*/




/*
### ETL different technique and method
=========================================
E----Extraction
     - Methods(Pull extraction and Push Extraction)
     - Types(Full extraction and Incremental extraction)
     - Techniques(Manual data extraction, Database quering,
       File parsing, API calls, Event based streaming,
       Change data capture,Web scraping)

T-----Transformation
      -Types
           - Data Enrichment
           - Data Integration
           - Derived Columns
           - Data Normalization and standardization
           - Business Rules and Logic
           - Data Aggregation
      - Data Cleansing
           - Remove Duplicates
           - Data Filtering
           - Handing Missing Data
           - Handing Invalid Values
           - Handling Unwanted spaces
           - Data Type Casting
           - Outlier Detection

L-------Load
    - Processing Types
           - Batch Processing
           - Streaming Processing

    - Method
           - Full load
                    - Truncate and insert
                    - Upsert
                    - Drop, Create, insert
           - Increamental Load
                    - Upsert
                    - Append
                    - Merge
    - Slowly changing Dimensions(SCD)
           - SCD 0 No historization
           - SCD 1 Overwrite
           - SCD 2 Historization
           - SCD _


*/ 



/*

=============================
In our Project we will used.....
==============================
E----Extraction
     - Methods(Pull extraction)
     - Types(Full extraction)
     - Techniques(File parsing)

T-----Transformation
      -Types
           - Data Enrichment
           - Data Integration
           - Derived Columns
           - Data Normalization and standardization
           - Business Rules and Logic
           - Data Aggregation
      - Data Cleansing
           - Remove Duplicates
           - Data Filtering
           - Handing Missing Data
           - Handing Invalid Values
           - Handling Unwanted spaces
           - Data Type Casting
           - Outlier Detection

L-------Load
    - Processing Types
           - Batch Processing

    - Method
           - Full load
                    - Truncate and insert
                   
    - Slowly changing Dimensions(SCD)
           - SCD 1 Overwrite


    
*/






/*
=============================
Prepare our project environment.....
==============================

1. Download Project Materials
  - Dataset

2. Project Tools
  - SQL Server Express
  - SQL Server Management Studio(SSMS)
  - Git Repository
  - DrawIO
  - Notion
*/





/*
==============================
PROJECT PLAN with NOTION
===============================


Data Warehouse Project
-----------------------
Project Epic:
  1. Requirement Analysis
           - Epic Task-1: Analyze and Understand the requirements
  2. Design Data Architecture
           - Epic Task-1: Choose data management approach
           - Epic Task-2: Design the Layers
           - Epic Task-3: Draw the data architecture(draw.io)
  3. Project Initialization
           - Epic Task-1: Create details project task(notion)
           - Epic Task-2: Create Project namming conventions
           - Epic Task-3: Create git repo and prepare repo structure
           - Epic Task-4: Create Database and Schema


   4. Build Bronz Layer
           - Epic Task-1: Analyzing Source System
           - Epic Task-2: Codding: Data Ingestion
           - Epic Task-3: Validating: Data completeness and Schema checks
           - Epic Task-4: Document draw data flow
           - Epic Task-5: Commit code in git repo
  
   5. Build Silver Layer
           - Epic Task-1: Analysing: Explore and Understand Data
           - Epic Task-2: Draw Data Integration(draw.io)
           - Epic Task-2: Coding: Data Cleansing
           - Epic Task-3: Validating: Data Correctness Checks
           - Epic Task-4: Document:Extend Data Flow(draw.io)
           - Epic Task-5: Commit code in Git Repo
   
   6. Build Gold Layer
           - Epic Task-1: Analysing: Business Obejects
           - Epic Task-2: Coding: Data Integration
           - Epic Task-3: Validating: Data Integration Checks
           - Epic Task-4: Document: Draw Data Model of star Schema(draw.io)
           - Epic Task-5: Document: Create Data Catalog

*/


/*
1. Requirement Analysis
====================================================
Epic Task-1: Analyze and Understand the requirements
====================================================
Building the Data Warehouse(Data Engineering)

Objective: Develop a modern data warehouse using SQL server to
consolidate sales data, enabling analytical reporting and
informed decision-making.

Specification:
 - Data Source: ERP and CRM(CSV file)
 - Data Quality: Cleanse and resolve 
 - Integration: Combine both sources into a single, user
 friendly data model designed for analytical queries
 - Scope: Focus on the latest dataset only; historization
  of data is not required
 - Documentation: Provide clear documentaion of the data 
 model to support both business stakeholder and analytics
 teams
*/




/*
2. Design Data Architecture
=============================================
Epic Task-1: Choose data management approach
=============================================
Data Architecture
     approch 1:  Data Warehouse
     approch 2:  Data DataLake
     approch 3:  Data Lakehouse(Mixed between Data Warehouse and DataLake)
     approch 4:  Data Mesh


*** In our project we use "approch 1. Data Warehouse"
Builing DATA WAREHOUSE have 4 approches
  
1.Inmon(Source-->Stage--->EDW 3nf--->Data Marts--->Analytics)
2.Kimball(Source--->Stage----------->Data Marts-->Analytics)
3.Data Vault(Source--->Stage--->Row Vault---->Business vault
  ---->Data Marts-->Analytics)
4. Medallion ArchitectureSource--->Bronze---->Silver----->
Gold--->Analytics)


*** So in our project we use "Medallion Architecture"


=======================================
Epic Task-2: Design the Layers
========================================

    Bronze Layer-----> Silve Layer------> Gold Layer

Bronze Layer:
------------
- Raw, unprocessed dat as is from sources
- Traceability and Debugging
- Tables
- Full load(Truncate and insert)
- Data Transformation None(as-is)
- Data Modeling None(as-is)
- Target audience(Data Engineer)



Silve Layer:
------------
- Clean, Structured data
- Prepare Data for Analysis
- Tables
- Full load(Truncate and insert)
- Data Cleaning, Data Standaridation, Data Normalization,
  Data Derived Columns,Data Enrichment
- Data Modeling None(as-is)
- Target audience(Data Engineer, Data Analysts)


Gold Layer:
------------
- Business Ready data
- Provide data to be consumed for reporting and analytics
- Views
- None
- Data integration, Data aggregation, Business logic and rules
- Data Modeling Start Schema, Aggregated Objects, Flat tables
- Target audience(Data Analysts, Business User)


Note: Secret Principle
- SOC(Separation of concerns)
- Like devide by module A, module B etc.





=================================================
Epic Task-3: Draw the data architecture(draw.io)
==================================================

High Level Architecture
-----------------------

1st layer(Sources)--> file inside a folder(ERM, ERP)
2nd layer(Data warehouse)
       --> sublayer 1(Bronze)--> Row Data 
       --> sublayer 2(Silver) --> Cleaned Standarazied data
       --> sublayer 3(Gold)--> Business ready data
3rd layer(Consumer)

*/






/*
3. Project Initialization
================================================
Epic Task-1: Create details project task(notion)
================================================


===============================================
Epic Task-2: Create Project namming conventions
===============================================
Naming Conventions: Set of Rules or Guidelines for naming
anything in the project. Like
  - Database
  - Scehema
  - Tables
  - Store Procedures


General Principle:
------------------
1. Naming conventions:  use "snake_case '
like-   customer_info

2. Language: English

3. Avoid Reserved words: Do not use SQL reserved words
as object names.


Table Naming Conventions:
------------------------
Bronze rules: <sourcesystem>_<entity>
   like- crm_customer_info

Silver rules: <sourcesystem>_<entity>
   like- crm_customer_info

Gold rules: <category>_<entity>
   like- dim_customer

Dimension table
Fact table
Aggregated table


Column Naming Conventions:
------------------------
Surrogate keys: All primary keys in dimension tables
must use the suffix _key.

<table_name>_key
customer_key --> surrogate key in the dim_customers table

Technical columns: All technical column must start with prefix
dwh_<column_name>
dwh_load_data


Store procedure: All store procedure used for loading
data must follow the naming pattern

load_<layer>
load_bronze, load_silver




=======================================================
Epic Task-3: Create git repo and prepare repo structure
=======================================================
https://github.com/mdsaikat2001/sql-data-warehouse-project



=======================================
Epic Task-4: Create Database and Schema
========================================

-- Create Database 'DataWarehouse'
*/

Use master;
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

CREATE SCHEMA bronze;
GO -- Separate batches when working with multiple SQL statement

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO



/*
4. Build Bronz Layer

-------------------------------------------------------------------------------
Analysing            Coding           Validation           Docs & Version
(Interview Source > (Data Ingestion) >(Data Completeness >(Data Documenting &
system experts)                         & Schema Checks)      versioning GIT)
---------------------------------------------------------------------------------


=====================================
Epic Task-1: Analyzing Source System
======================================
  1) Business Context and Ownership
         - Who owns the data?
         - What business process it supports?
         - System and Data documentation
         - Data model and Data Catalog
  2) Architecture and Technology Stack
         - How is data stored?
         (SQL server, Oracle, AWS, Azure)
         -What are the integration capabilities?
         (API, Kfka, File extraction, Direct DB etc...)
  3)Extract and Load

         - Incremental load vs full load?
         - Data Scope and Historical Need
         - What is the expected size of the extracts?
         - Are there any data volumn limitations?
         - How to avoid impacting the source system's performance?
         - Authentication and Authorization
           (tokens, SSH Keys, VPN, IP whitelisting....)


============================================================
Epic Task-2: Codding: Data Ingestion
               +
Epic Task-3: Validating: Data completeness and Schema checks
============================================================

Remember: 
- Data Definition Language defines the structure of databases table
- Consult the technical experts of the source system
to understand its metadata
- Data Profiling, Explore the data to identify column names
and data types



NOte: Now start codding part below
*/


-- Create DDL for Table

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
  DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
      cst_id INT,
      cst_key NVARCHAR(50),
      cst_firstname NVARCHAR(50),
      cst_lastname NVARCHAR(50),
      cst_material_status NVARCHAR(50),
      cst_gndr NVARCHAR(50),
      cst_create_date DATE
     
);

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
  DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info(
      prd_id INT,
      prd_key NVARCHAR(50),
      prd_nm NVARCHAR(50),
      prd_cost INT,
      prd_line NVARCHAR(50),
      prd_start_dt DATETIME,
      prd_end_dt DATETIME   
);



IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
  DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
      sls_ord_num NVARCHAR(50),
      sls_prd_key NVARCHAR(50),
      sls_cust_id INT,
      sls_order_dt INT,
      sls_ship_dt INT,
      sls_due_dt INT,
      sls_sales INT,
      sls_quantity INT,
      sls_price INT,
);



IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
  DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
     cid NVARCHAR(50),
     cntry NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
  DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12(
     cid NVARCHAR(50),
     bdate DATE,
     gen NVARCHAR(50)
);


IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
  DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
     id NVARCHAR(50),
     cat NVARCHAR(50),
     subcat NVARCHAR(50),
     maintenance NVARCHAR(50)
);



-- Develop SQL Load Scripts
CREATE OR ALTER PROCEDURE bronze.load_bronze AS

BEGIN
     DECLARE @start_time DATETIME, @end_time DATETIME,
     @batch_start_time DATETIME, @batch_end_time DATETIME;
     BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '========================================';
        PRINT '  Loading Bronze Layer';
        PRINT '========================================';
    
    
        PRINT '-----------------------------';
        PRINT '  Loading CRM Tables';
        PRINT '------------------------------';
    
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        Truncate Table bronze.crm_cust_info;

        PRINT '>> Inserting Data Into: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\mdhab\Downloads\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'

        WITH(

          FIRSTROW = 2,-- Because in csv file data start from 2nd row, 1st row is column name
          FIELDTERMINATOR = ',', --file delimiter/separator
          TABLOCK 

        );
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
        -- Quality check: Check that the data has not shifted and
        -- is in the correct columns

    --    SELECT * FROM bronze.crm_cust_info
         -- not good data quality

     --   SELECT COUNT(*) FROM bronze.crm_cust_info
  
        -- If we execute bulk insert code twice data will duplicate
        -- and load again like 18493 row to 36986. So solving
        -- this problem we should use Truncate.

        -- Truncate: Quickly deleted all rows from a table, resetting it to an empty state.
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info';
        Truncate Table bronze.crm_prd_info;
        PRINT '>> Inserting Data Into: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\mdhab\Downloads\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'

        WITH(

          FIRSTROW = 2,-- Because in csv file data start from 2nd row, 1st row is column name
          FIELDTERMINATOR = ',', --file delimiter/separator
          TABLOCK 

        );
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
    --    SELECT * FROM bronze.crm_prd_info
         -- not good data quality

    --    SELECT COUNT(*) FROM bronze.crm_prd_info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_sales_details';
        Truncate Table bronze.crm_sales_details;
        PRINT '>> Inserting Data Into: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\mdhab\Downloads\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'

        WITH(

          FIRSTROW = 2,-- Because in csv file data start from 2nd row, 1st row is column name
          FIELDTERMINATOR = ',', --file delimiter/separator
          TABLOCK 

        );
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
     --   SELECT * FROM bronze.crm_sales_details
         -- not good data quality

     --   SELECT COUNT(*) FROM bronze.crm_sales_details
         PRINT '-----------------------------';
         PRINT '  Loading ERP Tables';
         PRINT '------------------------------';
    
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_cust_az12';
        Truncate Table bronze.erp_cust_az12;
        PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\mdhab\Downloads\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'

        WITH(

          FIRSTROW = 2,-- Because in csv file data start from 2nd row, 1st row is column name
          FIELDTERMINATOR = ',', --file delimiter/separator
          TABLOCK 

        );
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
     --   SELECT * FROM bronze.erp_cust_az12
         -- not good data quality

     --   SELECT COUNT(*) FROM bronze.erp_cust_az12
   
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        Truncate Table bronze.erp_loc_a101;
        PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
        BULK INSERT  bronze.erp_loc_a101
        FROM 'C:\Users\mdhab\Downloads\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'

        WITH(

          FIRSTROW = 2,-- Because in csv file data start from 2nd row, 1st row is column name
          FIELDTERMINATOR = ',', --file delimiter/separator
          TABLOCK 

        );
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
    --    SELECT * FROM  bronze.erp_loc_a101
         -- not good data quality

     --   SELECT COUNT(*) FROM  bronze.erp_loc_a101
    
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
        Truncate Table bronze.erp_px_cat_g1v2;
        PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
        BULK INSERT  bronze.erp_px_cat_g1v2
        FROM 'C:\Users\mdhab\Downloads\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'

        WITH(

          FIRSTROW = 2,-- Because in csv file data start from 2nd row, 1st row is column name
          FIELDTERMINATOR = ',', --file delimiter/separator
          TABLOCK 

        );
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
     --   SELECT * FROM  bronze.erp_px_cat_g1v2
         -- not good data quality

    --    SELECT COUNT(*) FROM  bronze.erp_loc_a101
      
        SET @batch_end_time = GETDATE();
        PRINT '===========================================';
        PRINT 'Loading Bronze Layer is Completed';
        PRINT 'Total Load Duration '+CAST(DATEDIFF(SECOND, @batch_start_time,
        @batch_end_time) as NVARCHAR)+ ' seconds';
        PRINT '===========================================';
      END TRY


      BEGIN CATCH
         PRINT '================================================';
         PRINT 'Error occured during loading bronze layer';
         PRINT 'Error message'+ ERROR_MESSAGE();
         PRINT 'Error NUMBER'+ CAST(ERROR_NUMBER() AS NVARCHAR);
         PRINT 'Error STATE'+ CAST(ERROR_STATE() AS NVARCHAR);
         PRINT '================================================';
      END CATCH

END

--- create store procedure in upper code section
--HINT: Save frequently used SQL code in store procedure in database



EXEC bronze.load_bronze

-- ADD PRINTS: Add prints to track execution, debug 
-- issues, and understand its flow


-- ADD TRY....CATCH: SQL runs the TRY block, and if it fails,
-- it runs the CATCH block to handle the error
-- Ensures error handling, data integrity, and issue logging
-- for easier debugging

-- TRACK ETL Duration: Helps to identify bottlenecks, optimize performance,
-- monitor trends, detect issues


/*
=====================================
Epic Task-4: Document draw data flow
======================================

Completed draw.io


=====================================
Epic Task-5: Commit code in git repo
======================================
commited in my git repo:
https://github.com/mdsaikat2001/sql-data-warehouse-project/tree/main/scripts/bronze
*/





--============================================================================================================
--==============================================================================================================================








/*
5. Build Silver Layer

--------------------------------------------------------------------------------------------------------------
Analysing         Coding           Validation           Docs & Version(Data flow and data integration diagram)
(Explore and > (Data Cleaning) >(Data Correctness >(Data Documenting &
understand                        Checks)            versioning GIT)
the data)                                      
----------------------------------------------------------------------------------------------------------------
==================================================
Epic Task-1: Analysing: Explore and Understand Data
===================================================

=> First we need to Document and visualize what we 
understand from data

=> Integration model made by draw.io
check it!!!

*/

SELECT TOP 1000 * FROM bronze.crm_cust_info -- cst_id, cst_key
SELECT TOP 1000 * FROM bronze.crm_prd_info -- prd_key
SELECT TOP 1000 * FROM bronze.crm_sales_details --prd_key, cst_id

SELECT TOP 1000 * FROM bronze.erp_cust_az12 -- cid
SELECT TOP 1000 * FROM bronze.erp_loc_a101 -- cid
SELECT TOP 1000 * FROM bronze.erp_px_cat_g1v2 --id



/*
===============================================
Epic Task-2: Documenting Extend Dataflow(draw.io)
=================================================
           
*/




/*
===================================
Epic Task-3: Coding: Data Cleaning
===================================
               +
================================================
Epic Task-4: Validating: Data Correctness Checks
================================================

-- first create DDL table in silver layer.
-- before execute ddl add metadata columns.
(Metadata Columns): Extra columns added by data engineers
that do not originate from the source data.
Like:
    create_date = The records load timestamp
    update_date = The records last update timestamp
    source_system = The origin system of the record

*/

-- Create DDL Silver Layer
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
  DROP TABLE silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info(
      cst_id INT,
      cst_key NVARCHAR(50),
      cst_firstname NVARCHAR(50),
      cst_lastname NVARCHAR(50),
      cst_material_status NVARCHAR(50),
      cst_gndr NVARCHAR(50),
      cst_create_date DATE,
      dwh_create_date DATETIME2 DEFAULT GETDATE() -- EXTRA metadata column
     
);

IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
  DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info(
      prd_id INT,
      prd_key NVARCHAR(50),
      prd_nm NVARCHAR(50),
      prd_cost INT,
      prd_line NVARCHAR(50),
      prd_start_dt DATETIME,
      prd_end_dt DATETIME,
      dwh_create_date DATETIME2 DEFAULT GETDATE() -- EXTRA metadata column
);

IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
  DROP TABLE silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details(
      sls_ord_num NVARCHAR(50),
      sls_prd_key NVARCHAR(50),
      sls_cust_id INT,
      sls_order_dt INT,
      sls_ship_dt INT,
      sls_due_dt INT,
      sls_sales INT,
      sls_quantity INT,
      sls_price INT,
      dwh_create_date DATETIME2 DEFAULT GETDATE() -- EXTRA metadata column
);

IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
  DROP TABLE silver.erp_loc_a101;
CREATE TABLE silver.erp_loc_a101(
     cid NVARCHAR(50),
     cntry NVARCHAR(50),
     dwh_create_date DATETIME2 DEFAULT GETDATE() -- EXTRA metadata column
);

IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
  DROP TABLE silver.erp_cust_az12;
CREATE TABLE silver.erp_cust_az12(
     cid NVARCHAR(50),
     bdate DATE,
     gen NVARCHAR(50),
     dwh_create_date DATETIME2 DEFAULT GETDATE() -- EXTRA metadata column
);


IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
  DROP TABLE silver.erp_px_cat_g1v2;
CREATE TABLE silver.erp_px_cat_g1v2(
     id NVARCHAR(50),
     cat NVARCHAR(50),
     subcat NVARCHAR(50),
     maintenance NVARCHAR(50),
     dwh_create_date DATETIME2 DEFAULT GETDATE() -- EXTRA metadata column
); 


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




-- In Silver layer we need to Create Stored Procedure 
-- after completing all tasks now we create stored procedure
-- in top all selver layer table


------------ Create Store Procedure-------------------
/*
=> This Stored procedure performs the ETL(Extract, Transform, Load)
process to populate the 'silver' schema tables from the
'bronze' schema.

=> Action: Truncates Silver Tables
           Inserts transformed and cleansed data from bronze to silver tables
=> Parameter: This stored procedure does not accept any
    parameters or return any values.
*/
EXEC silver.load_silver

Create OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME,
    @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '========================================';
        PRINT '  Loading SILVER Layer';
        PRINT '========================================';
    
        PRINT '-----------------------------';
        PRINT '  Loading CRM Tables';
        PRINT '------------------------------';
        SET @start_time = GETDATE();    
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
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
------------------------------------------------------------------------------------
        SET @start_time = GETDATE();    
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
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
------------------------------------------------------------------------------------
        SET @start_time = GETDATE();
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
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
----------------------------------------------------------------------------
        PRINT '-----------------------------';
        PRINT '  Loading ERP Tables';
        PRINT '------------------------------';
    
        SET @start_time = GETDATE();
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
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
----------------------------------------------------------------------------
        SET @start_time = GETDATE();    
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
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
----------------------------------------------------------------------------
        SET @start_time = GETDATE();    
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
        SET @end_time = GETDATE();
        PRINT '>>Load duration: '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
----------------------------------------------------------------------------------------------------------------
        SET @batch_end_time = GETDATE();
        PRINT '===========================================';
        PRINT 'Loading Bronze Layer is Completed';
        PRINT 'Total Load Duration '+CAST(DATEDIFF(SECOND, @batch_start_time,
        @batch_end_time) as NVARCHAR)+ ' seconds';
        PRINT '===========================================';
      END TRY
      
      BEGIN CATCH
         PRINT '================================================';
         PRINT 'Error occured during loading bronze layer';
         PRINT 'Error message'+ ERROR_MESSAGE();
         PRINT 'Error NUMBER'+ CAST(ERROR_NUMBER() AS NVARCHAR);
         PRINT 'Error STATE'+ CAST(ERROR_STATE() AS NVARCHAR);
         PRINT '================================================';
      END CATCH
END




-------------------------
EXEC bronze.load_bronze

EXEC silver.load_silver

---------------------------





/*
===============================================
Epic Task-5: Document: Extend Data Flow(draw.io)
===============================================

complete remain data flow diagram

*/

/*
====================================
Epic Task-5: Commit code in Git Repo
====================================
 completed: https://github.com/mdsaikat2001/sql-data-warehouse-project/tree/main/scripts/silver
 
*/








/*
5. Build Gold Layer
-----------------------------------------------------------------------
=>Analysing
  Explore & Understand   
  the business Objects 
  
=>Data Integration
  (Build the business object --> Choose Type Dimension vs Fact
  ---> Rename to friendly names)

=>Validating
  Data Integration Checks

=>Docs & Version
  Documenting Versioning in GIT
     
------------------------------------------------------------------------------

Data Model
  -- Conceptual Data Model(Show Big picture)
  -- Logical Data Model (Blue print of data)
  -- Physical Data Model (Implementation)



THeory of Star Schema vs. Snowflake Schema
-------------------------------------------
For analytics or business intelligent we need special
types of data model that is  optimized for reporting,
flexible, easy to understand.


In Star Schema "FACT table" is in the middle and surrundings 
have "DIM table"
-> Simple and Easy
-> Big Dimensions

In Snowflake Schema "FACT table"is in the middle and surroundings 
have "DIM" also each "DIM table" have "SubDIM"
-> More Complex
-> Large Dataset


Theory of Dimension table: Descriptive information
that give context to your data.
questions are-  who? what? where?



Theory of Fact table: Quantitative information that
represents events.
questions are- How much? How many?
*/



/*
===============================================
Epic Task-1: Analysing: Explore Business Obejects
===============================================

Diagram: Integration model

*/




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









/*
===============================================
Epic Task-4: Draw Star Schema 
===============================================
               Completed
*/


/*
===============================================
Epic Task-5: Create Data Catalog
===============================================
create in github repository data_catalog.md
*/
















