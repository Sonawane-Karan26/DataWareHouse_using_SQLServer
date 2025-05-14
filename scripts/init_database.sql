/*
=============================================================================
Create Database and Schemas
=============================================================================

Script purpose:
  This script creates a new database called "DataWareHouse" after checking if it already exists.
  If the database exists, then it is dropped and recreated. Additionally, the script sets up three schemas within the databases, Bronze, Silver, and Gold.

WARNING:
  Running this scripts will drop the entire "DataWareHouse" databse if it exists.
  All data in the databases will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and create the "DataWareHouse" if it exists.
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO

-- Create the "DataWareHouse" database
CREATE DATABASE DataWareHouse;
GO

USE DataWareHouse;
GO

-- Create Schemas
CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO
