
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS ddaiteam14_fall17;
CREATE SCHEMA ddaiteam14_fall17;
USE ddaiteam14_fall17;


drop table if exists Listing;
CREATE TABLE Listing (
Listing_ID INT NOT NULL,
Listing_Name VARCHAR(45) NOT NULL,
Listing_URL VARCHAR(45) NOT NULL,
Property_Type VARCHAR(45) NOT NULL,
Room_Type VARCHAR(45) NOT NULL,
Bathroom_Quantity TINYINT(3) NOT NULL,
Bedroom_Quantity TINYINT(3) NOT NULL,
Bed_Quantity TINYINT(3) NOT NULL,
Listing_Cancellation_Policy VARCHAR(45) NOT NULL,
Year_2015 INT,
Year_2016 INT,
Year_2017 INT,
PRIMARY KEY(Listing_ID),
UNIQUE KEY(Listing_ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

Drop table if exists Host;
CREATE TABLE Host (
Host_id INT,
Listing_id INT,
Host_URL VARCHAR(255) NOT NULL,
Host_First_Name VARCHAR(45) NOT NULL,
Host_Since date,
Host_is_Response DECIMAL(5,3),
Host_has_profile_picture VARCHAR(255) NOT NULL,
Host_identity_verified VARCHAR(255) NOT NULL,
PRIMARY KEY (Host_id))
ENGINE=InnoDB DEFAULT CHARSET=utf8;


drop table if exists Time;
CREATE TABLE Time(
Time_Key INT NOT NULL,
Date_Value DATETIME NOT NULL,
Month_Number TINYINT(2) NOT NULL,
Month_Name VARCHAR(10) NOT NULL,
Year_Number SMALLINT(4) NOT NULL,
Quarter_Number TINYINT(3) NOT NULL,
Quarter_Name VARCHAR(15) NOT NULL,
PRIMARY KEY(Time_Key)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE if exists Listing_masterTable;
CREATE TABLE Listing_masterTable (
Listing_ID INT NOT NULL,
Year_Published YEAR NOT NULL,
Listing_URL VARCHAR(45) NOT NULL,
Listing_Name VARCHAR(45) NOT NULL,
Host_id INT,
Host_URL VARCHAR(255) NOT NULL,
Host_First_Name VARCHAR(45) NOT NULL,
Host_Since DATE,
Host_is_Response DECIMAL(5,3),
Host_has_profile_picture VARCHAR(255) NOT NULL,
Host_identity_verified VARCHAR(255) NOT NULL,
Address1 VARCHAR(45) NOT NULL,
Neighbourhood VARCHAR(45) NOT NULL,
City VARCHAR(45) NOT NULL, 
Address2 VARCHAR(45) NOT NULL,
Postal_Zip_code VARCHAR(10) NOT NULL,
Country VARCHAR (45) NOT NULL,
Latitude DECIMAL(10,8)  NOT NULL,
Longitude DECIMAL(11,8) NOT NULL,
Property_Type VARCHAR(45) NOT NULL,
Room_Type VARCHAR(45) NOT NULL,
Bathroom_Quantity TINYINT(3) NOT NULL,
Bedroom_Quantity TINYINT(3) NOT NULL,
Bed_Quantity TINYINT(3) NOT NULL,
Price INT,
Review_scores_rating INT,
Listing_Cancellation_Policy VARCHAR(45) NOT NULL,
PRIMARY KEY(Listing_ID,Year_Published)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP table Location;
CREATE TABLE Location (
Location_Key INT NOT NULL AUTO_INCREMENT,
Listing_ID INT NOT NULL,
Neighbourhood VARCHAR(45) NOT NULL,
Address1 VARCHAR(45) NOT NULL,
Address2 VARCHAR(45) NOT NULL,
City VARCHAR(45) NOT NULL, 
Postal_Zip_code VARCHAR(10) NOT NULL,
Country VARCHAR (45) NOT NULL,
Latitude DECIMAL(10,8)  NOT NULL,
Longitude DECIMAL(11,8) NOT NULL,
PRIMARY KEY(Location_Key) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


drop table Review_MasterTable;

CREATE TABLE Review_MasterTable(
Reviewer_Key INT NOT NULL,
Listing_ID int ,
Check_IN DATE ,
Check_OUT DATE ,
Reviewer_ID int,
Reviewer_Name varchar(45),
Year int,
Primary Key(Reviewer_Key))
ENGINE=InnoDB DEFAULT CHARSET=utf8;

delete from Review_MasterTable where Reviewer_key = 0;

drop table if exists guest;
CREATE TABLE Guest (
Guest_Key INT NOT NULL,
Guest_First_Name VARCHAR(45),
Guest_Last_Name VARCHAR(45),
Guest_Email VARCHAR(45),
PRIMARY KEY(Guest_Key),
UNIQUE KEY (Guest_Key) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

Alter TABLE Fact_Rental
change column Guest_Key  Guest_id INT;

CREATE TABLE Amenities (
Amenities_ID INT NOT NULL,
Description VARCHAR(45) NOT NULL,
PRIMARY KEY(Amenities_ID),
UNIQUE KEY (Amenities_ID) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


drop table if exists Amenity_Listing;

CREATE TABLE Amenity_Listing (
Listing_ID INT NOT NULL,
Amenities_id INT not null,
Amenities_Key INT,
PRIMARY KEY(Amenities_Key),
KEY idx_fk_Listing_ID (Listing_ID),KEY idx_fk_Amenities_ID (Amenities_ID),
CONSTRAINT fk_Amenity_Listing_Amenities FOREIGN KEY (Amenities_ID) REFERENCES Amenities (Amenities_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_Amenity_Listing_Listing FOREIGN KEY (Listing_ID) REFERENCES Listing (Listing_ID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Identity_Verification (
Identity_Verification_Key INT NOT NULL,
Description VARCHAR(45) NOT NULL,
PRIMARY KEY(Identity_Verification_Key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SELECT * FROM Amenities;
delete from Amenities where Amenities_ID=0;
select * from Identity_Verification;

drop table Host_Verification;

CREATE TABLE Host_Verification (
Verification_Key INT NOT NULL,
Host_id INT,
Identity_Verification_Key INT,
PRIMARY KEY(Verification_key),
KEY idx_fk_Identity_Verification_Key (Identity_Verification_Key),	KEY idx_fk_Host_id (Host_id),
CONSTRAINT fk_Host_Verification_Host FOREIGN KEY (Host_id) REFERENCES Host (Host_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_Host_Verification_Identity_Verification FOREIGN KEY (Identity_Verification_Key) REFERENCES Identity_Verification (Identity_Verification_Key) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE Fact_Rental (
Rental_id INT auto_increment not null,
Host_id INT,
Listing_ID INT ,
Guest_Key INT,
Daily_Price INT,
CheckIN_Key date,
CheckOUT_Key DATE,
Rating SMALLINT,
Duration INT,
primary key(Rental_id),
KEY idx_fk_Listing_ID(Listing_ID), KEY idx_fk_Host_id(Host_id),
CONSTRAINT fk_Fact_Rental_Listing FOREIGN KEY(Listing_ID) REFERENCES Listing (Listing_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_Fact_Rental_Host FOREIGN KEY(Host_id) REFERENCES  Host(Host_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_Fact_Rental_Guest FOREIGN KEY(Guest_Key) REFERENCES Guest(Guest_Key) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


