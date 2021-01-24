
use temp2;
-- 1
start transaction;
update account_details set balance = balance - 1000 where first_name = 'Monica' and last_name = 'Irodov';
update account_details set balance = balance + 1000 where first_name = 'Joseph' and last_name = 'Cane';
commit;

-- 2

start transaction;
update account_details set balance = balance - 1000 where first_name = 'Monica' and last_name = 'Irodov';
update account_details set balance = balance + 1000 where first_name = 'Peter' and last_name = 'Koshnov';
-- rolling back
rollback;
commit;

-- 3

Lock table id_passwords write;
unlock tables;
select * from account_details;
select * from `bank_account`;
select * from `bank_customer`;
select * from `id_passwords`;
-- 4
use temp2;
create view details as (
select employee_id, first_name, last_name, salary from employee_details);
select * from details;

-- 5
create or replace view details as (
select employee_id, first_name, last_name, salary, hire_date, job_id 
from employee_details where job_id = 'IT_PROG');

-- 6
 create view check_salary as  
 (select employee_id, first_name, last_name, job_id, salary from employee_details
 where salary>50000);
 
 -- 7
 create view location_details as
select department_name, manager_id, location_id from department_details
where department_name='Shipping';

-- 8
 create view salary_range as
 select employee_id, first_name, last_name, job_id, salary from employeedetails
 where salary between 30000 and 50000;

-- 9
create view pattern_matching as
select employee_id, first_name, job_id,salary from employeedetails where first_name like '%l';

-- 10
drop view pattern_matching, salary_range ,location_details;

-- 11
create view employee_department as 
select e.*,d.*
from employee_details e
inner join department_details d 
on e.department_id=d.department_id;

-- 12
select * from `admission_predict_one`;
select * from `admission_predict_two`;
create view SLR_Focus as
select `Serial No.` ,SOP,LOR,Research from admission_predict_one
where Research=1;

-- 13
alter view SLR_FOCUS as
select `Serial No.`,SOP,LOR,(SOP+LOR)/2 as SOP_LOR_AVG , Research from admission_predict_one
where Research=1;

-- 14
set transaction isolation level repeatable read;
start transaction;
update bank_customer set telephone =null where customer_id> 123008;

start transaction;
insert into bank_customer values ( 123009, 'Ropert' , '99-Bechkingam', 'CA' , 1867888950); 
commit;

-- 15
select * from `bank_account`;

set transaction isolation level read committed; -- can choose repeatable read too
start transaction;
update bank_customer set address="2999 New brighton" where customer_id = 123002;
start transaction;
update bank_customer set telephone =1898918991 where customer_id = 123002;
commit;

-- 16
START TRANSACTION;
SELECT * FROM bank_customer LOCK IN SHARE MODE;

-- 17
set transaction isolation level serializable;
start transaction;
update bank_account 
set balance_amount=1.03*balance_amount where customer_id = 123001;

-- 18
# session one
set transaction isolation level serializable;
start transaction;
update bank_account set Balance_amount = 1.3*Balance_amount where Customer_id = 123001;
commit;

# post session 1

set transaction isolation level repeatable read;
select * from bank_account for update;
update bank_account set Balance_amount = 1000 where Account_Number = '4000-1956-3401';

start transaction;
update bank_account set Balance_amount = 2000 where Account_Number = '4000-1956-3401';
commit;













































































































