use hr;

select * from cricket_1;
select * from cricket_2;


# Q1
select Player_Name from cricket_1 where Player_Name in (select Player_Name from cricket_2);

#Q2
select Player_id, Runs, Player_name from cricket_1 where Runs>=50;

#Q3
select * from cricket_1 where lower(Player_name) like 'y%v';

#Q4
select * from cricket_1 where lower(Player_name) not like 't%';

#Q5
select * from cric_combined;
update cric_combined set PC_ratio = Popularity/Charisma ;
alter table cric_combined add PC_ratio double;

#Q6
select Player_name, PC_ratio from cric_combined order by PC_ratio desc limit 5;

-- 7
select Player_Id, Player_name from cric_combined where lower(Player_name) like '%d%';

-- 8
select Player_Id, PC_Ratio from  cric_combined where PC_Ratio between 0.12 and 0.25;

-- 9
select * from new_cricket;
select Player_Id ,Player_Name from new_cricket where Charisma is null;

-- 10
select coalesce(`Player_Id_[0]`, 0), coalesce(`Player_Name_[0]`, 0), coalesce(`Runs_[0]`, 0), 
coalesce(`Charisma`, 0)
from new_cricket;

-- 11
select Player_Id, substr(Player_Id,3)  from new_cricket;

-- 12
select Player_Id , Player_Name, Charisma from new_cricket where Charisma > 25;

-- 13
select * from churn1;


select floor(MonthlyServiceCharges), ceil(TotalAmount) from churn_details where PaymentMethod = 'Electronic check'; 

-- 14
alter table churn1 rename to Churn_Details;
select * from Churn_Details;

-- 15
alter table Churn_Details add new_Amount double;
update Churn_Details set new_Amount = TotalAmount + MonthlyServiceCharges;

-- 16
alter table Churn_Details RENAME column new_Amount to Amount;

-- 17
alter table Churn_Details drop Amount;

-- 18
select customerID, InternetConnection, gender from Churn_Details where lower(InternetConnection) like '_i%';

-- 19
select * from Churn_Details where tenure like '6_';

-- 20
select upper(Player_Name), ifnull(Charisma, 0) from new_cricket order by Player_Name asc;