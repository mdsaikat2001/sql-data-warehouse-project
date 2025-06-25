
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
