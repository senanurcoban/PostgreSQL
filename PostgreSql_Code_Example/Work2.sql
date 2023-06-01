-- Create a job table
select * from customer where job=(select id from job where job_name='Teacher')

-- Sub Query
select * from customer where balance=(select max(balance)from customer)
select * from customer where balance=(select max(balance) from customer where city='Ankara')
update customer set balance=balance+balance*0.1 where job=(select id from job where job_name='Computer Engineer')
select * from customer where city='Ankara' and job=(select id from job where job_name='Teacher')

-- Truncate
truncate table product

-- İnner Join
select customer.name,surname,city,job.job_name from customer inner join job on customer.job=job.id

-- Faculty and Department tables were created.A relationship(one-to-many relationship) has been established between the two tables.
insert into faculty (id,name) values (3,'Iibf')
select * from faculty
insert into department(departmentid,departmentname,departmentf) values(2,'Software',1)
select * from department
select * from department where departmentf=(select id from faculty where name='Engineering')
select departmentf,count(*) from department group by departmentf order by departmentf
select name,count(*) from department inner join faculty on department.departmentf=faculty.id
group by name order by name
insert into department (departmentid,departmentname,departmentf) values(8,'Metallurgy',1)

-- Query that gives the name of the faculty with the most departments
select name from faculty inner join department on faculty.id=department.departmentf group by name order by count(*) desc limit 1

-- Left Join [Sol tarafta bulunan alanlar sağ tarafta yoksa orası null olur.]
select departmentid,departmentname,name from department left join faculty on department.departmentf=faculty.id

-- You brought all the faculties. But because there were no partitions in return, "null values" came as well.
select departmentid,departmentname,name from faculty left join department on faculty.id=department.departmentf

-- Right Join [Sağ tarafta bulunan alanlar sol tarafta yoksa null olur.]
select id,name,departmentname from faculty right join department on faculty.id=department.departmentf
-- "null values" came as well
select id,name,departmentname from department right join faculty on faculty.id=department.departmentf

-- Full Join
select customer.id,name,surname,city,job.job_name from customer full join job 
on customer.job=job.id

-- Cross Join
select departmentname,name from department cross join faculty

-- Intersect and Except [Common and different fields are listed.]
select * from department2                   select * from department2                   
intersect                                   except
select *from department3                    select *from department3

-- Union and Union All [It is written as a single table by combining two tables.]{Union->Same values are written once, Union All->Same values are written more than once}
select * from department2                   select * from department2 
union                                       union all
select *from department3                    select *from department3

-- Textual Functions (Ascii,Concat,Concat_Ws,Left,Right,Lenght,Replace,Reverse,Substring)
select ASCII('A')
select CONCAT('Hello','Sql')
select CONCAT_WS('*','Hello','Sql')
select left ('Hello World',3)
select right ('Hello World',3)
select length ('Hello World')
select id,replace (name,'i','ı') from department3
select reverse(name) from department3
select substring('Murat Yücedağ',4,2)
select lower(name),upper(name) from department3

-- Mathematical Functions (Abs,Ceil,Floor,Pi,Round,Random,Power,Log,Sign,Sqrt)
select abs(-5)
select ceil(4.78)
select floor(4.78)
select pi()
select power(2,4)
select Random()    --in the range of 0 and 1 
select round(18.1529,2)
select sign(25)  --1     select sign(-25) -- -1   select sign(0) --0
select sqrt(625)
select log(50)

-- Create a books table
select * from books
insert into books(id,name,writer,date) values(6,'Satranç','Zweig','11.05.2023')

-- Date Time Functions (Current Date,Current Time,Select Now)
select current_date            -- current date, time value comes
select current_time
select now()

-- Age command
select age(timestamp '07.05.2023')
select  name,date,age(now(),date) from books

