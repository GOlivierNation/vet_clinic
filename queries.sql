/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = 'yes' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' || 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'yes';
SELECT * FROM animals WHERE name != 'Gabumon'; 
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <=17.3;
-- How many animals are there
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT a.name, v.name, date_visited FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id 
WHERE v.name LIKE 'William Tatcher'
ORDER BY vis.date_visited DESC
LIMIT (1);

-- How many different animals did Stephanie Mendez see?
SELECT DISTINCT COUNT(*) FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id 
WHERE v.name LIKE 'Stephanie Mendez'
GROUP BY v.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, sp.name FROM vets v 
LEFT JOIN specializations s 
  ON v.id = s.vet_id
LEFT JOIN species sp 
  ON sp.id = s.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name, vis.date_visited, v.name FROM animals a 
JOIN visits vis 
  ON a.id = vis.animals_id
JOIN vets v 
  ON v.id = vis.vet_id
WHERE vis.date_visited IN ('2020-04-01', '2020-08-30') 
    AND v.name LIKE 'Stephanie Mendez';

-- What animal has the most visits to vets?
SELECT a.name, COUNT(*) AS number_of_visits FROM visits vis 
JOIN animals a 
  ON vis.animals_id = a.id 
GROUP BY a.name
ORDER BY number_of_visits DESC
LIMIT (1);

-- Who was Maisy Smith's first visit?
SELECT a.name, v.name, vis.date_visited FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id 
WHERE v.name LIKE 'Maisy Smith'
ORDER BY vis.date_visited
LIMIT (1);

-- Details for most recent visit: 
-- animal information, vet information, and date of visit.
SELECT a.name, v.name, vis.date_visited FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id 
ORDER BY vis.date_visited DESC
LIMIT (1);

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS number_of_visits_with_not_specialty_vet FROM visits vis 
JOIN vets v 
  ON vis.vet_id = v.id 
JOIN animals a 
  ON vis.animals_id = a.id
LEFT JOIN specializations sp
  ON v.id = sp.vet_id
LEFT JOIN species spe 
  ON spe.id = sp.species_id
WHERE sp.species_id != a.species_id OR spe.name IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT spe.name, COUNT(*) AS most_visited_by_species FROM visits vis 
JOIN animals a 
  ON vis.animals_id = a.id
JOIN species spe 
  ON spe.id = a.species_id
JOIN vets v 
  ON vis.vet_id = v.id 
LEFT JOIN specializations sp
  ON v.id = sp.vet_id
WHERE sp.vet_id IS NULL AND v.name LIKE 'Maisy Smith'
GROUP BY spe.name
ORDER BY most_visited_by_species DESC
LIMIT (1); 