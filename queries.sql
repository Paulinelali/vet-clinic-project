SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth)BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name IN('Agumon','Pikachu');
SELECT name,escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=TRUE;
SELECT * FROM animals WHERE name NOT IN('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
BEGIN;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
     
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg<0;
 SELECT * FROM animals;
 SELECT COUNT(*) FROM animals;
 SELECT COUNT(*) FROM animals WHERE escape_attempts=0;
 SELECT AVG(weight_kg) FROM animals;
 SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;
 SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
 SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;

 SELECT animals.name,owners.full_name FROM animals INNER JOIN owners ON animals.owner_id=owners.id WHERE owners.full_name='Melody Pond';
 SELECT animals.name,species.name FROM animals JOIN species ON animals.species_id=species.id WHERE species.name='Pokemon';
 SELECT owners.full_name,animals.name FROM animals RIGHT JOIN owners ON animals.owner_id=owners.id;
 SELECT species.name,COUNT(animals.name) FROM animals JOIN species ON animals.species_id=species.id GROUP BY species.name;
 SELECT animals.name, species.name, owners.full_name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
 SELECT animals.name,owners.full_name FROM animals JOIN owners ON animals.owner_id=owners.id WHERE owners.full_name='Dean Winchester' AND animals.escape_attempts=0;
 SELECT owners.full_name, COUNT(animals.name) AS num_of_animals FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY num_of_animals DESC LIMIT 1;

 SELECT animals.name FROM visits JOIN animals ON visits.animal_id=animals.id 
 JOIN vets ON visits.vet_id=vets.id WHERE vets.name='William Tatcher' ORDER BY (visits.date_of_the_visit) DESC LIMIT 1;

 SELECT COUNT(*) FROM animals A
JOIN visits V ON A.id = V.animal_id
WHERE V.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

SELECT v.name, species.name FROM specializations s
LEFT JOIN vets v ON s.vet_id=v.id
JOIN species ON s.species_id=species.id;

SELECT a.name, v.date_of_the_visit FROM animals a
JOIN  visits v ON a.id=v.animal_id
JOIN vets ON v.vet_id=vets.id WHERE vets.name='Stephanie Mendez'
AND v.date_of_the_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(v.date_of_the_visit)
FROM animals a
JOIN visits v ON a.id=v.animal_id
GROUP BY a.name 
ORDER BY COUNT(v.date_of_the_visit) DESC LIMIT 1;

SELECT a.name, MIN(v.date_of_the_visit) FROM animals a
JOIN  visits v ON a.id=v.animal_id
JOIN vets ON v.vet_id=vets.id WHERE vets.name='Maisy Smith'
GROUP BY a.name
ORDER BY MIN(v.date_of_the_visit) ASC LIMIT 1;

SELECT A.name AS animal_name, A.date_of_birth, A.escape_attempts, A.weight_kg, VT.name AS vet_name, VT.age AS vet_age, MAX(V.date_of_the_visit) AS most_recent_visIt_date 
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VT ON VT.id = V.vet_id 
GROUP BY VT.name, A.name, A.date_of_birth, A.escape_attempts, A.weight_kg, VT.age  ORDER BY MAX(V.date_of_the_visit) DESC LIMIT 1;

SELECT COUNT(*) FROM visits V
WHERE V.vet_id = ( SELECT id FROM vets VT JOIN specializations S ON VT.id != S.vet_id LIMIT 1);

SELECT species.name, COUNT(*) AS num_visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
JOIN species ON a.species_id = species.id
WHERE vt.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY num_visits DESC
LIMIT 1;