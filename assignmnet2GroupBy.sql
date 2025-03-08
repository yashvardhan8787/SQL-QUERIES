create Database assignmnet2GroupBy


use assignmnet2GroupBy


create table Sales(
sale_id int primary key ,
customer_id int not null ,
product_id int not null,
sales_date date ,
quantity int check(quantity >= 0),
price Money check(price >= 0) ,
region varchar(55))

truncate table Sales

Alter table Sales ADD Constraint fk_customerId FOREIGN KEY (customer_id) REFERENCES Customer(Id); 



Create table Customer(Id int primary Key)
Drop table Sales

select * from Sales


insert into Sales values
(2,102,1001,'2025-02-12',6,3000,'vadodara'),
(3,104,1002,'2025-02-12',7,2500,'ahemdabad'),
(4,105,1003,'2025-02-12',4,300,'rajkot'),
(5,107,1005,'2025-02-12',9,350,'surat'),
(6,109,1001,'2025-02-12',11,4000,'vadodara'),

(7,111,1006,'2025-02-12',4,30,'anand'),
(8,121,1004,'2025-02-12',5,3080,'surat'),
(9,118,1006,'2025-02-12',3,2000,'anand'),
(10,109,1002,'2025-02-12',10,20,'ahemdabad')


select product_id, sum(price) as total_sales_amount from Sales  group by product_id

select region, avg(quantity) as avg_qyt from Sales  group by region


select customer_id,count(*) as 'numer of sales ' from Sales group by customer_id

select region, max(price) as max_sale_amount from Sales group by region 


select product_id, min(quantity) as minimum_qyt_sales from Sales group by product_id


select product_id, sum(price) as total_sales_amount from Sales  group by product_id having(sum(price) > 1000)


select region, avg(quantity) as avg_qyt from Sales  group by region having( count(*) > 10)



select customer_id,sum(price) as total_sales_amount from Sales group by customer_id having (sum(price) >500)

select customer_id,avg(price) as avg_sales_amount from Sales group by customer_id having (count(*) >5)

select region, sum(price) as total_sales_amount from Sales group by region having (sum(price) >5000)


-- write a query to find a number of customers for each region .

select region , count(*) as no_of_cutomners from sales group by region order by no_of_cutomners  desc

