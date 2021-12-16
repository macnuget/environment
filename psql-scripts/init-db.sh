#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	-- Products table
	CREATE TABLE "Products"(
	    "Id" int  PRIMARY KEY,
	    "Name" varchar(128) NOT NULL,
	    "Quantity" int DEFAULT 0,
	    "Available" boolean DEFAULT false
	);
	
	-- Suppliers table
	CREATE TABLE "Suppliers"(
	    "VatNumber" varchar(64) PRIMARY KEY,
	    "Denomination" varchar(128) NOT NULL,
	    "PhoneNumber" text NOT NULL,
	    "Email" varchar(128) NOT NULL
	);
	
	-- Intersection table between Products and Suppliers (relation many-to-many)
	CREATE TABLE "Products_Suppliers"(
	    "ProductId" int REFERENCES "Products" ("Id"),
	    "SupplierId" varchar(64) REFERENCES "Suppliers" ("VatNumber"),
	    PRIMARY KEY("ProductId","SupplierId")
	);
	
	-- Refills table
	CREATE TABLE "Refills"(
	    "Id" serial PRIMARY KEY,
	    "SupplierId" varchar(64) REFERENCES "Suppliers" ("VatNumber"),
	    "ArriveDate" date NOT NULL,
	    "ProductId" int REFERENCES "Products" ("Id"),
	    "Quantity" int NOT NULL
	);
EOSQL
