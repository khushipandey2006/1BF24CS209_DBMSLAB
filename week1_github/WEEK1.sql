show databases;
create database carinsurance;
use carinsurance;
create table person(driver_id varchar(10),name varchar(30), address varchar(50), primary key (driver_id));
create table car (reg_num varchar(10), model_name varchar(10), year int, primary key(reg_num));
create table accident(report_num int, accident_date date, location varchar(30), primary key(report_num));
create table owns(driver_id varchar(10), reg_num varchar(10), primary key(driver_id,reg_num), foreign key (driver_id) references person(driver_id), foreign key(reg_num) references car(reg_num));
create table participated(driver_id varchar(10), reg_num varchar(10), report_num int, damage_amount int, primary key(driver_id, reg_num, report_num), foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num), foreign key(report_num) references accident(report_num));
insert into person values('A01','Richard','Srinivas nagar');
insert into person values('A02','Pradeep','Rajaji nagar');
insert into person values('A03','Smith','Ashok nagar');
insert into person values('A04','Venu','N R Colony');
insert into person values('A05','Jhon','Hanumanth nagar');
insert into car values('KA052250','Indica',1990);
insert into car values('KA031181','Lancer',1957);
insert into car values('KA095477 ','Toyota',1998);
insert into car values('KA053408 ','Honda',2008);
insert into car values('KA041702 ','Audi',2005);
insert into accident values(11, '2001-01-03','Mysore Road');
insert into accident values(12, '2002-02-04','South End Circle');
insert into accident values(13, '2021-01-03','Bull temple Road');
insert into accident values(14, '2017-02-08','Mysore Road');
insert into accident values(15, '2004-03-05','Kanakpura Road');
insert into owns values(