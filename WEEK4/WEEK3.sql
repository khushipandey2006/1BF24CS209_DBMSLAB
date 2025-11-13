SHOW DATABASES;
create database Bank_INFO;
use Bank_INFO;
create table Branch(Branch_name varchar(30), Branch_city varchar(20), Assests int, primary key(Branch_name));
create table Bank_Account(Acc_no int, Branch_name varchar(30), Balance int, primary key(Acc_no), foreign key(Branch_name) references Branch(Branch_name));
create table Bank_Customer(Customer_name varchar(20), Customer_street varchar(30), Customer_city varchar(20), primary key(Customer_name));
create table Depositor(Customer_name varchar(20), Acc_no int, primary key(Customer_name, Acc_no), foreign key(Customer_name) references Bank_Customer(Customer_name), foreign key(Acc_no) references Bank_Account(Acc_no));
create table Loan(Loan_no int, Branch_name varchar(30), Amount int, primary key(Loan_no), foreign key(Branch_name) references Branch(Branch_name));
insert into Branch values('SBI_Chamrajpet','Bangalore',50000);
insert into Branch values('SBI_ResidencyRoad','Bangalore',10000);
insert into Branch values('SBI_ShivajiRoad','Bombay',20000);
insert into Branch values('SBI_ParliamentRoad','Delhi',10000);
insert into Branch values('SBI_JantarMantar','Delhi',20000);
insert into Bank_Account values
(1,'SBI_Chamrajpet',2000),
(2,'SBI_ResidencyRoad',5000),
(3,'SBI_ShivajiRoad',6000),
(4,'SBI_ParliamentRoad',9000),
(5,'SBI_JantarMantar',8000),
(6,'SBI_ShivajiRoad',4000),
(7,'SBI_ResidencyRoad',4000),
(8,'SBI_ParliamentRoad',3000),
(9,'SBI_ResidencyRoad',5000),
(10,'SBI_JantarMantar',2000);

insert into Bank_Customer values
('Avinash','BullTemple_Road','Bangalore'),
('Dinesh','Bannergatta_Road','Bangalore'),
('Mohan','NationClg_Road','Bangalore'),
('Nikhil','Akbar_Road','Delhi'),
('Ravi','Prithviraj_Road','Delhi');

insert into Depositor values
('Avinash',1),
('Dinesh',2),
('Nikhil',4),
('Ravi',5),
('Avinash',8),
('Nikhil',9),
('Dinesh',10),
('Nikhil',10);

insert into Loan values
(1,'SBI_Chamrajpet',1000),
(2,'SBI_ResidencyRoad',2000),
(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParliamentRoad',4000),
(5,'SBI_JantarMantar',5000);

alter table Branch change column Assests Assest_in_lakhs real; 
select Branch_name,Assests_in_lakhs from Branch;
desc Branch;
select Branch_name,Assest_in_lakhs from Branch;
select Customer_name from Depositor d join Bank_Account b on d.Acc_no=b.Acc_no group by Customer_name having count(*)>=2;
create view Loan_Sum as select Branch_name, sum(Amount) as Total_Loan from Loan group by Branch_name;
select * from Loan_Sum;

SELECT Customer_name
From depositor d
Join Bank_Account a ON d.Acc_no=a.Acc_no
where a.Branch_name in(
select Branch_name 
from branch 
where Branch_city='Delhi')
group by Customer_name
having count(distinct a.Branch_name)=(
select count(*) 
from branch where Branch_city='Delhi');

use Bank_INFO;
show tables;

select distinct Customer_name
from bank_customer c
where Customer_name in(
select d.Customer_name 
from depositor d
join bank_account a
on d.Acc_no=a.Acc_no
join loan l on a.Branch_name=l.Branch_name);

select distinct c.Customer_name 
from bank_customer c
where c.Customer_name not in (
select Customer_name 
from depositor d)
and exists (select 1 from loan);

select distinct d.Customer_name 
from depositor d
join bank_account a on d.Acc_no=a.Acc_no 
join loan l on a.Branch_name=l.Branch_name
where a.Branch_name in (
select Branch_name 
from branch 
where Branch_city='Bangalore');

delete from bank_account 
where Branch_name in (
select Branch_name from branch 
where Branch_city='Bombay'); 

select * from bank_account;

update bank_account set Balance=Balance*0.05;