
-- Stored Procedure to Load Data into Bronze Layer
CREATE OR ALTER PROCEDURE bronze.load_Bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME;

    BEGIN TRY
        PRINT '==============================';
        PRINT 'Loading Data into Bronze Layer';
        PRINT '==============================';

        -- Load CRM Tables
        PRINT '------------------';
        PRINT 'Loading CRM Tables';
        PRINT '------------------';

        SET @batch_start_time = GETDATE();

        -- Load Customer Info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>> Inserting Data into Table: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\dell\OneDrive\Desktop\Data Enginering Interview\Projects\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration To Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Load Order Info
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_ord_info';
        TRUNCATE TABLE bronze.crm_ord_info;
        PRINT '>> Inserting Data into Table: bronze.crm_ord_info';
        BULK INSERT bronze.crm_ord_info
        FROM 'C:\Users\dell\OneDrive\Desktop\Data Enginering Interview\Projects\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration To Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Load Sales Details
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>> Inserting Data into Table: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\dell\OneDrive\Desktop\Data Enginering Interview\Projects\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration To Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Load ERP Tables
        PRINT '------------------';
        PRINT 'Loading ERP Tables';
        PRINT '------------------';

        -- Load ERP Location Data
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>> Inserting Data into Table: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\dell\OneDrive\Desktop\Data Enginering Interview\Projects\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Duration To Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        SET @batch_end_time = GETDATE();
        PRINT 'Loading Bronze Layer Completed';
        PRINT '>> Total Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';

    END TRY
    BEGIN CATCH
        PRINT 'ERROR OCCURRED WHILE LOADING THE BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH
END;

-- Execute the Procedure to Load Data
EXEC bronze.load_Bronze;
