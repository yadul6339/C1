-- 1

set transaction isolation level serializable;
start transaction;
update account_details set balance = balance + 550 where first_name = 'Jeff' and last_name  = 'Joshua';
update account_details set balance = balance - 550 where first_name = 'Kim' and last_name = 'Karry';
commit;
start transaction;
update account_details set balance = balance - 150 where first_name = 'Jeff' and last_name  = 'Joshua';
commit;

-- 2
use temp2;
lock table bank_account write;
-- Unlocking later:
unlock tables;

-- 3
-- We can use serializable isolation level;
set transaction isolation level serializable;
start transaction;
insert into bank_account values (123009, '5000-1700-9800', 'SAVINGS', 20000, 'ACTIVE', 'P');

-- User 2 (will be on hold) and once we set cx-id and accn no as primary key, the constraint wont let 
-- any dupliacte entry in table anyway

start transaction; -- bound to fail
insert into bank_account values (123009, '5000-1700-9800', 'SAVINGS', 20000, 'ACTIVE', 'P');

commit;

-- 4
create view gre as 
select * from admission_predict_two where `GRE Score` between 330 and 340 and `TOEFL Score` >= 115;

-- 5
create view cgpa as 
select * from admission_predict_two where CGPA >= (select avg(CGPA) from admission_predict_two);
select * from cgpa;

-- 6
select * from `world_cup_2015`;
select * from `world_cup_2016`;
create view team_1516 as 
select Player_Name from world_cup_2015 where Player_Id in (select Player_Id from world_cup_2016);

-- 7
create view All_From_15 as 
select Player_Id, max(case when Player_Name in 
(select Player_Name from world_cup_2015 where Player_Id not in (select Player_Id from world_cup_2016)) then 
Player_Name else 0 end) as played_15, 
max(case when Player_Name in 
(select Player_Name from world_cup_2015 where Player_Id in (select Player_Id from world_cup_2016)) then 
Player_Name else 0 end) as played_both 
from world_cup_2015 group by Player_Id;

-- 8
create view All_From_16 as 
select Player_Id, max(case when Player_Name in 
(select Player_Name from world_cup_2016 where Player_Id not in (select Player_Id from world_cup_2015)) then 
Player_Name else 0 end) as played_16, 
max(case when Player_Name in 
(select Player_Name from world_cup_2016 where Player_Id in (select Player_Id from world_cup_2015)) then 
Player_Name else 0 end) as played_both 
from world_cup_2015 group by Player_Id;

-- 9
drop view All_From_15, All_From_16, team_1516;
























































































































