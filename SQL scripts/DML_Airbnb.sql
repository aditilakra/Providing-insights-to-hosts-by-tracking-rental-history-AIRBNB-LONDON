#Data Manipulation Scripts

#Insert Data into Master tables#

LOAD DATA LOCAL INFILE '/Users/samiaferoze/Documents/reviews_new.csv' INTO TABLE Review_MasterTable FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE '/Users/samiaferoze/Documents/dim_Listing_masterTable.csv' INTO TABLE Listing_masterTable FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;



Insert into  Fact_Rental
SELECT NULL, host_id,lt.listing_id, rt.Reviewer_Key,price,check_in, check_out,Review_scores_rating, DateDiff(check_OUT,check_IN) AS Duration
fROM 
Review_MasterTable rt
inner join Listing_masterTable lt on rt.listing_id = lt.listing_id
where rt.year='2015'
and lt.year_published='2015';


select * from Guest;
Insert into  Fact_Rental
SELECT NULL, host_id,lt.listing_id, rt.Reviewer_Key,price,check_in, check_out,Review_scores_rating, DateDiff(check_OUT,check_IN) AS Duration
fROM 
Review_MasterTable rt
right join Listing_masterTable lt on rt.listing_id = lt.listing_id
where rt.year='2016'
and lt.year_published='2016';			


#	Insert Into Location table
Insert INTO Location 
select NULL, Listing_ID,Neighbourhood,Address1,Address2,City,Postal_Zip_code,Country,Latitude,Longitude
from Listing_masterTable;

#	Insert Into Guest table
Insert INTO Guest 
select Reviewer_Key,Reviewer_Name,NULL,NULL
from Review_MasterTable;
DELETE FROM Guest
where Guest_Key=0;

#Load data into tables:
#	Insert Into Host table
LOAD DATA LOCAL INFILE '/Users/samiaferoze/Documents/dim_host.csv' INTO TABLE Host FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
#	Insert Into Listing table
LOAD DATA LOCAL INFILE '/Users/samiaferoze/Documents/Dim_Listing.csv' INTO TABLE Listing FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
#	Insert Into Time table
LOAD DATA LOCAL INFILE '/Users/samiaferoze/Documents/Master_dim_time.csv' INTO TABLE Time FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
#	Insert Into Host verification
LOAD DATA LOCAL INFILE '/Users/samiaferoze/Downloads/master_verification.csv' INTO TABLE Host_Verification FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
#	Insert Into Amenities
LOAD DATA LOCAL INFILE '/Users/samiaferoze/Documents/dim_amenties_2017.csv' INTO TABLE Amenities FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
#	Insert Into Identity_Verification
LOAD DATA LOCAL INFILE '/Users/samiaferoze/Documents/dim_identity_verification_2017.csv' INTO TABLE Identity_Verification FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
#	Insert Into Amenity_Listing
LOAD DATA LOCAL INFILE '/Users/samiaferoze/Documents/master_amenities.csv' INTO TABLE Amenity_Listing FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
