--Database tables were created.

create table product
(
	id integer primary key not null,
	name varchar(15) not null,
	brand varchar(20),
	stock integer,
	category varchar(15)
)

create table category
(
	id integer primary key not null,
	name text
)

--The table has been deleted.
drop table category

--Insert database data to table.
insert into customer(id,name,surname,city) values(8,'Sena','Çoban','Ankara')

--Fetch desired fields of a table.
select id,name,surname from customer

--Only the desired data was obtained with this query.
select city from customer

--All data was obtained with this query.
select * from customer

--Sort by id
select * from customer order by id

--Conditional inquiries
select *from customer where name='Sena'
select *from customer where city='Ankara' and id=4
select *from customer where city='Ankara'and id=4 or city='Mardin'
select *from customer where city='Ankara'and id=4 or city='Mardin' or surname='Süper'

-- Balance column has been added to the table.
select balance from customer

-- use of where condition
select * from customer where balance>3000 or balance<=2700

--There are two results here.City and balance status were obtained together, surname status separately.
select * from customer where city='Ankara' and balance>4000 or surname='Çoban'

--LIKE operator
select * from customer where name like '%e%'
select * from customer where name like 'A%'
select * from customer where name like 'Se%'
select * from customer where name like '%ed%'
select * from customer where name like '%a'
-- Not Like operator
select * from customer where name not like '%a%'

-- DELETE 
DELETE from customer where id=8

--UPDATE
update customer set balance=5750 where id=1
update customer set city='Bursa' where city='İzmir'

--COUNT: How many data are in a table?
select count(*) from customer
select count(*) from customer where city='Ankara'
select count(*) from customer where city='Ankara' and balance>5000
select count(*) from customer where city='Ankara' or balance>4000

--Sum
select sum(balance) from customer
select sum(balance) from customer where city='Ankara'
select sum(balance) from customer where city!='Ankara'

--Avg:Average of values for a column.
select avg(balance) from customer
select avg(balance) from customer where city='Bolu'

-- Max/Min
select min(balance) from customer
select max(balance) from customer
select min(balance),max(balance)from customer
select max(balance)-min(balance) from customer
select min(balance) from customer where city='Ankara'

-- Group By
select city,count(*) from customer group by city
select city,count(*) as person from customer group by city   -- count column name changed to person
select city,count(*) as person from customer group by city order by city
select city,count(*) as person from customer group by city order by count(*)
select city,count(*) as person from customer group by city order by count(*) desc
select city,sum(balance) from customer group by city
select city,avg(balance) from customer group by city

--Having
select city,count(*) from customer group by city having count(*)>1
select avg(balance) as avarage,city from customer group by city having avg(balance)>5000
select avg(balance) as avarage,city from customer group by city having avg(balance)>5000 and city like '%s%'
select avg(balance) as avarage,city from customer group by city having avg(balance)>5000 or city like '%n%'

