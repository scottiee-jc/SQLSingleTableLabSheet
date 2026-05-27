
CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20), species VARCHAR(20), sex CHAR(1), checkups SMALLINT UNSIGNED, birth DATE, death DATE);

INSERT INTO pet (name,owner,species,sex,checkups,birth,death)VALUES ('Fluffy','Harold','cat','f',5,'2001-02-04',NULL),
('Claws','Gwen','cat','m',2,'2000-03-17',NULL),
('Buffy','Harold','dog','f',7,'1999-05-13',NULL),
('Fang','Benny','dog','m',4,'2000-08-27',NULL),
('Bowser','Diane','dog','m',8,'1998-08-31','2001-07-29'),
('Chirpy','Gwen','bird','f',0,'2002-09-11',NULL),
('Whistler','Gwen','bird','',1,'2001-12-09',NULL),
('Slim','Benny','snake','m',5,'2001-04-29',NULL);

SELECT * FROM pet

SELECT * FROM pet WHERE sex = 'm';

SELECT name, species, sex FROM pet WHERE species = 'snake' OR species = 'bird';

SELECT name, owner FROM pet WHERE sex = 'f';

SELECT name, birth FROM pet WHERE species = 'dog';

SELECT owner FROM pet WHERE species = 'bird';

SELECT species FROM pet WHERE sex = 'f';

SELECT name, birth FROM pet WHERE species = 'cat' OR species = 'bird';

SELECT name, species FROM pet WHERE species = 'cat' OR species = 'bird' AND sex = 'f';

SELECT owner, name FROM pet WHERE name LIKE '%er' OR name LIKE '%all';

SELECT name FROM pet WHERE owner LIKE '%e';

SELECT name FROM pet WHERE length(owner) = 4;  

SELECT owner FROM pet WHERE SUBSTR(UPPER(owner), 1, 1) BETWEEN 'A' AND 'E' AND SUBSTR(UPPER(owner), LENGTH(owner), 1) BETWEEN 'A' AND 'E';

SELECT owner FROM pet WHERE SUBSTR(owner, 1, 1) BETWEEN 'A' AND 'E' AND SUBSTR(owner, LENGTH(owner), 1) BETWEEN 'A' AND 'E';

 -- Q3-1
SELECT AVG(total_checkups) AS avg_checkups_per_owner
FROM (
    SELECT owner, SUM(checkups) AS total_checkups
    FROM pet
    GROUP BY owner
);

 -- Q3-2
SELECT species, COUNT(*) AS species_count
FROM pet 
GROUP BY species
ORDER BY species_count ASC;

 -- Q3-3
SELECT owner,
       species,
       COUNT(*) AS pet_count
FROM pet
GROUP BY owner, species
ORDER BY owner ASC, species ASC;

 -- Q3-4
SELECT owner, COUNT(DISTINCT species) AS species_count
FROM pet
GROUP BY owner;

-- Q5
SELECT sex, COUNT(*) AS pet_by_gender
FROM pet
WHERE sex IN ('m', 'f')
GROUP BY sex
ORDER BY sex ASC;


 -- Q3-6
SELECT o.owner,
       COALESCE(b.bird_count, 0) AS bird_count
FROM (SELECT DISTINCT owner FROM pet) AS o
LEFT JOIN (
    SELECT owner, COUNT(*) AS bird_count
    FROM pet
    WHERE species = 'bird'
    GROUP BY owner
) AS b
ON o.owner = b.owner
ORDER BY o.owner;

-- Q3-7
SELECT owner, SUM(checkups) AS checkups_per_owner FROM pet GROUP BY owner;