CREATE DATABASE DataWarehouse;

USE Datawarehouse;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

CREATE TABLE bronze.crm_info (
cust_id INT,
cust_key VARCHAR (50),
cust_firstname VARCHAR (50),
cust_lastname VARCHAR (50),
cust_material_status VARCHAR (50),
cust_gender VARCHAR (50),
cust_create_date DATE
);


CREATE TABLE bronze.crm_product (
prd_id INT,
prd_key VARCHAR (50),
prd_name VARCHAR (50),
prd_cost VARCHAR (50),
prd_line VARCHAR (50),
prd_start_date DATE,
prd_end_date DATE
);

DROP TABLE bronze.crm_sales;
CREATE TABLE bronze.crm_sales (
    sls_order_number VARCHAR (50),
    sls_prd_key VARCHAR (50),
    sls_cust_id INT,
    sls_order_dt VARCHAR(50),
    sls_ship_dt VARCHAR(50),
    sls_due_dt VARCHAR(50),
    sls_sales DECIMAL (30,2),
    sls_quantity INT,
    sls_price DECIMAL (30,2)
);


CREATE TABLE bronze.erp_cust (
CID VARCHAR (50),
BDATE DATE,
GEN VARCHAR (50)
);


CREATE TABLE bronze.erp_LOC (
cust_id VARCHAR (50),
country VARCHAR (50)
);



CREATE TABLE bronze.erp_CAT (
ID VARCHAR (50),
cat VARCHAR (50),
sub_cat VARCHAR (50),
maintenance VARCHAR (50)
);
