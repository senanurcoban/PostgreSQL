-- Creating and Using Views
create view View1
As
select departmentid,departmentname,name from department inner join faculty on department.departmentf=faculty.id
select *from View1

-- Create a lessons table
insert into lessons (id,lesson_name,quota,departmentid) values(1,'Algorithm','20',2)
insert into lessons (id,lesson_name,quota,departmentid) values(2,'Artificial intelligence','20',1)
insert into lessons (id,lesson_name,quota,departmentid) values(3,'Electronic Circuits','10',2)
insert into lessons (id,lesson_name,quota,departmentid) values(4,'Information security','10',2)
insert into lessons (id,lesson_name,quota,departmentid) values(5,'Object-oriented programming','40',2)
insert into lessons (id,lesson_name,quota,departmentid) values(6,'Linear Algebra','50',4)
select *from lessons

-- View Güncelleme İşlemleri
-- I. yöntem pop up üzerinden güncelleme işlemi
SELECT department.departmentid,
    department.departmentname,
    faculty.name,
	  lessons.lesson_name
   FROM department
     JOIN faculty ON department.departmentf = faculty.id
     JOIN lessons ON department.departmentid=lessons.departmentid
select *from View1

-- II. yöntem ALTER View üzerinden güncelleme işlemi
-- Önce mevcut view içinde silme işlemi yapıp sonra yenisini ekliyor olacak.
DROP view IF EXISTS View1;
CREATE view View1
AS
SELECT department.departmentid,
    department.departmentname,
    faculty.name,
	lessons.lesson_name,
	lessons.quota
   FROM department
     JOIN faculty ON department.departmentf = faculty.id
     JOIN lessons ON department.departmentid=lessons.departmentid
select *from View1

-- DROP View
create view view2
as
select *from lessons
select *from view2

SELECT lessons.id,
    lessons.lesson_name,
    lessons.quota,
    lessons.departmentid
   FROM lessons
   where id<4
drop view view2

-- View With Check Option
create view view2
as
select * from lessons
select * from view2
select lesson_name,length(lesson_name)from lessons where length(lesson_name)>12

 SELECT lessons.id,
    lessons.lesson_name,
    lessons.quota,
    lessons.departmentid
  FROM lessons
  WHERE length(lessons.lesson_name::text) > 12
  with check option;
  
insert into view2(id,lesson_name) values(8,'Optimization')    -- yeni bir veri eklemek istenildiğinde şart(check option) dikkate alınır.

-- Variable Definition and Usage
do $$
declare x int :=20;
        y int :=15;
        z int;
begin
raise notice 'Number 1: %',x;
raise notice 'Number 2: %',y;
raise notice 'Number 3: %',z;   -- sonuç null 
end $$;

do $$
declare x int :=20;
        y int :=5;
		plus int;
		minus int;
		multiply int;
		divided int;
begin
                plus:=x+y;
		minus:=x-y;
		multiply:=x*y;
		divided:=x/y;
raise notice 'Sayı 1: %',x;
raise notice 'Sayı 2: %',y;
raise notice 'Plus: %',plus;
raise notice 'Minus: %',minus;
raise notice 'Divided: %',divided;
raise notice 'Multiply: %',multiply;
end $$;

-- Assigning Table Values to Variables
do $$
declare total int;
begin
total:=(select count(*) from lessons);
raise notice 'Number of registrations for lessons: %',total;
end $$

do $$
declare total int;
        total2 int;
begin
total:=(select count(*) from lessons);
total2:=(select count(*) from lessons where length(lesson_name)>10);
raise notice 'Number of registrations for lessons: %',total;
raise notice 'Lesson names longer than 10 characters: %',total2;
end $$

-- Decision Structures
do $$
declare 
exam1 int:=75;
exam2 int:=49;
exam3 int:=70;
avarage int;
begin
avarage:=(exam1+exam2+exam3)/3;
raise notice 'Avarage: %',avarage;
if avarage>=50 then
raise notice 'Successful';
else
raise notice 'Unsuccessful';
end if;
end $$

do $$
declare number int:=25;
begin
if number%2=0 then
raise notice 'Even number';
else
raise notice 'Single number';
end if;
end $$

-- Are there more than 3 lessons in part 1?
do $$
declare piece int;
begin
piece=(select count(*)from lessons where departmentid=1);
if piece>=3 then
raise notice 'Part 1 has more than 3 lessons.';
else 
raise notice 'Part 1 has less than 3 lessons.';
end if;
end $$

-- Find out if the department with the department name software has more or less than 3 courses.
do $$
declare piece int;
begin
piece:=(select count(*) from lessons where departmentid=(select id from department where departmentname='Software'));
if piece > 3 then
	raise notice 'The number of lessons is more than 3';
else if piece=3 then
	raise notice 'Lesson number is equal to 3';
else
	raise notice 'Less than 3 lessons';
end if;
end $$

-- Case use 
select lesson_name,departmentid,
       case
	    when departmentid=1
       then 'Software'
	    when departmentid=2
       then 'Math'
            when departmentid=3
       then 'Electronic'
       end duration 
     from lessons
     order by lesson_name;
     
 -- While 
do $$
declare 
     counter int:=1;
     total int:=0;
begin
         while counter<=10 
	 loop
	 raise notice 'Counter: %',counter;
	 total:=counter+total;
	 counter:=counter+1;
	 end loop;
	 raise notice 'Total: %',total;
	 end $$
	 
-- Loop
do $$
declare 
         counter int:=0;
begin 
	 loop
	 exit when counter=5;
	 raise notice 'Counter';
	 counter:=counter+1;
	 --raise notice 'Counter: %',counter;
	 end loop;
	 end $$
	 
-- Pg Sleep
select pg_sleep(4);
select * from lessons

-- Procedure Use
create procedure test()
language plpgsql
as $$
begin
raise notice 'PostgreSql example procedure';
end; $$
call test()    -- call procedure

-- update procedure
create or replace procedure test()
language plpgsql
as $$
begin
raise notice 'PostgreSql example procedure';
raise notice 'PostgreSql example2 procedure';
end; $$
call test()

-- Using Parameterized Procedures
create procedure faculty_add (p1 integer, p2 text)
language sql
as $$
insert into faculty(id,name) values(p1,p2);
$$;
call faculty_add(5,'Music')
select *from faculty

-- Functions
create function total(s1 int,s2 int)
returns int
language plpgsql
as $$
declare 
       result integer;
begin
       result:=s1+s2;
       return result;
end $$;
select total(40,60);

create function kdv(cost float)
returns float
language plpgsql
as $$
begin  
      cost:=cost*0.08+cost;
      return cost;
end $$;
select name,writer,cost,kdv(cost) from books

-- Table Result Functions
create function book(prmt varchar)
    returns table
	(
		idcolumn int,
		bookcolumn varchar,
		bookwritercolumn varchar
	)
	as $$
	begin
	    return query 
		select 
		id,
		name,
		writer
 from
                books
 where 
		name like prmt;
end $$
language plpgsql;
select * from book('%e%')

-- Create a totalfaculty table
select count(*) from faculty
insert into totalfaculty(number) values (5)
select * from totalfaculty

-- Trigger
create or replace function test1()
       returns trigger
as $$
begin
update totalfaculty set number=number+1;
return new;
end $$
language plpgsql;

create trigger testtrig
after insert 
on faculty
for each row 
execute procedure test1();

-- Using Variables in Trigger
create or replace function test2()
       returns trigger
as $$
declare 
       long integer;
begin
long:=(select length(name) from faculty order by id desc limit 1)
update totalfaculty2 set number=number+long;
return new;
end $$
language plpgsql;

create trigger TestTrig2
after insert
on faculty
for each row
execute procedure test2();  


