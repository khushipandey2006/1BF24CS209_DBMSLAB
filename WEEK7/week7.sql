CREATE DATABASE Supplier;
use Supplier;
CREATE TABLE Supplier(
sid INT,
sname VARCHAR(30),
city VARCHAR(20),
PRIMARY KEY(sid));

CREATE TABLE Parts(
pid INT,
pname VARCHAR(50),
color VARCHAR(10),
PRIMARY KEY (pid));

CREATE TABLE Catalog(
sid INT,
pid INT,
cost INT,
PRIMARY KEY(sid,pid),
FOREIGN KEY(sid) REFERENCES Supplier(sid),
FOREIGN KEY(pid) REFERENCES Parts(pid));

INSERT INTO Supplier VALUES
(10001,'Acme Widget','Bangalore'),
(10002,'Johns','Kolkata'),
(10003,'Vimal','Mumbai'),
(10004,'Reliance','Delhi');
SELECT * FROM Supplier;

INSERT INTO Parts VALUES
(20001,'Book','Red'),
(20002,'Pen','Red'),
(20003,'Pencil','Green'),
(20004,'Mobile','Green'),
(20005,'Charger','Black');
SELECT * FROM Parts;

INSERT INTO Catalog VALUES
(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);
SELECT * FROM Catalog;

SELECT DISTINCT P.pname
FROM Parts P
JOIN Catalog C
ON P.pid=C.pid;

select s.sname
from Supplier s
join Catalog c
on s.sid=c.sid
group by s.sname
having count(distinct c.pid)=(select count(*) from Parts);

select s.sname
from Supplier s
join Catalog c on s.sid=c.sid
join Parts p on p.pid=c.pid
where p.color='Red'
group by s.sname
having count(distinct p.pid)=(select count(*) from Parts where color='Red');

select p.pname
from Parts p
join Catalog c on p.pid=c.pid
join Supplier s on s.sid=c.sid
group by p.pname
having count(distinct s.sname)=1 and max(s.sname)='Acme Widget';

select distinct c1.sid
from Catalog c1
where c1.cost>(select avg(c2.cost) from Catalog c2 where c2.pid=c1.pid);

select p.pid,p.pname,s.sname
from Parts p
join Catalog c1 on p.pid=c1.pid
join Supplier s on c1.sid=s.sid
where c1.cost=(select max(c2.cost) from Catalog c2 where c2.pid=p.pid);