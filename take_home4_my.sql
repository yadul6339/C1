-- 1
select a.Account_Number, a.Account_type, sum(b.Transaction_amount) friyay, sum(c.Transaction_amount) other_days from bank_account_details a join bank_account_transaction b on a.Account_Number = b.Account_Number
and dayname(b.Transaction_Date) = 'Friday' and a.Account_type like '%credit%' join bank_account_transaction c on b.Account_Number = c.Account_Number and dayname(c.Transaction_Date) <> 'Friday'
group by a.Account_Number, a.Account_type, date_format(b.Transaction_Date, '%Y-%m'); 

-- 2

select a.Account_Number, ab.Account_type, 
a.Transaction_Date, 
a.Transaction_amount amount, 
sum(abc.Transaction_amount) non_holiday
from bank_account_transaction a
join bank_holidays b 
on a.Transaction_Date = b.Holiday 
join bank_account_details ab on
a.Account_Number = ab.Account_Number 
and ab.Account_type 
like '%credit%' join bank_account_transaction abc on 
ab.Account_Number = abc.Account_Number 
and abc.Transaction_Date <> b.Holiday  
group by a.Account_Number, 
ab.Account_type, a.Transaction_Date 
having abs(a.Transaction_amount) > 
abs(sum(abc.Transaction_amount));

-- 3

select a.Account_Number, a.Transaction_amount, 'Happy Holiday' as messege, a.Transaction_Date from bank_account_transaction a join  bank_holidays b on a.Transaction_Date = b.holiday and 
month(a.Transaction_Date) = 4;

-- 4

select b.Account_Number, c.Transaction_Date, sum(c.Transaction_amount * 0.07) as interest from bank_account_relationship_details a 
join bank_account_relationship_details b on a.Account_Number= b.Linking_Account_Number and a.Account_type <> b.Account_type and b.Account_type like '%recurr%' join bank_account_transaction c
on b.Account_Number = c.Account_Number and (c.Transcation_channel like '%ecs%' or c.Transcation_channel like '%deposit%') group by b.Account_Number having datediff(curdate(), c.Transaction_Date)> 30;

-- 5

select a.Account_Number, a.Account_type, b.Linking_Account_Number, b.Account_type, count(c.Transaction_amount) as cunt from bank_account_relationship_details a join bank_account_relationship_details b on 
a.Account_Number = b.Linking_Account_Number and b.Account_type like '%credit%' join bank_account_transaction c on b.Account_Number = c.Account_Number 
group by a.Account_Number, a.Account_type, b.Linking_Account_Number, b.Account_type having count(c.Transaction_amount) > 1;

-- 6

select a.Account_Number, a.Account_type, b.Linking_Account_Number, b.Account_type, count(c.Transaction_amount) as cunt from bank_account_relationship_details a join bank_account_relationship_details b on 
a.Account_Number = b.Linking_Account_Number and b.Account_type like '%add%' join bank_account_transaction c on b.Account_Number = c.Account_Number 
group by a.Account_Number, a.Account_type, b.Linking_Account_Number, b.Account_type having count(c.Transaction_amount) >= 1;

-- 7

select customer_id, length(customer_id) from bank_customer_export natural join bank_customer;

-- 8
-- Multiple solutions for this. 
-- what Namrata Mam got output - or getting the same output do- 

select a.customer_id, a.customer_name 
from bank_customer_export a natural inner join bank_customer b;

-- if you want to get all common column columns, do this - 

select * from bank_customer_export a natural left join bank_customer b;
-- or
select a.customer_id, a.customer_name from bank_customer a, bank_customer_export b where a.customer_id= b.customer_id;
















