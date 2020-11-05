use bank;
desc bankinventory;
alter table bankinventory modify Geo_Location varchar(30);

select * from bankinventory;

update bankinventory set estimated_sale_price = 1.15*estimated_sale_price where quantity> 4;

insert into bankinventory values ('DailCard', 2, 380.00, 8500.87, 1.10*9000.00, 'Delhi-City');

-- delete FROM bankinventory WHERE product IS NULL;

delete from bankinventory where (estimated_sale_price - purcahase_cost) < (0.05*estimated_sale_price);

select * from bank_holidays;

update bank_holidays set end_time = '2020-03-20 11:59:59';

select * from cricket_1;

select * from cricket_2;

select Player_Id, Player_Name from cricket_2 where Charisma is null;

select Player_Id , Player_Name , charisma from cricket_2 where charisma > 25;

select * from cricket_1 where Runs>50;

select Player_Id , Player_Name,Popularity from cricket_1 where Popularity between 10 and 12;

select * from cricket_2 where Runs >50 and Charisma >50;