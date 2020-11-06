# Question 1:
create database bank;

use bank;

# Question 2:

create table Bankinventory (
product char(10), quantity int,
price real, purcahase_cost decimal(18,2),
estimated_sale_price float
);

# Question 3:
describe Bankinventory;

# Question 4:

insert into Bankinventory values ('PayCard', 2, 300.4 ,8000.87, 9000.5), ('PayPoints', 4, 200.89 ,7000.67, 6700.56);

select * from Bankinventory;

# Question 5:
alter table Bankinventory add column Geo_Location varchar(20);

# Question 6:
select Geo_Location from Bankinventory where product='PayCard';

# Question 7:
select length('PayCard');

# Question 8:
update Bankinventory set Geo_Location = 'Delhi-City';

select length(Geo_Location) from Bankinventory limit 1;

# Question 9:
alter table Bankinventory modify product varchar(10);

# Question 10:
alter table Bankinventory modify product varchar(6);
-- Not possible 

-- SET SQL_SAFE_UPDATES=0

# Question 11:
update Bankinventory set quantity= 10 where product='PayCard';


 # Question 12:
create table Bank_Holidays (
holiday date,
start_time datetime,
end_time datetime,
UTC timestamp
);

desc Bank_Holidays;

# Question 13 A:
insert into Bank_Holidays values (curdate(), holiday, date_add(start_time, interval 1 day), timestamp(end_time));

select * from Bank_Holidays;

# Question 13 B:

UPDATE Bank_Holidays b1 SET b1.holiday = date_add(curdate(), interval 1 day), 
b1.start_time = SUBSTRING_INDEX(b1.holiday," " ,1), 
b1.end_time = date_add(start_time, interval 1 day),
b1.UTC = timestamp(b1.end_time);

# Question 14:
UPDATE Bank_Holidays b1 SET b1.holiday = curdate(), 
b1.start_time = SUBSTRING_INDEX(b1.holiday," " ,1), 
b1.end_time = date_add(start_time, interval 1 day),
b1.UTC = timestamp(b1.end_time);

# Question 15:
update Bank_Holidays set end_time = utc_timestamp();

# Question 16:
select * from Bankinventory limit 1;

# Question 17:
select product as New_product from Bankinventory;

# Question 18:
select * from Bankinventory limit 1;

# Question 19:
SELECT DATE_FORMAT(holiday, "%d-%M-%Y") as new_date from Bank_Holidays;

# Question 20:
select left(Geo_Location, 5) from Bankinventory;
