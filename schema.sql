CREATE DATABASE vet_clinic;
CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY,name VARCHAR,date_of_birth DATE,escape_attempts INT,neutered BOOLEAN,weight_kg DECIMAL(4,2),PRIMARY KEY(id));
ALTER TABLE animals ADD species VARCHAR;

CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY,full_name VARCHAR,age INT,PRIMARY KEY(id));
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY,name VARCHAR,PRIMARY KEY(id));
ALTER TABLE animals  DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

CREATE TABLE vets(id INT GENERATED ALWAYS AS IDENTITY,name VARCHAR,age INT, date_of_graduation DATE,PRIMARY KEY(id));
CREATE TABLE specializations (vet_id INT REFERENCES vets(id), species_id INT REFERENCES species(id), PRIMARY KEY (vet_id, species_id));
CREATE TABLE visits (animal_id INT REFERENCES animals(id), date_of_the_visit DATE , vet_id INT REFERENCES vets(id));