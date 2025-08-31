CREATE or ALTER PROCEDURE bronze.load_bronze AS
BEGIN
     DECLARE @start_Time DATETIME, @end_Time DATETIME, @batch_start_Time DATETIME, @batch_end_Time DATETIME;
BEGIN TRY
       SET @batch_start_Time = GETDATE();
              PRINT '================================================================================================';
              PRINT 'Loading Bronze Layer';
              PRINT '================================================================================================';

              PRINT '------------------------------------------------------------------------------------------------';
              PRINT 'Loading CRM Tables';
              PRINT '------------------------------------------------------------------------------------------------';

SET @start_Time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_info';
     TRUNCATE TABLE bronze.crm_info;
PRINT '>> Inserting Data Into: bronze.crm_info';
     BULK INSERT bronze.crm_info
     FROM 'E:\karthik\projects\project_3\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
     WITH (
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK
     );
SET @end_Time = GETDATE();
PRINT '>>-----------------------------------------------------------------------------------------';
PRINT '>> Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_Time, @end_Time) AS VARCHAR) + 'seconds';
PRINT '>>-----------------------------------------------------------------------------------------';

SET @start_Time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_product';
   TRUNCATE TABLE bronze.crm_product;
PRINT '>> Inserting Data Into: bronze.crm_product';
   BULK INSERT bronze.crm_product
   FROM 'E:\karthik\projects\project_3\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
   WITH (
   FIRSTROW = 2,
   FIELDTERMINATOR = ',',
   TABLOCK
   );
SET @end_Time = GETDATE();
PRINT '>>-----------------------------------------------------------------------------------------';
PRINT '>> Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_Time, @end_Time) AS VARCHAR) + 'seconds';
PRINT '>>-------------------------------------------------------------------------------------------';

SET @start_Time = GETDATE();
PRINT '>> Truncating Table: bronze.crm_sales';
    TRUNCATE TABLE bronze.crm_sales;
PRINT '>> Inserting Data Into: bronze.crm_sales';
    BULK INSERT bronze.crm_sales
    FROM 'E:\karthik\projects\project_3\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
    WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    MAXERRORS = 100
    );
SET @end_Time = GETDATE();
PRINT '>>-----------------------------------------------------------------------------------------';
PRINT '>> Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_Time, @end_Time)AS VARCHAR) + 'seconds';
PRINT '>>------------------------------------------------------------------------------------------';


PRINT '------------------------------------------------------------------------------------------------';
PRINT 'Loading ERP Tables';
PRINT '------------------------------------------------------------------------------------------------';

SET @start_Time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_cust';
    TRUNCATE TABLE bronze.erp_cust;
PRINT '>> INSERTING Data Into: bronze.erp_cust';
    BULK INSERT bronze.erp_cust
    FROM 'E:\karthik\projects\project_3\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    );
SET @end_Time = GETDATE();
PRINT '>>-----------------------------------------------------------------------------------------';
PRINT '>> Loading Duaration:' + CAST(DATEDIFF(SECOND, @start_Time, @end_Time)AS VARCHAR) + 'seconds';
PRINT '>>------------------------------------------------------------------------------------------';

SET @start_Time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_LOC';
    TRUNCATE TABLE bronze.erp_LOC;
PRINT '>> Inserting Data Into: bronze.erp_loc';
    BULK INSERT bronze.erp_LOC
    FROM 'E:\karthik\projects\project_3\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    );
SET @end_Time = GETDATE();
PRINT '>>-----------------------------------------------------------------------------------------';
PRINT '>> Loading Duration ' + CAST(DATEDIFF(SECOND, @start_Time, @end_Time)AS VARCHAR) + 'seconds';
PRINT '-------------------------------------------------------------------------------------------';

SET @start_Time = GETDATE();
PRINT '>> Truncating Table: bronze.erp_CAT';
    TRUNCATE TABLE bronze.erp_CAT;
PRINT '>> Inserting Data Into: bronze.erp_CAT';
    BULK INSERT bronze.erp_CAT
    FROM 'E:\karthik\projects\project_3\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
    );
SET @end_Time = GETDATE();
PRINT '>>-----------------------------------------------------------------------------------------';
PRINT '>> Loading Duration ' + CAST(DATEDIFF(SECOND, @start_Time, @end_Time)AS VARCHAR) + 'seconds';
PRINT '>>-----------------------------------------------------------------------------------------';


SET @batch_end_Time = GETDATE();
PRINT '=======================================================================';
PRINT 'Loading Bronze Layer is Completed';
PRINT '  - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_Time, @batch_end_Time)AS VARCHAR) + 'seconds';
PRINT '=========================================================================';

 END TRY
    BEGIN CATCH 
    PRINT '======================================================================================';
    PRINT 'ERROR OCCURED LOADING BRONZE LAYER';
    PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE ();
    PRINT 'ERROR MESSAGE ' + CAST (ERROR_MESSAGE()AS VARCHAR);
    PRINT 'ERROR MESSAGE ' + CAST (ERROR_STATE()AS VARCHAR);
    PRINT '======================================================================================';
    END CATCH
END
