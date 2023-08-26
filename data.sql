/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (  'Agumon', DATE '2020-02-03', '0', 'true', '10.23'    );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', DATE '2018-11-15', '2', 'true', '8.00');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', DATE '2021-01-07', '1', 'false', '15.04');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', DATE '2017-05-12', '5', 'true', '11.00');

-- day - 2

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', DATE '2020-02-08', '0', 'false', '-11.00');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Plantmon', DATE '2021-11-15', '2', 'true', '-5.70');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Squirtle', DATE '1993-04-02', '3', 'false', '-12.13');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Angemon', DATE '2005-06-12', '1', 'true', '-45');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Boarmon', DATE '2005-06-07', '7', 'true', '20.4');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Blossom', DATE '1998-10-13', '3', 'true', '17');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ( 'Ditto', DATE '2022-06-14', '4', 'true', '22');


-- Insert the following data into the owners table
INSERT INTO owners ( full_name, age) VALUES ('Sam Smith', '34');
INSERT INTO owners ( full_name, age) VALUES ('Jennifer Orwell', '19');
INSERT INTO owners ( full_name, age) VALUES ('Bob', '45');
INSERT INTO owners ( full_name, age) VALUES ('Melody Pond', '77');
INSERT INTO owners ( full_name, age) VALUES ('Dean Winchester', '14');
INSERT INTO owners ( full_name, age) VALUES ('Jodie Whittaker', '38');

-- Insert the following data into the species table
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- ################################################################

-- modify INSERTED animals to include the species_id value:
  -- If the name ends in "mon" it will be Digimon
BEGIN;
UPDATE animals SET species_id = 2 WHERE name ILIKE '%mon';

-- All other animals are Pokemon
UPDATE animals SET species_id = 1 WHERE NOT name ILIKE '%mon';
COMMIT TRANSACTION;

-- Modify your inserted animals to include owner information (owner_id)
BEGIN;
-- Sam Smith owns Agumon.
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Pikachu';

-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon';
UPDATE animals SET owner_id = 3 WHERE name = 'Plantmon';

-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander';
UPDATE animals SET owner_id = 4 WHERE name = 'Squirtle';
UPDATE animals SET owner_id = 4 WHERE name = 'Blossom';

-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon';
UPDATE animals SET owner_id = 5 WHERE name = 'Boarmon';
COMMIT TRANSACTION;