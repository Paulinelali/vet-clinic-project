/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT name FROM animals WHERE name ILIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN DATE '2016-01-01' AND '2019-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = 'true';

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE NOT name = 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN '10.4' AND '17.3';

-- DAY - 2

-- Inside a transaction update the animals table by setting the species column to unspecified.
BEGIN UPDATE animals SET species = 'unspecified';

-- Verify that change was made.
SELECT * FROM animals;

-- Then roll back the change and verify that the species columns went back to the state before the transaction
ROLLBACK;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN UPDATE animals SET species = 'digimon' WHERE name ILIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE NOT name ILIKE '%mon';

-- Verify that changes were made.
SELECT * FROM animals;

-- Commit the transaction.
COMMIT;

-- Verify that changes persist after commit.
  -- I opened a new shell to verify

-- delete all records in the animals table, then roll back the transaction
BEGIN TRUNCATE animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022.
BEGIN DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT sp1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO sp1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 1;

-- Commit transaction
COMMIT;

-- How many animals are there?
 SELECT COUNT(name) FROM animals;

--  How many animals have never tried to escape?
SELECT COUNT(name) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT neutered, MAX(weight_kg) FROM animals GROUP BY neutered;
SELECT neutered, MIN(weight_kg) FROM animals GROUP BY neutered;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT neutered, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN DATE '1990-01-01' AND '2000-01-01' GROUP BY neutered;


-- DAY 3

-- Write queries (using JOIN) to answer the following questions:
BEGIN;
-- What animals belong to Melody Pond?
SELECT name, full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM animals JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(animals.name) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, species.name, owners.full_name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name,owners.full_name FROM animals JOIN owners ON animals.owner_id=owners.id WHERE owners.full_name='Dean Winchester' AND animals.escape_attempts=0;

-- Who owns the most animals?
 SELECT owners.full_name, COUNT(animals.name) AS num_of_animals FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY num_of_animals DESC LIMIT 1;