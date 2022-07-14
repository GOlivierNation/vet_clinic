/* Database schema to keep the structure of entire database. */

CREATE TABLE animals ( 
    id INT PRIMARY KEY NOT NULL, 
    name CHAR(25) NOT NULL, 
    date_of_birth DATE NOT NULL, 
    escape_attempts INT NOT NULL, 
    neutered BOOL NOT NULL, 
    weight_kg DECIMAL
    );

    ALTER TABLE animals ADD species CHAR(60);

    /* Create the table owners*/
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY(id)
);

/* Create species table */
CREATE TABLE IF NOT EXISTS species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(40),
    PRIMARY KEY(id)
);

/Begin transaction/
BEGIN;

/* Add column species_id to animals table */
ALTER TABLE animals ADD COLUMN species_id INT;

COMMIT;

/* Make the species_id column a foreign key referencing species table */
ALTER TABLE animals ADD FOREIGN KEY(species_id) REFERENCES species(id);

COMMIT;

/* Add a column called owber_id to animals table */
ALTER TABLE animals ADD COLUMN owner_id INT;

/* Make the owner_id a foreign key referencing the owners table */
ALTER TABLE animals ADD FOREIGN KEY(owner_id) REFERENCES owners(id);

COMMIT;

-- Removing species column
ALTER TABLE animals DROP COLUMN species_id;

-- Create a table named vets
CREATE TABLE vets (
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name varchar(100),
    age integer,
    date_of_graduation date
);

-- Create a table named specializations
CREATE TABLE specializations (
    vet_id integer NOT NULL,
    species_id integer NOT NULL,
    PRIMARY KEY (vet_id, species_id),
    CONSTRAINT fk_Vets  
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_Species  
    FOREIGN KEY(species_id) REFERENCES species(id)
);

-- Create a table named visits
CREATE TABLE visits (
    vet_id integer NOT NULL,
    animals_id integer NOT NULL,
    date_visited date,
    PRIMARY KEY (vet_id, animals_id, date_visited),
    CONSTRAINT fk_Vets  
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_animals  
    FOREIGN KEY(animals_id) REFERENCES animals(id)
); 