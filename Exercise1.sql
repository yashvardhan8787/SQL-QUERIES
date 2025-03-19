Create Database Exercise1 

Use Exercise1

CREATE TABLE hotel
( hotel_no CHAR(4) NOT NULL,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL);

CREATE TABLE room
( room_no VARCHAR(4) NOT NULL,
hotel_no CHAR(4) NOT NULL,
type CHAR(1) NOT NULL,
price DECIMAL(5,2) NOT NULL);


CREATE TABLE booking
(hotel_no CHAR(4) NOT NULL,
guest_no CHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL,
room_no CHAR(4) NOT NULL);



CREATE TABLE guest
( guest_no CHAR(4) NOT NULL,
name VARCHAR(20) NOT NULL,
address VARCHAR(50) NOT NULL);


INSERT INTO hotel
VALUES ('H111', 'Grosvenor Hotel', 'London');


INSERT INTO room
VALUES ('1', 'H111', 'S', 72.00);

INSERT INTO guest
VALUES ('G111', 'John Smith', 'London');

INSERT INTO booking
VALUES ('H111', 'G111','1999-01-01',
'1999-01-02', '1');


INSERT INTO hotel
VALUES ('H112', 'Grosvenor Hotel', 'London');


INSERT INTO room
VALUES ('2', 'H112', 'S', 72.00);

INSERT INTO room
VALUES ('3', 'H112', 'l', 80.00);

INSERT INTO room
VALUES ('4', 'H112', 'S', 72.00);

INSERT INTO guest
VALUES ('G112', 'yash ', 'London');

INSERT INTO booking
VALUES ('H112', 'G112','2025-03-15',
'2025-03-20', '2');



UPDATE room SET price = price*1.05;

/*
• Create a separate table with the same
structure as the Booking table to hold
archive records.

• Using the INSERT statement, copy the
records from the Booking table to the
archive table relating to bookings before
1st January 2000. Delete all bookings
before 1st January 2000 from the Booking
table. */

CREATE TABLE archive_booking
(hotel_no CHAR(4) NOT NULL,
guest_no CHAR(4) NOT NULL,
date_from DATETIME NOT NULL,
date_to DATETIME NULL,
room_no CHAR(4) NOT NULL);

select * from booking 

INSERT INTO archive_booking
SELECT * FROM booking
WHERE date_to < '2000-01-01'

select * from archive_booking

Begin 
DELETE FROM booking
WHERE date_to < '2000-01-01';
end


--Queries

--List full details of all hotels.

select * from hotel

--2. List full details of all hotels in London.
select * from hotel where address ='London'


--3. List the names and addresses of all guests in
--London, alphabetically ordered by name.

select g.name as[guest name]
from booking b 
join guest g on b.guest_no = g.guest_no
Inner join hotel h  on h.hotel_no = b.hotel_no
where h.address='London' Order by g.name 


/*4. List all double or family rooms with a price
below £40.00 per night, in ascending order of
price.*/

select * from room where price < 40.00 order by price 


--5. List the bookings for which no date_to has
-- been specified.

select * from booking where date_to is  null 


/*1. How many hotels are there?*/
select count(*) as [Number of hotels] from hotel 
/*
2. What is the average price of a room?*/

select Avg(price) from room 



/*
3. What is the total revenue per night from
all double rooms? */

select SUM(price)as [Total Revenue] from  room where type='L'


/*
4. How many different guests have made
bookings for August?*/

select DISTINCT (g.name) as [guest] from guest g  
Inner join booking b on g.guest_no = b.guest_no
where MONTH(date_from) = 1

/*
1. List the price and type of all rooms at the Grosvenor
Hotel. */
select r.type [room type] , r.price as [room price ] from room r inner join hotel h on r.hotel_no = h.hotel_no 
where h.name ='Grosvenor Hotel'


/*
2. List all guests currently staying at the Grosvenor Hotel.*/

select g.name as [guest] from 
hotel h inner join booking b 
on h.hotel_no = b.hotel_no 
Inner Join guest g on b.guest_no = g.guest_no
where h.name ='Grosvenor Hotel' and  GETDATE() between date_from and date_to

/*
3. List the details of all rooms at the Grosvenor Hotel,
including the name of the guest staying in the room, if
the room is occupied.*/

select * from room r 
join  hotel h on r.hotel_no = h.hotel_no 
left join booking b on r.room_no = b.room_no 
left join guest g on b.guest_no = g.guest_no 
where h.name ='Grosvenor Hotel'

/*
4. What is the total income from bookings for the
Grosvenor Hotel today?*/
select SUM(r.price) as[total income for today] from 
booking b join hotel h on b.hotel_no = h.hotel_no  join room r on r.room_no = b.room_no
where h.name ='Grosvenor Hotel' and  GETDATE() between b.date_from and b.date_to
/*
5. List the rooms that are currently unoccupied at the
Grosvenor Hotel.*/
select r.room_no , r.hotel_no,r.price ,r.type from 
room  r join hotel h on h.hotel_no =r.hotel_no
left join
booking b on b.room_no = r.room_no where h.name ='Grosvenor Hotel' and  b.hotel_no is null 

/*
6. What is the lost income from unoccupied rooms at the
Grosvenor Hotel? */
select Sum(r.price) as [Lost Income] from 
room  r join hotel h on h.hotel_no =r.hotel_no
left join
booking b on b.room_no = r.room_no where h.name ='Grosvenor Hotel' and  b.hotel_no is null 



/*
1. List the number of rooms in each hotel. */
select h.name , count(*)  from room r join hotel h on r.hotel_no = h.hotel_no group by (h.name)

/*
2. List the number of rooms in each hotel in
London. */

select h.name , count(*)  from room r join hotel h on r.hotel_no = h.hotel_no where h.address='London' group by (h.name)

/*
3. What is the average number of bookings
for each hotel in August? */

select hotel_no,YEAR(date_from)as[year] ,count(*) as[count of bookings] from booking  group by hotel_no,YEAR(date_from)

select AVG( bookings) from (select hotel_no as [hotel],YEAR(date_from)as[year] ,count(*) as[bookings] from booking  group by hotel_no ,YEAR(date_from)) as [yearly booking] group by hotel

SELECT hotel, AVG(bookings) AS avg_bookings
FROM (
    SELECT 
        hotel_no AS hotel, 
        YEAR(date_from) AS [year], 
        COUNT(*) AS bookings
    FROM booking  
    GROUP BY hotel_no, YEAR(date_from)
) AS yearly_bookings
GROUP BY hotel;
/*
4. What is the most commonly booked
room type for each hotel in London?
*/
SELECT type, COUNT(type) AS tcount
FROM booking b
JOIN room r ON r.room_no = b.room_no
GROUP BY type
HAVING COUNT(type) = (
    SELECT MAX(tcount)
    FROM (
        SELECT COUNT(type) AS tcount
        FROM booking b
        JOIN room r ON r.room_no = b.room_no
        GROUP BY type
    ) AS counts
);

/*
5. What is the lost income from unoccupied
rooms at each hotel today?*/

select r.hotel_no , SUM(price) from room r left join booking  b on r.room_no = b.room_no group by r.hotel_no
