CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10, 2),
    order_date DATE
);

INSERT INTO orders (order_id, customer_name, product_name, quantity, price_per_unit, order_date) VALUES
(1, 'Alice', 'Laptop', 1, 900.00, '2023-01-10'),
(2, 'Bob', 'Mouse', 2, 25.50, '2023-01-11'),
(3, 'Alice', 'Keyboard', 1, 45.00, '2023-01-12'),
(4, 'Carol', 'Monitor', 2, 200.00, '2023-01-13'),
(5, 'Bob', 'Laptop', 1, 950.00, '2023-01-14'),
(6, 'Dan', 'Mouse', 3, 22.00, '2023-01-15'),
(7, 'Alice', 'Monitor', 1, 195.00, '2023-01-16'),
(8, 'Eve', 'Keyboard', 2, 47.00, '2023-01-17'),
(9, 'Frank', 'Laptop', 1, 980.00, '2023-01-18'),
(10, 'Eve', 'Mouse', 1, 23.00, '2023-01-19');


--?? Topic 2: Filtering & Aggregation – Practice Questions
--Show the total number of orders placed.
select count(*) from orders
--Display the total quantity ordered for each product.
select product_name, sum(quantity) from orders group by product_name


--Find the average price per unit for each product.
select product_name, Avg(price_per_unit) from orders group by product_name


--Count the number of orders placed by each customer.

select customer_name , count(*) from orders group by customer_name

--Show the total revenue (quantity × price_per_unit) per product.
select product_name ,SUM(quantity * price_per_unit) as total_revenue from orders group by product_name

--List customers who placed more than 2 orders.
select * from Orders

--Show the product that generated the highest total revenue.

select customer_name , count(*) from orders group by customer_name having count(*) >=2

--Find the minimum and maximum price per unit for each product.
select min(price_per_unit) , max(price_per_unit) from  orders

--List the total revenue per customer, but only for customers whose revenue exceeds 500.
select customer_name , sum(quantity * price_per_unit) as revenue from orders group by customer_name having sum(quantity * price_per_unit) > 500 

--Show the average quantity per order per product, 
--Sorted by average quantity descending.

select product_name ,avg(quantity) as avgQ from orders group by product_name



-- Drop if they already exist
DROP TABLE IF EXISTS paintings;
DROP TABLE IF EXISTS artists;

-- Artists table
CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100),
    country VARCHAR(100)
);

-- Paintings table
CREATE TABLE paintings (
    painting_id INT PRIMARY KEY,
    title VARCHAR(100),
    artist_id INT,
    style VARCHAR(50),
    year INT,
    price INT
);


-- Insert artists
INSERT INTO artists VALUES
(1, 'Leonardo da Vinci', 'Italy'),
(2, 'Pablo Picasso', 'Spain'),
(3, 'Vincent van Gogh', 'Netherlands'),
(4, 'Claude Monet', 'France'),
(5, 'Frida Kahlo', 'Mexico');

-- Insert paintings
INSERT INTO paintings VALUES
(101, 'Mona Lisa', 1, 'Renaissance', 1503, 8000000),
(102, 'The Last Supper', 1, 'Renaissance', 1495, 6000000),
(103, 'Guernica', 2, 'Cubism', 1937, 5000000),
(104, 'Starry Night', 3, 'Post-Impressionism', 1889, 7000000),
(105, 'Sunflowers', 3, 'Post-Impressionism', 1888, 3000000),
(106, 'Water Lilies', 4, 'Impressionism', 1916, 4000000),
(107, 'The Two Fridas', 5, 'Surrealism', 1939, 3500000);


--Show total number of paintings per artist.

select artist_id , count(*) as paint_count from paintings group by artist_id

--Show the average price of paintings by each style.

select style , avg(price) from paintings group by style

--Count how many paintings were made per century 
--(e.g., 1400s, 1500s, etc.).

select ((year /100)* 100) as century , count(*)  from paintings group by ((year /100)* 100)

select * from paintings

--List the number of paintings by each country (use JOIN).

select a.country , count(*) as paintings_count from paintings p join artists a on p.artist_id = a.artist_id group by a.country

--Show the maximum painting price per artist.
select a.artist_id ,max(p.price) as paintings_count from paintings p join artists a on p.artist_id = a.artist_id group by a.artist_id

--Which styles have more than 1 painting?

select style from paintings group by style having count(*) > 1


--List artists who have more than 1 painting.

select artist_name from artists where artist_id in (
select artist_id from 
paintings 
group by artist_id having 
count(*) > 1 )

--Show the total value of paintings for each artist.

select a.artist_id , a.artist_name , sum(p.price) from paintings p join artists a 
on a.artist_id = p.artist_id group by a.artist_id , a.artist_name 

--Find which artist has the highest average painting price.
select TOP 1 a.artist_id , a.artist_name , avg(p.price) from paintings p join artists a 
on a.artist_id = p.artist_id group by a.artist_id , a.artist_name  order by avg(p.price)

--Group paintings by style and show average year of creation.
select style , avg(year) from paintings group by style

Drop table paintings

-- Create table: art_exhibitions
CREATE TABLE art_exhibitions (
    exhibition_id INT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100),
    start_date DATE,
    end_date DATE
);

-- Insert data into art_exhibitions
INSERT INTO art_exhibitions (exhibition_id, name, location, start_date, end_date) VALUES
(1, 'Modern Marvels', 'New York', '2022-01-01', '2022-03-30'),
(2, 'Renaissance Revival', 'Florence', '2022-04-01', '2022-07-01'),
(3, 'Abstract Horizons', 'Berlin', '2022-05-01', '2022-08-15'),
(4, 'Cultural Collage', 'Tokyo', '2022-06-01', '2022-10-01');

-- Create table: paintings
CREATE TABLE paintings (
    painting_id INT PRIMARY KEY,
    title VARCHAR(100),
    artist VARCHAR(100),
    style VARCHAR(50),
    price DECIMAL(10, 2),
    year INT,
    exhibition_id INT FOREIGN KEY REFERENCES art_exhibitions(exhibition_id)
);

-- Insert data into paintings
INSERT INTO paintings (painting_id, title, artist, style, price, year, exhibition_id) VALUES
(1, 'The Storm', 'A. Monroe', 'Abstract', 1200.00, 2020, 3),
(2, 'Color Pulse', 'B. Lee', 'Abstract', 1100.00, 2021, 3),
(3, 'Morning Glory', 'L. Dali', 'Realism', 800.00, 1995, 1),
(4, 'Royal Sunset', 'L. Dali', 'Realism', 950.00, 1998, 2),
(5, 'Silent Path', 'A. Monroe', 'Minimalism', 700.00, 2010, 4),
(6, 'Electric Soul', 'K. Nair', 'Expression', 1500.00, 2022, 3),
(7, 'Velvet Bloom', 'B. Lee', 'Abstract', 1250.00, 2021, 3),
(8, 'Clay Echo', 'R. Kapoor', 'Folk', 600.00, 2005, 4),
(9, 'Moonlight Waltz', 'L. Dali', 'Realism', 980.00, 2001, 2),
(10, 'Lightscape', 'K. Nair', 'Minimalism', 750.00, 2020, 4);



--1.Show the total number of paintings displayed at each exhibition location.

select location , count(*) from paintings p join art_exhibitions a on p.exhibition_id = a.exhibition_id group by location

--2.Find the average price of paintings exhibited each year (use exhibition start_date year).

select Year(start_date ) , avg(price) from art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id group by year(start_date)

--3.List the total value of paintings grouped by painting style and exhibition location.

select style , location  , sum(price) from paintings p join art_exhibitions a on 
p.exhibition_id = a.exhibition_id group by style,location


--4.Which exhibition had the highest total value of paintings?

select a.exhibition_id ,location ,Sum(price) as price  from paintings p join art_exhibitions a on 
p.exhibition_id = a.exhibition_id group by a.exhibition_id,location having  sum(price) = (
select max(price) from (
select a.exhibition_id ,location ,Sum(price) as price  from paintings p join art_exhibitions a on 
p.exhibition_id = a.exhibition_id group by a.exhibition_id,location) as xx)


--5.Show the number of unique artists featured in each exhibition.

select Distinct a.exhibition_id , p.artist  from art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id 

--6.Find the average year of paintings grouped by artist and exhibition.

select Distinct a.exhibition_id , p.artist  , avg(Year) from art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id  group by p.artist , a.exhibition_id

--7.List exhibitions where the total number of paintings is more than 2.

select Distinct a.exhibition_id ,location from art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id  group by a.exhibition_id, location having count(p.painting_id) > 2

--8.Show the minimum and maximum painting price per exhibition location.

select Distinct a.exhibition_id ,location , min(price) as minPrice , max(price) as maxPrice from
art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id  group by a.exhibition_id, location 

--9.For each painting style, count how many exhibitions it appeared in.

select Distinct style  , count(*) as exhibition_count from
art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id  group by a.exhibition_id, style 

--10.Show the total number of paintings per artist that exhibited in New York.
select artist ,count(*)as paintingCount from
art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id where location ='New York' group by artist 

--1.For each artist, style, and exhibition location, show the total number of paintings.
select artist, style,a.exhibition_id ,location ,count(painting_id)as paintingCount from
art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id  group by artist, style,a.exhibition_id ,location

--2.List each style and year combination with the average painting price,
--but only if the average price is above 1000.

select style,year ,avg(price) as paintingPrice from
art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id  group by style , year having avg(price) > 1000

--3.Show the artist and exhibition combination where the total value of paintings exceeds 2000.


select artist , a.exhibition_id , sum(price) as TotoalValue from
art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id  group by artist,a.exhibition_id  having sum(price) > 2000


--4.Display the count of paintings per artist per year, sorted by count descending.

select artist ,year ,count(p.painting_id) as TotoalValue from
art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id  group by artist,year



--5.Show, for each exhibition, how many distinct styles of paintings were displayed.

select a.exhibition_id ,count(style) from
art_exhibitions a join paintings p 
on a.exhibition_id = p.exhibition_id  group  by a.exhibition_id 


--6.For each location and style, calculate the average year of creation and total painting value.
select location , style , avg(year) , sum(price) from art_exhibitions a 
join paintings p on a.exhibition_id = P.exhibition_id group by location , style 

--7.For each artist, calculate the average price of paintings per exhibition,
--and show only those where the average is greater than 900.
select  a.exhibition_id , p.artist , AVG(price) from  art_exhibitions a 
join paintings p on a.exhibition_id = P.exhibition_id group by a.exhibition_id , p.artist
having avg(price) > 900


--8.For every year, find the style that had the highest total painting price in that year.
--(Hint: subquery will be needed here).
SELECT year, style
FROM (
    SELECT year, style, SUM(price) as total_price,
           RANK() OVER (PARTITION BY year ORDER BY SUM(price) DESC) as rnk
    FROM paintings
    GROUP BY year, style
) x
WHERE rnk = 1;


--9.List the artist, year, and average price, but only include combinations where more
--than one painting exists.

select artist , year , avg(price) from art_exhibitions a join paintings p on 
a.exhibition_id  =  P.exhibition_id GROUP BY artist , year HAVING COUNT(*) > 1


--10.For each exhibition location, show the total revenue and average price per painting,
--ordered by total revenue descending.

SELECT  location , sum(price) , avg(price) as avgPrice  from art_exhibitions a join paintings p on 
a.exhibition_id  =  P.exhibition_id group by location  order by avgPrice Desc