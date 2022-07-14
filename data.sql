/* Populate database with sample data. */

INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES (1, 'Agumon', '2020-02-03', 0, 'yes', 10.23 );
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, 'yes', 8.0 );
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES (3, 'Pikachu', '2021-01-07', 1, 'no', 15.04 );
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES (4, 'Devimon', '2017-05-12', 5, 'yes', 11.0 );

INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg,species) VALUES (5, 'Charmander', '2020-02-08', 0, 'no', 11.0, '' );
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg,species) VALUES (6, 'Plantmon', '2021-11-15', 2, 'yes', 5.7, '' );
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg,species) VALUES (7, 'Squirtle', '1993-04-02', 3, 'no', 12.13, '' );
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg,species) VALUES (8, 'Angemon', '2005-06-12', 1, 'yes', 45.0, '' );
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg,species) VALUES (9, 'Boarmon', '2005-06-07', 7, 'yes', 20.4, '' );
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg,species) VALUES (10, 'Blossom', '1998-10-13', 3, 'yes', 17.0, '' );
INSERT INTO animals (id,name,date_of_birth,escape_attempts,neutered,weight_kg,species) VALUES (11, 'Ditto', '2022-05-14', 4, 'yes', 22.0, '' );

/* Insert data into the owners table */
INSERT INTO owners(full_name, age) VALUES('Sam Smith', 34);
INSERT INTO owners(full_name, age) VALUES('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) VALUES('Bob', 45);
INSERT INTO owners(full_name, age) VALUES('Melody Pond', 77);
INSERT INTO owners(full_name, age) VALUES('Dean Winchester', 14);
INSERT INTO owners(full_name, age) VALUES('Jodie Whittaker', 38);

/* Insert data into the species table */
INSERT INTO species(name) Values('Pokemon');
INSERT INTO species(name) Values('Digimon');

/* Begin transaction */
BEGIN;

/* If the name ends in "mon" it will be Digimon */
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

/* All other animals are Pokemon */
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

COMMIT;

/* Begin transaction */
BEGIN;

/* Modify your inserted animals to include owner information (owner_id)*/
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'sam smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name'Pikachu';
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' OR NAME = 'Plantmon';
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id =(SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';

COMMIT;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species = NULL;
DELETE FROM animals;
ROLLBACK BeforeDelete;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species = NULL;
DELETE FROM animals;
ROLLBACK BeforeDelete;

BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP2;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = (weight_kg * (-1));
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = (weight_kg * (-1)) WHERE weight_kg LIKE '%-';

ROLLBACK TO SP2;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

INSERT INTO vets(name, age, date_of_graduation)
VALUES 
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

    INSERT INTO specializations(vet_id, species_id)
VALUES 
    (1, 1),
    (3, 2),
    (3, 1),
    (4, 2);

    INSERT INTO visits(vet_id, animals_id, date_visited) VALUES 
(1, 8, '2020-05-24'),
(3, 8, '2020-07-22'),
(4, 9, '2021-02-02'),
(2, 10, '2020-01-05'),
(2, 10, '2020-03-08'),
(2, 10, '2020-05-14'),
(3, 11, '2021-05-04'),
(4, 1, '2021-02-24'),
(2, 2, '2019-12-21'),
(1, 2, '2020-08-10'),
(2, 2, '2021-04-07'),
(3, 3, '2019-09-29'),
(4, 4, '2020-10-03'),
(4, 4, '2020-11-04'),
(2, 5, '2019-01-24'),
(2, 5, '2019-05-15'),
(2, 5, '2020-02-27'),
(2, 5, '2020-08-03'),
(3, 6, '2020-05-24'),
(1, 6, '2021-01-11');