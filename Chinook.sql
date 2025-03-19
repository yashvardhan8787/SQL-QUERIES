-- Creating Chinook Database Schema
CREATE DATABASE Chinook;

USE Chinook;

CREATE TABLE Artist (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Album (
    AlbumID INT PRIMARY KEY,
    Title VARCHAR(255),
    ArtistID INT,
    FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID)
);

CREATE TABLE Track (
    TrackID INT PRIMARY KEY,
    Name VARCHAR(255),
    AlbumID INT,
    MediaTypeID INT,
    GenreID INT,
    Composer VARCHAR(255),
    Milliseconds INT,
    Bytes INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)
);

CREATE TABLE MediaType (
    MediaTypeID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Genre (
    GenreID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Playlist (
    PlaylistID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE PlaylistTrack (
    PlaylistID INT,
    TrackID INT,
    PRIMARY KEY (PlaylistID, TrackID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID),
    FOREIGN KEY (TrackID) REFERENCES Track(TrackID)
);

CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY,
    CustomerID INT,
    InvoiceDate DATE,
    BillingAddress TEXT,
    BillingCity VARCHAR(255),
    BillingState VARCHAR(255),
    BillingCountry VARCHAR(255),
    BillingPostalCode VARCHAR(50),
    Total DECIMAL(10,2)
);

CREATE TABLE InvoiceLine (
    InvoiceLineID INT PRIMARY KEY,
    InvoiceID INT,
    TrackID INT,
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID),
    FOREIGN KEY (TrackID) REFERENCES Track(TrackID)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Company VARCHAR(255),
    Address TEXT,
    City VARCHAR(255),
    State VARCHAR(255),
    Country VARCHAR(255),
    PostalCode VARCHAR(50),
    Phone VARCHAR(50),
    Email VARCHAR(255),
    SupportRepID INT
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Title VARCHAR(255),
    ReportsTo INT,
    BirthDate DATE,
    HireDate DATE,
    Address TEXT,
    City VARCHAR(255),
    State VARCHAR(255),
    Country VARCHAR(255),
    PostalCode VARCHAR(50),
    Phone VARCHAR(50),
    Fax VARCHAR(50),
    Email VARCHAR(255),
    FOREIGN KEY (ReportsTo) REFERENCES Employee(EmployeeID)
);


select Name from Sys.tables

-- Use the appropriate database
USE Chinook;

-- Insert Artists
INSERT INTO Artist (ArtistID, Name) VALUES
(1, 'The Beatles'),
(2, 'Queen'),
(3, 'Pink Floyd'),
(4, 'Led Zeppelin'),
(5, 'Nirvana');

INSERT INTO Artist (ArtistID, Name) VALUES
(6,'Mc Stan');

-- Insert Albums
INSERT INTO Album (AlbumID, Title, ArtistID) VALUES
(1, 'Abbey Road', 1),
(2, 'A Night at the Opera', 2),
(3, 'The Dark Side of the Moon', 3),
(4, 'IV', 4),
(5, 'Nevermind', 5);

-- Insert MediaTypes
INSERT INTO MediaType (MediaTypeID, Name) VALUES
(1, 'MP3'),
(2, 'WAV'),
(3, 'FLAC');

-- Insert Genres
INSERT INTO Genre (GenreID, Name) VALUES
(1, 'Rock'),
(2, 'Pop'),
(3, 'Grunge');

-- Insert Tracks
INSERT INTO Track (TrackID, Name, AlbumID, MediaTypeID, GenreID, Composer, Milliseconds, Bytes, UnitPrice) VALUES
(1, 'Come Together', 1, 1, 1, 'Lennon/McCartney', 259000, 4000000, 1.99),
(2, 'Bohemian Rhapsody', 2, 1, 1, 'Freddie Mercury', 355000, 5000000, 2.99),
(3, 'Money', 3, 2, 1, 'Roger Waters', 364000, 6000000, 2.49),
(4, 'Stairway to Heaven', 4, 2, 1, 'Jimmy Page/Robert Plant', 482000, 7000000, 3.99),
(5, 'Smells Like Teen Spirit', 5, 1, 3, 'Kurt Cobain', 301000, 5000000, 2.49);

-- Insert Playlists
INSERT INTO Playlist (PlaylistID, Name) VALUES
(1, 'Classic Rock'),
(2, 'Greatest Hits'),
(3, 'Grunge Essentials');

-- Insert PlaylistTrack relationships
INSERT INTO PlaylistTrack (PlaylistID, TrackID) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5);

-- Insert Employees
INSERT INTO Employee (EmployeeID, FirstName, LastName, Title, ReportsTo, BirthDate, HireDate, Address, City, State, Country, PostalCode, Phone, Fax, Email) VALUES
(1, 'John', 'Doe', 'Manager', NULL, '1980-05-15', '2010-06-01', '789 Elm St', 'New York', 'NY', 'USA', '10001', '555-1111', '555-2222', 'johndoe@example.com'),
(2, 'Jane', 'Smith', 'Sales Representative', 1, '1990-07-22', '2015-09-15', '456 Maple St', 'Los Angeles', 'CA', 'USA', '90001', '555-3333', '555-4444', 'janesmith@example.com');

-- Insert Customers
INSERT INTO Customer (CustomerID, FirstName, LastName, Company, Address, City, State, Country, PostalCode, Phone, Email, SupportRepID) VALUES
(1, 'Michael', 'Johnson', 'Acme Corp', '123 Oak St', 'Chicago', 'IL', 'USA', '60601', '555-5555', 'michael@example.com', 2),
(2, 'Sarah', 'Brown', 'Tech Solutions', '789 Birch St', 'San Francisco', 'CA', 'USA', '94101', '555-6666', 'sarah@example.com', 2);

-- Insert Invoices
INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode, Total) VALUES
(1, 1, '2024-03-05', '123 Oak St', 'Chicago', 'IL', 'USA', '60601', 9.97),
(2, 2, '2024-03-10', '789 Birch St', 'San Francisco', 'CA', 'USA', '94101', 15.98);

-- Insert InvoiceLines
INSERT INTO InvoiceLine (InvoiceLineID, InvoiceID, TrackID, UnitPrice, Quantity) VALUES
(1, 1, 1, 1.99, 2),
(2, 1, 2, 2.99, 1),
(3, 2, 3, 2.49, 4),
(4, 2, 4, 3.99, 1);

--Queries 

-- 1. which artists did not make  any albums at all,Include names in your answer 
select Name from Artist
Where ArtistID not in (
select  ArtistID from Album
)

--2.Which Artist did not record any tracks of the latin genre?
select * from Artist where
ArtistID not in (
select Artist.ArtistID from Track 
Join Album 
on Album.AlbumID = Track.AlbumID 
Join Artist on Artist.ArtistID = Album.ArtistID
join Genre on Genre.GenreID = Track.GenreID
Where Genre.Name = 'Rock' 
)


--3.Which Video track has Longest length ?
select * from Track 
Where
Milliseconds = (select Max(Milliseconds) from Track ) 

--14- Find the names of customers who live in the same city as the top employee (The one not managed
--by anyone).

SELECT * FROM Customer 
WHERE City = (
    SELECT City FROM Employee WHERE ReportsTo IS NULL
);



select * from Employee
select * from Customer

--15- Find the managers of employees supporting American customers.

select Distinct  (M.FirstName +' '+ M.LastName)   as Manager from Employee E 
Join Employee M on E.ReportsTo = M.EmployeeID
Join Customer c on E.EmployeeID = c.SupportRepID
Where c.Country = 'USA'

/*16- How many audio tracks in total were bought by German customers? And what was the total price
paid for them?*/

select count(*) as [Number of audio tracks],SUM(UnitPrice * Quantity) as [Total Price] from Customer c
join Invoice i on c.CustomerID = i.CustomerID
join InvoiceLine  il on il.InvoiceID = i.InvoiceID
Where c.Country='Germany'

/* 17- Which playlists have no Latin tracks?*/

SELECT Name FROM Playlist 
WHERE PlaylistID NOT IN (
    SELECT DISTINCT P.PlaylistID 
    FROM Playlist P
    JOIN PlaylistTrack PT ON P.PlaylistID = PT.PlaylistID
    JOIN Track T ON PT.TrackID = T.TrackID
    JOIN Genre G ON G.GenreID = T.GenreID 
    WHERE G.Name = 'Latin'
);


/*
18- What is the space, in bytes, occupied by the playlist “Grunge”,
and how much would it cost?
(Assume that the cost of a
playlist is the sum of the price of its constituent tracks). */

select SUM(t.Bytes) as[total Bytes], SUM(t.UnitPrice) as  [Total Price] from Playlist p
Join PlaylistTrack pt on P.PlaylistID = pt.PlaylistID
join Track t on pt.TrackID = t.TrackID
Where p.Name = 'Greatest Hits'


/*
19- Which playlists do not contain 
any tracks for the artists “Queen” nor “Led Zeppelin” ?*/
SELECT PlaylistID, Name FROM Playlist 
WHERE PlaylistID NOT IN (
    SELECT DISTINCT P.PlaylistID 
    FROM Playlist P
    JOIN PlaylistTrack PT ON P.PlaylistID = PT.PlaylistID
    JOIN Track T ON PT.TrackID = T.TrackID
    JOIN Album A ON A.AlbumID = T.AlbumID
    JOIN Artist AR ON AR.ArtistID = A.ArtistID
    WHERE AR.Name = 'Queen' OR AR.Name = 'Led Zeppelin'
);


/*
  20- List the names and the countries of those customers 
  who are supported by an employee who was
  younger than 35 when hired. HINT:
  use year as the first parameter in DATEDIFF().*/  

  select (c.FirstName +' '+c.LastName)as [Name] ,c.Country as [Country] from Customer c
  join Employee e on c.SupportRepID = e.EmployeeID
  Where DateDiff(Year,e.BirthDate,getDate()) - DateDiff(Year,e.HireDate,getDate()) < 35 
