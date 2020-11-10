create database temp;
use temp;
select * from bankinventory;

-- 1
select * from bankinventory order by price desc limit 1;

-- 2
use temp;
select * from cricket_1 order by Runs asc limit 1 offset 2; 

-- 3
select Player_Id, Player_Name from cricket_1 where lower(Player_Name) like '%d%';

-- 4
select Player_Name from cricket_1 where Player_Name like '_R%';

-- 5
use temp;
select Player_Name,Popularity from cricket_1 where Popularity > 10 union all select Player_Name,Charisma from cricket_2 where Charisma > 50;

-- 6
select upper(Geo_Location) from bankinventory;

-- 7 
select instr(lower(Geo_Location), 'city') from bankinventory;

-- 8
select * from bankinventory;
select lpad(cast(quantity as char), 5, 0) as padded from  bankinventory ;

Insert into bankinventory values ( 'MaxGain',    6 , 220.39, 4690.67, 4890 , 'Riverdale-village' ) ;
Insert into bankinventory values ( 'SuperSave', 7 , 290.30, NULL, 3200.13 ,'Victoria-Town') ;

-- 9
select replace(Geo_Location, '-', ' ') from bankinventory;

-- 10
use hr;
select * from new_cricket;
select concat(Player_Name, ' ', Charisma, ' ', Runs) as Details from new_cricket;