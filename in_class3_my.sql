use temp;
drop table `bankinv`;

create table if not exists Bank_Inventory_pricing (
Product varchar(15),
Quantity int,
Price real,
purchase_cost decimal (6,2),
Estimated_sale_price float,
mnth int);

Insert into Bank_Inventory_pricing values ( 'PayCard'   , 2 , 300.45, 8000.87, 9000.56, 1 ) ;
Insert into Bank_Inventory_pricing values ( 'PayCard'   , 2 , 800.45, 5000.80, 8700.56, 1 ) ;
 Insert into Bank_Inventory_pricing values ( 'PayCard'   , 2 , 500.45, 6000.47, 7400.56, 1 ) ;
 Insert into Bank_Inventory_pricing values ( 'PayPoints' , 4 , 390.87, 7000.67, 6700.56, 2)  ;
 Insert into Bank_Inventory_pricing values ( 'SmartPay' , 5  , 290.69, 5600.77, 3200.12 , 1)  ;
 Insert into Bank_Inventory_pricing values ( 'MaxGain',    3 , NULL, 4600.67, 3233.11 , 1 ) ;
 Insert into Bank_Inventory_pricing values ( 'MaxGain',    6 , 220.39, 4690.67, NULL , 2 ) ;
 Insert into Bank_Inventory_pricing values ( 'SuperSave', 7 , 290.30, NULL, 3200.13 ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'SuperSave', 6 , 560.30, NULL, 4200.13 ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'SuperSave', 6 , NULL, 2600.77, 3200.13 ,2 ) ;
 Insert into Bank_Inventory_pricing values ( 'SuperSave', 9 , NULL, 5400.71, 9200.13 ,3 ) ;
 Insert into Bank_Inventory_pricing values ( 'SmartSav',   3 , 250.89, 5900.97, NULL ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'SmartSav',   3 , 250.89, 5900.97, 8999.34 ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'SmartSav',   3 , 250.89, NULL , 5610.82 , 2 ) ;
 Insert into Bank_Inventory_pricing values ( 'EasyCash',   3 , 250.89, NULL, 5610.82 ,1 ) ;
 Insert into Bank_Inventory_pricing values ( 'EasyCash',   3 , 250.89, NULL, 5610.82 , 2 ) ;
 Insert into Bank_Inventory_pricing values ( 'EasyCash',   3 , 250.89, NULL, 5610.82 , 3 ) ;
 Insert into Bank_Inventory_pricing values ( "BusiCard"  ,  1, 3000.99 , NULL, 3500, 3) ; 
 Insert into Bank_Inventory_pricing values ( "BusiCard"  ,  1, 4000.99 , NULL, 3500, 2) ; 
 
 Create table Bank_branch_PL
(Branch   varchar(15),
  Banker   Int,
  Product varchar(15) ,
  Cost  Int,
  revenue Int,
  Estimated_profit Int,   
  month  Int);
Insert into Bank_branch_PL values ( 'Delhi', 99101, 'SuperSave', 30060070, 50060070,  20050070, 1 ) ;
Insert into Bank_branch_PL values ( 'Delhi', 99101, 'SmartSav',   45060070, 57060070, 30050070, 2) ;
Insert into Bank_branch_PL values ( 'Delhi', 99101, 'EasyCash',   66660070, 50090090, 10050077, 3) ;
Insert into Bank_branch_PL values ( 'Hyd', 99101, 'SmartSav',   66660070, 79090090, 10050077, 3) ;
Insert into Bank_branch_PL values ( 'Banglr', 77301, 'EasyCash',   55560070, 61090090, 9950077, 3) ;
Insert into Bank_branch_PL values ( 'Banglr', 77301, 'SmartSav',   54460090, 53090080, 19950077, 3) ;
Insert into Bank_branch_PL values ( 'Hyd', 77301, 'SmartSav',   53060090, 63090080, 29950077, 3) ;
Insert into Bank_branch_PL values ( 'Hyd', 88201, 'BusiCard',  	40030070, 60070080, 10050070,1) ;
Insert into Bank_branch_PL values ( 'Hyd', 88201, 'BusiCard',  	70030070, 60070080, 25060070,1) ;
Insert into Bank_branch_PL values ( 'Hyd', 88201, 'SmartSav', 	40054070, 60070080, 20050070, 2) ;
Insert into Bank_branch_PL values ( 'Banglr', 99101, 'SmartSav',   88660070, 79090090, 10050077, 3) ;

select * from Bank_Inventory_pricing;

-- 1
select round(sum(purchase_cost)), round(avg(estimated_sale_price)) from Bank_Inventory_pricing where mnth=2; 

-- 2
select round(avg(estimated_sale_price),2) from Bank_Inventory_pricing;

-- 3
select *,count(*) as count from Bank_Inventory_pricing where mnth=1 group by Product having count(*)>1;

-- 4
select product, count(*) as count from Bank_Inventory_pricing where purchase_cost > ifnull(Estimated_sale_price, 0) 
group by Product having count(product) > 1;

-- 5
select sum(coalesce(purchase_cost, 2000)) from Bank_Inventory_pricing;

-- 6
select distinct Product,Quantity,Price,purchase_cost,Estimated_sale_price from Bank_Inventory_pricing;

-- 7
select avg(coalesce(purchase_cost, Estimated_sale_price)) as avgg from Bank_Inventory_pricing;

-- 8
select count(distinct product) from Bank_Inventory_pricing;

-- 9
select product, (max(ifnull(purchase_cost, 0)) - min(ifnull(purchase_cost, 0))) as dif from Bank_Inventory_pricing group by product;

-- 10
select mnth, sum(coalesce(purchase_cost, 0)) as cash from Bank_Inventory_pricing group by mnth having mnth= 1 or mnth=2;

-- 11
select product, sum(coalesce(purchase_cost, 0)) as cash from Bank_Inventory_pricing group by product 
having sum(coalesce(purchase_cost, 0))> 6000; 

-- 12
select product, avg(coalesce(purchase_cost, 0)) as cash, 
sum(coalesce(purchase_cost, 0)) as new from Bank_Inventory_pricing group by product 
having avg(coalesce(purchase_cost, 0))< sum(coalesce(purchase_cost, 0));

select Product from Bank_Inventory_pricing group by Product having avg(purchase_cost)<sum(purchase_cost);


-- 13
select product, avg(coalesce(purchase_cost, Estimated_sale_price)) as av from Bank_Inventory_pricing 
group by product;

-- 14
select product, max(Estimated_sale_price), sum(quantity) from Bank_Inventory_pricing
where purchase_cost is not null
group by product having sum(quantity) > 4;

-- 15
select product, avg(coalesce(purchase_cost, 0)) as ag from Bank_Inventory_pricing group by product 
having avg(coalesce(purchase_cost, 0)) < 200;

-- 16
select product, max(Estimated_sale_price) from Bank_Inventory_pricing group by product;

-- 17
select product, 
case
	when avg(purchase_cost) > avg(Estimated_sale_price) then 1.15*avg(Estimated_sale_price)
    else avg(Estimated_sale_price)
end as case_end
from Bank_Inventory_pricing group by product;

-- 18
select product,
case
	when purchase_cost is null then avg(if(price>Estimated_sale_price, price, Estimated_sale_price))
    else avg(purchase_cost)
end as cs
from Bank_Inventory_pricing where product='BusiCard' group by product;


-- 19
select product, avg(coalesce(Estimated_sale_price, purchase_cost)) as agg from Bank_Inventory_pricing group by product;

-- 20
select product, avg(price) price, count(distinct mnth) as occurance from Bank_Inventory_pricing group by product having count(distinct mnth) > 2;






