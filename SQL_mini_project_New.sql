select * from customer;
select * from `orderitem`;
select * from `orders`;
select * from `product`;
select * from `supplier`;
use supply_chain1;

-- 1
show tables;
-- 2 
select count(Id), Country from customer group by Country order by count(distinct Id) desc;
-- 3
select ProductName from product where IsDiscontinued = 0;
-- 4
select a.CompanyName, b.ProductName from supplier a join product b on a.Id = b.SupplierId;
-- 5
select * from customer where Country = 'Mexico';
-- 6
select ProductName from product where UnitPrice=(select max(UnitPrice) from orderitem);
-- 7
select count(a.SupplierId) items, a.SupplierId, b.CompanyName from product a join supplier b on a.SupplierId = b.Id 
group by a.SupplierId, b.CompanyName order by count(a.SupplierId) desc limit 1;
-- or
select CompanyName from supplier where Id=(select SupplierId from product group by SupplierId order 
by count(Id) desc limit 1);
-- 8
select count(OrderNumber), month(OrderDate), year(OrderDate) from orders group by 
month(OrderDate), year(OrderDate) order by year(OrderDate), month(OrderDate);
-- 9
select count(CompanyName), Country from supplier group by Country order by count(CompanyName) desc limit 1;
-- 10
select * from customer where Id not in (select CustomerId from orders);

-- SECTION B------------------------ 1
select count(a.Id), a.Id, a.ProductName from product a join orderitem b on a.Id = b.ProductId 
group by a.Id, a.ProductName order by count(a.Id) desc;
-- 2
select year(OrderDate), count(OrderNumber) from orders group by year(OrderDate);
-- 3
select year(OrderDate), sum(TotalAmount) from orders group by year(OrderDate);
-- 4
select b.CustomerId, a.FirstName, a.LastName, sum(b.TotalAmount) from customer a join orders b on a.Id= b.CustomerId 
group by b.CustomerId, a.FirstName, a.LastName order by sum(b.TotalAmount) desc limit 1;
-- 5
select b.CustomerId, a.FirstName, a.LastName, sum(b.TotalAmount) from customer a join orders b on a.Id= b.CustomerId 
group by b.CustomerId, a.FirstName, a.LastName order by sum(b.TotalAmount) desc;

-- 6
SELECT firstname, lastname, TotalAmount,
LAG(totalamount,1) OVER (PARTITION BY c.Id ORDER BY orderDate ) Prev_OrderAmount
FROM orders o
JOIN customer c
on o.customerId=c.Id;
-- 7
select a.CustomerId, b.FirstName, b.LastName, 
OrderDate, lag(OrderDate, 1) over(partition by CustomerId order by OrderDate) 
from orders a join customer b on a.CustomerId = b.Id;

-- 8
with cte as (select ProductId, sum(UnitPrice*Quantity) rev from orderitem 
group by ProductId order by sum(UnitPrice*Quantity) desc limit 3)
select cte.ProductId, b.ProductName, c.CompanyName, cte.rev from cte join product b on cte.ProductId = b.Id 
join supplier c on b.SupplierId = c.Id;
-- 9
select distinct a.FirstName, a.LastName, last_value(b.OrderDate) 
over(partition by b.CustomerId)
from customer a join orders b on a.Id= b.CustomerId;
-- 10
select a.OrderId, b.ProductName, c.CompanyName from orderitem a join product b on a.ProductId= b.Id 
join supplier c on b.SupplierId= c.Id;
--------------- c
-- 1
select a.FirstName, a.LastName, c.Quantity from customer a join orders b on a.Id = b.Id join 
orderitem c on b.Id = c.Id 
group by a.FirstName, a.LastName having c.Quantity> 10 order by c.Quantity desc;
-- 2
select ProductName from product where Id in (select distinct ProductId from orderitem where Quantity =1);
-- 3
select CompanyName from supplier where Id in (select SupplierId from product where UnitPrice >100);
-- 4
select 'Customer' as Type, concat(FirstName, ' ', LastName) as ContactName, City, Country, Phone from customer 
union all
select 'Supplier', ContactName, City, Country, Phone from supplier;
-- 5 

select a.FirstName, a.LastName, b.FirstName, b.LastName from customer a join customer b 
on a.Country = b.Country and a.City = b.City and a.Id <> b.Id order by a.Country;
-- ------------------- D 
-- 1
select b.OrderId, sum(b.UnitPrice*b.Quantity -  a.UnitPrice*b.Quantity) saved from product a
join orderitem b on a.Id = b.ProductId group by b.OrderId order by saved;
-- 2
select sum(a.Quantity) sold, a.ProductId, b.ProductName from orderitem a join product b on a.ProductId = b.Id 
group by a.ProductId order by sold desc;

-- he should sell ProductId- 60, 59, 31, 56 and 16- since they have most number of sales. 

-- b 
select sum(a.Quantity) sold, a.ProductId, b.ProductName, c.CompanyName 
from orderitem a join product b on a.ProductId = b.Id 
join supplier c on b.SupplierId = c.Id 
group by a.ProductId, c.CompanyName order by sold desc;
-- His competetions are - 'Gai pâturage', 'Formaggi Fortini s.r.l.', 'Pasta Buttini s.r.l.', 'Pavlova, Ltd.'

-- 3 a
select a.FirstName, a.LastName, a.Country, 
b.CompanyName, b.ContactName, b.Country from customer a join supplier b on a.Country = b.Country;
-- b
select a.FirstName, a.LastName, a.Country from customer a where not exists 
(select b.Country from supplier b where a.Country = b.Country);
-- c 
select a.CompanyName, a.Country from supplier a where not exists 
(select b.Country from customer b where a.Country = b.Country);

-- 4
create view supp as
with cte as(
select a.SupplierId, sum(b.UnitPrice*b.Quantity) sales, c.CompanyName, c.Country,
rank() over(partition by c.Country order by sum(b.UnitPrice*b.Quantity) desc) rnk
from product a join orderitem b on a.Id = b.ProductId join supplier c on a.SupplierId = c.Id
group by a.SupplierId) 
select cte.* from cte where cte.rnk <3;

select * from supp;

-- 5.Find out for which products, UK is dependent on other countries for the supply. 
-- List the countries which are supplying these products in the same list.
with cte as (
select Id,SupplierId, ProductName from product where Id in (
select distinct ProductId from orderitem where OrderId in (
select a.Id from orders a join customer b on a.CustomerId = b.Id and b.Country like '%UK%')))
select cte.ProductName, bb.Country from cte join supplier bb on cte.SupplierId = bb.Id 
and bb.Country not like '%UK%';






