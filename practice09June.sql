create database practice09June

Use practice09June

CREATE TABLE explorers (
    explorer_id INT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO explorers VALUES
(1, 'Lara Croft', 'UK'),
(2, 'Indiana Jones', 'USA'),
(3, 'Dora', 'Spain'),
(4, 'Rick O’Connell', 'USA');

-- Table 2: expeditions
CREATE TABLE expeditions (
    expedition_id INT PRIMARY KEY,
    explorer_id INT,
    location VARCHAR(100),
    year INT,
    artifact_found VARCHAR(100),
    FOREIGN KEY (explorer_id) REFERENCES explorers(explorer_id)
);

INSERT INTO expeditions VALUES
(101, 1, 'Peru', 2020, 'Ancient Skull'),
(102, 1, 'Egypt', 2021, 'Pharaoh Mask'),
(103, 2, 'India', 2022, 'Crystal Skull'),
(104, 4, 'China', 2020, NULL),
(105, 4, 'Mexico', 2023, 'Golden Idol');


-- List all expeditions with explorer names.

select * from expeditions e join explorers ex on e.explorer_id  = ex.explorer_id 

--Show each explorer and the number of expeditions they've been on.

select e.explorer_id  , e.name , count(*) as [No. of expeditions]  from explorers e 
left join expeditions ex on e.explorer_id  = ex.explorer_id 
group by e.explorer_id  , e.name 

--Find explorers who haven’t gone on any expeditions.
select Distinct e.explorer_id  , e.name  from explorers e 
left join expeditions ex on e.explorer_id  = ex.explorer_id 
where ex.explorer_id is null 


--List all expeditions, including those where explorer info is missing.
select * from expeditions ex left join 
explorers ep  on ex.explorer_id = ep.explorer_id 

--Show explorer names along with expedition years and artifacts found.
select name , year , artifact_found from expeditions ex  join 
explorers ep  on ex.explorer_id = ep.explorer_id 

--Which countries have more than 1 explorer who’s gone on expeditions?
select country , count(exploreres) [explorers] from (
select Distinct country ,ex.explorer_id as exploreres from expeditions ex  join 
explorers ep  on ex.explorer_id = ep.explorer_id ) as p group by country 

--List all artifacts found along with the name of the explorer who found them.
select ep.name , artifact_found from expeditions ex  join 
explorers ep  on ex.explorer_id = ep.explorer_id 


--Show all explorers and the number of unique locations they’ve visited.

select exp_name , count(*) as Locations from(
select Distinct ep.name as exp_name , ex.location as exp_loactions  from expeditions ex  join 
explorers ep  on ex.explorer_id = ep.explorer_id  ) as p group by exp_name 

--List locations where no artifact was found but an expedition took place.
select location  from expeditions where artifact_found is null

--Display all combinations of explorers and expedition locations (CROSS JOIN).*/

select * from expeditions cross join 
explorers 

-------------------------------------------------------------------------------------



 CREATE TABLE explorers (
    explorer_id INT PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO explorers (explorer_id, name, country) VALUES
(1, 'Lara Croft', 'UK'),
(2, 'Indiana Jones', 'USA'),
(3, 'Dora', 'Mexico'),
(4, 'Rick O’Connell', 'Egypt');

CREATE TABLE expeditions (
    expedition_id INT PRIMARY KEY,
    explorer_id INT,
    year INT,
    location VARCHAR(50),
    artifact_found VARCHAR(100)
);

INSERT INTO expeditions (expedition_id, explorer_id, year, location, artifact_found) VALUES
(106, 1, 2020, 'Peru', 'Gold Mask'),
(107, 1, 2021, 'Nepal', 'Crystal Skull'),
(108, 2, 2019, 'India', NULL),
(109, NULL, 2022, 'Antarctica', 'Ice Scroll'),
(110, 4, 2020, 'Egypt', 'Amulet');



/*Show each explorer’s name along with all expeditions they went on, including those with no expeditions.*/


select ex.name , expedition_id  from explorers ex left join expeditions ep on ex.explorer_id = ep.explorer_id 


--List all expeditions and their locations along with explorer names (if known).

select  expedition_id , ex.name , ep.location  from explorers ex  join expeditions ep on ex.explorer_id = ep.explorer_id 

--Find all explorers who found at least 1 artifact. Show their names and artifacts.

select Distinct  ex.name  from explorers ex  join expeditions ep on ex.explorer_id = ep.explorer_id where artifact_found is not null


--Show each explorer and the total number of unique locations they have visited.

select Distinct  ex.name ,count( location ) from explorers ex left join expeditions ep on ex.explorer_id = ep.explorer_id group by ex.name

--List explorers and expeditions where the artifact name contains the word 'Gold'.

select   ex.name , ep.expedition_id from explorers ex  join expeditions ep on ex.explorer_id = ep.explorer_id where artifact_found like '%GOLD%'


--Display the explorer name, expedition year, and artifact, but include expeditions with missing explorer data.

select   ex.name , ep.year ,artifact_found  from explorers ex Right join expeditions ep on ex.explorer_id = ep.explorer_id

--Find explorers who participated in more than one expedition in the same year.

select Distinct   ex.name  from explorers ex  join expeditions ep on ex.explorer_id = ep.explorer_id
group by ex.name , year Having count(*) > 1 

--List all combinations of explorers and expeditions (cross join) but only show pairs where the explorer is from a different country than the expedition’s location country. (Assume location = country for this logic).
select * from expeditions ep cross join explorers ex where not ep.location = ex.country 

--Which explorers never found any artifact in any expedition?
select name from explorers where name not in (
select Distinct name from explorers ex left join expeditions ep on ex.explorer_id = ep.explorer_id 
where artifact_found is not null)

--Create a self-join to list pairs of explorers from the same country.*/
select * from explorers e1 cross join  explorers e2  where e1.country = e2.country and not e1.explorer_id  = e2.explorer_id