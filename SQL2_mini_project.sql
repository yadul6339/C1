-- SQL 2 MINI Project. 

-- 1
CREATE TABLE combined_table AS
SELECT 
	market.Ord_id, market.Prod_id, market.Ship_id, market.Cust_id, Sales, 
    Discount, Order_Quantity, Profit, Shipping_Cost, Product_Base_Margin, 
    cust.Customer_Name, cust.Province, cust.Region, cust.Customer_Segment, 
    orders.Order_Date, orders.Order_Priority, prod.Product_Category, 
    prod.Product_Sub_Category, orders.Order_ID, ship.Ship_Mode, ship.Ship_Date
FROM
    market_fact AS market
INNER JOIN
	cust_dimen AS cust ON market.Cust_id = cust.Cust_id
INNER JOIN
	orders_dimen AS orders ON orders.Ord_id = market.Ord_id
INNER JOIN
	prod_dimen AS prod ON prod.Prod_id = market.Prod_id
INNER JOIN
	shipping_dimen AS ship ON ship.Ship_id = market.Ship_id;

-- 2 Find the top 3 customers who have the maximum number of orders

select * from cust_dimen where Cust_id in(
select Cust_id from market_fact group by Cust_id order by count(Ord_id) desc)  limit 3;

-- 3

select a.Order_ID, str_to_date(b.Ship_Date, '%Y-%m-%d') ship_date, str_to_date(a.Order_Date, '%d-%m-%Y') order_date, 
datediff(str_to_date(b.Ship_Date, '%Y-%m-%d'), str_to_date(a.Order_Date, '%d-%m-%Y')) diff from orders_dimen a join shipping_dimen b on a.Order_ID = b.Order_ID order by diff desc;

-- 4 

select * from cust_dimen where Cust_id = (
select Cust_id from market_fact where Ord_id = ( 
with o2s as (
select a.Order_ID, 
datediff(str_to_date(b.Ship_Date, '%Y-%m-%d'), str_to_date(a.Order_Date, '%d-%m-%Y')) diff from orders_dimen a join shipping_dimen b on a.Order_ID = b.Order_ID order by diff desc limit 1)
select aa.Ord_id from orders_dimen aa join o2s on aa.Order_ID = o2s.Order_ID
where aa.Order_ID = o2s.Order_ID));

-- 5. 
select distinct Prod_id, sum(Sales) over(partition by Prod_id ) summ from market_fact order by summ desc;

-- 6 
select distinct Prod_id, sum(Profit) over(partition by Prod_id) profit from market_fact order by profit desc;

-- 7a. Count the total number of unique customers in January.
select distinct cust_id, Ord_id from market_fact where Ord_id in (
select Ord_id from orders_dimen where 
month(str_to_date(Order_Date, '%Y-%m-%d')) = 1);

-- 7b and how many of them came back every month over the entire year in 2011

with cte as (
select month(str_to_date(Order_Date, '%Y-%m-%d')) mon, Ord_id from orders_dimen),
cte2 as (
select Cust_id, Ord_id from market_fact),
jan_cust as (
select distinct Cust_id from market_fact where Ord_id in (
select Ord_id from orders_dimen where 
month(str_to_date(Order_Date, '%Y-%m-%d')) = 01))
select cte.mon, count(distinct cte2.cust_id) from cte join cte2 on cte.Ord_id = cte2.ord_id where cte2.cust_id in 
(select Cust_id from jan_cust) group by cte.mon;

-- 8

use mini2;
select * from market_fact;
select * from orders_dimen;

with mon_cus as (
select distinct m.Cust_id, 
month(str_to_date(o.Order_Date, '%Y-%m-%d')) mon,
count(Cust_id) over(partition by m.Cust_id) rep
from orders_dimen o join 
market_fact m on o.Ord_id = m.Ord_id),
cte2 as (
select mon_cus.mon, mon_cus.cust_id,
lag(mon, 1) over(partition by mon_cus.cust_id) as prev_month
from mon_cus 
order by mon asc)
select  cte2.mon,
sum(case when prev_month <2 then 1 else null end) as irregular, 
sum(case when isnull(prev_month) then 1 else null end) as churned,
sum(case when prev_month > 1  then 1 else null end) as retained
from cte2 group by cte2.mon;








-- @nurag















































