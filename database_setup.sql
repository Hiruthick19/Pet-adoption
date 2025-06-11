-- SQL statements for creating Adopters and Pets tables and inserting sample data

-- Drop tables if they exist (optional, for easy re-running)
DROP TABLE IF EXISTS Pets;
DROP TABLE IF EXISTS Adopters;

-- Create Adopters Table
CREATE TABLE Adopters (
    adopter_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address TEXT,
    lifestyle VARCHAR(50) CHECK (lifestyle IN ('active', 'moderate', 'sedentary')),
    household_size INTEGER DEFAULT 1,
    children BOOLEAN DEFAULT FALSE,
    other_pets BOOLEAN DEFAULT FALSE,
    pet_preference_species VARCHAR(50), -- e.g., 'Dog', 'Cat', 'Any'
    pet_preference_breed VARCHAR(100), -- e.g., 'Labrador', 'Siamese', 'Any'
    pet_preference_size VARCHAR(50) CHECK (pet_preference_size IN ('small', 'medium', 'large', 'Any')),
    pet_preference_temperament VARCHAR(100), -- e.g., 'calm', 'playful', 'Any'
    has_yard BOOLEAN DEFAULT FALSE,
    experience_level VARCHAR(50) CHECK (experience_level IN ('novice', 'intermediate', 'experienced')),
    adoption_status VARCHAR(50) DEFAULT 'pending' CHECK (adoption_status IN ('pending', 'approved', 'rejected')),
    application_date DATE NOT NULL
);

-- Create Pets Table
CREATE TABLE Pets (
    pet_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(100),
    age INTEGER,
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'unknown')),
    size VARCHAR(50) CHECK (size IN ('small', 'medium', 'large')),
    color VARCHAR(50),
    temperament VARCHAR(100), -- e.g., 'calm, friendly', 'playful, energetic', 'shy'
    health_status TEXT,
    vaccination_status BOOLEAN DEFAULT FALSE,
    spayed_neutered BOOLEAN DEFAULT FALSE,
    description TEXT,
    shelter_id INTEGER, -- Assuming this could be a foreign key to a Shelters table if it existed
    housetrained BOOLEAN DEFAULT FALSE,
    good_with_children BOOLEAN DEFAULT TRUE,
    good_with_other_pets BOOLEAN DEFAULT TRUE,
    special_needs TEXT,
    intake_date DATE NOT NULL,
    availability_status VARCHAR(50) DEFAULT 'available' CHECK (availability_status IN ('available', 'pending', 'adopted'))
);

-- Sample Data for Adopters Table
INSERT INTO Adopters (adopter_id, name, email, phone_number, address, lifestyle, household_size, children, other_pets, pet_preference_species, pet_preference_breed, pet_preference_size, pet_preference_temperament, has_yard, experience_level, adoption_status, application_date) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '555-1234', '123 Main St, Anytown', 'active', 2, FALSE, FALSE, 'Dog', 'Labrador', 'medium', 'playful', TRUE, 'experienced', 'approved', '2023-10-01'),
(2, 'Bob The Builder', 'bob@example.com', '555-5678', '456 Oak Rd, Anytown', 'moderate', 1, FALSE, TRUE, 'Cat', 'Any', 'small', 'calm', FALSE, 'intermediate', 'pending', '2023-10-15'),
(3, 'Charlie Brown', 'charlie@example.com', '555-8765', '789 Pine Ln, Anytown', 'sedentary', 3, TRUE, FALSE, 'Dog', 'Beagle', 'small', 'friendly', TRUE, 'novice', 'approved', '2023-11-01'),
(4, 'Diana Prince', 'diana@example.com', '555-4321', '101 Amazon Cir, Anytown', 'active', 1, FALSE, FALSE, 'Any', 'Any', 'Any', 'energetic', TRUE, 'experienced', 'pending', '2023-11-05');

-- Sample Data for Pets Table
INSERT INTO Pets (pet_id, name, species, breed, age, gender, size, color, temperament, health_status, vaccination_status, spayed_neutered, description, shelter_id, housetrained, good_with_children, good_with_other_pets, special_needs, intake_date, availability_status) VALUES
(101, 'Buddy', 'Dog', 'Labrador Retriever', 3, 'male', 'medium', 'Yellow', 'playful, friendly, energetic', 'Excellent', TRUE, TRUE, 'Loves to play fetch and swim.', 1, TRUE, TRUE, TRUE, NULL, '2023-09-01', 'available'),
(102, 'Whiskers', 'Cat', 'Siamese', 2, 'female', 'small', 'Cream', 'calm, affectionate', 'Good, minor allergies', TRUE, TRUE, 'Enjoys lounging and gentle pets.', 1, TRUE, TRUE, FALSE, 'Hypoallergenic food', '2023-08-15', 'available'),
(103, 'Rocky', 'Dog', 'German Shepherd', 5, 'male', 'large', 'Black and Tan', 'loyal, protective, energetic', 'Good, hip dysplasia managed with meds', TRUE, TRUE, 'Former working dog, needs experienced owner.', 2, TRUE, FALSE, FALSE, 'Daily medication for hips', '2023-07-20', 'available'),
(104, 'Lucy', 'Dog', 'Beagle', 1, 'female', 'small', 'Tricolor', 'curious, friendly, playful', 'Excellent', TRUE, TRUE, 'Loves to sniff and explore. Great family dog.', 1, TRUE, TRUE, TRUE, NULL, '2023-09-10', 'pending'),
(105, 'Oliver', 'Cat', 'Domestic Shorthair', 4, 'male', 'medium', 'Orange Tabby', 'independent, playful', 'Excellent', TRUE, TRUE, 'A bit shy at first but warms up.', 2, TRUE, TRUE, TRUE, NULL, '2023-06-05', 'available'),
(106, 'Bella', 'Dog', 'Poodle', 2, 'female', 'small', 'White', 'intelligent, energetic, good with kids', 'Excellent', TRUE, TRUE, 'Hypoallergenic coat, needs regular grooming.', 1, TRUE, TRUE, TRUE, 'Requires grooming', '2023-10-01', 'available'),
(107, 'Max', 'Dog', 'Golden Retriever', 0, 'male', 'medium', 'Golden', 'friendly, energetic, trainable', 'Excellent, puppy shots up to date', TRUE, FALSE, 'Adorable and playful puppy, needs training.', 3, FALSE, TRUE, TRUE, 'Puppy training classes recommended', '2023-11-01', 'available'),
(108, 'Shadow', 'Cat', 'Bombay', 3, 'male', 'medium', 'Black', 'mysterious, calm, affectionate', 'Good', TRUE, TRUE, 'Sleek and loving house panther.', 1, TRUE, FALSE, TRUE, NULL, '2023-08-01', 'adopted'),
(109, 'Daisy', 'Rabbit', 'Holland Lop', 1, 'female', 'small', 'Grey', 'gentle, shy', 'Excellent', TRUE, TRUE, 'Loves carrots and quiet time.', 2, TRUE, TRUE, TRUE, 'Needs a quiet home', '2023-10-20', 'available');

-- Note: `shelter_id` is included but there is no Shelters table in this script.
-- It's assumed it would be a foreign key if that table existed.
-- Boolean values are TRUE/FALSE. Dates are in 'YYYY-MM-DD' format.
-- Temperament can be a list of characteristics.
-- `pet_preference_species = 'Any'` or `pet_preference_breed = 'Any'` etc. in Adopters table means no specific preference.
-- `good_with_children` and `good_with_other_pets` in Pets table are important for matching.
-- `availability_status` in Pets is crucial for filtering.
-- `housetrained` in Pets is a desirable trait.
-- `special_needs` in Pets highlights pets that might need specific care.
-- `experience_level` in Adopters can be matched with pet's needs (e.g. a 'novice' adopter might not be best for a pet with 'behavioral issues' or that 'needs experienced owner').
-- `has_yard` in Adopters could be matched with `size = 'large'` or `temperament = 'energetic'` pets.
-- `children` in Adopters must be considered with `good_with_children` in Pets.
-- `other_pets` in Adopters must be considered with `good_with_other_pets` in Pets.
-- `lifestyle` in Adopters can be matched with `temperament` in Pets (e.g. 'active' adopter with 'energetic' pet).
-- `Adopters.adoption_status` indicates their current application state, not directly used in matching pets but important for the overall process.
-- `Pets.age` = 0 could mean a puppy/kitten less than a year old.
-- `vaccination_status` and `spayed_neutered` are important pet details.
-- `intake_date` for pets can show how long they've been in the shelter.
-- `application_date` for adopters.```sql
-- SQL statements for creating Adopters and Pets tables and inserting sample data

-- Drop tables if they exist (optional, for easy re-running)
DROP TABLE IF EXISTS Pets;
DROP TABLE IF EXISTS Adopters;

-- Create Adopters Table
CREATE TABLE Adopters (
    adopter_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address TEXT,
    lifestyle VARCHAR(50) CHECK (lifestyle IN ('active', 'moderate', 'sedentary')),
    household_size INTEGER DEFAULT 1,
    children BOOLEAN DEFAULT FALSE,
    other_pets BOOLEAN DEFAULT FALSE,
    pet_preference_species VARCHAR(50), -- e.g., 'Dog', 'Cat', 'Any'
    pet_preference_breed VARCHAR(100), -- e.g., 'Labrador', 'Siamese', 'Any'
    pet_preference_size VARCHAR(50) CHECK (pet_preference_size IN ('small', 'medium', 'large', 'Any')),
    pet_preference_temperament VARCHAR(100), -- e.g., 'calm', 'playful', 'Any'
    has_yard BOOLEAN DEFAULT FALSE,
    experience_level VARCHAR(50) CHECK (experience_level IN ('novice', 'intermediate', 'experienced')),
    adoption_status VARCHAR(50) DEFAULT 'pending' CHECK (adoption_status IN ('pending', 'approved', 'rejected')),
    application_date DATE NOT NULL
);

-- Create Pets Table
CREATE TABLE Pets (
    pet_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(100),
    age INTEGER,
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'unknown')),
    size VARCHAR(50) CHECK (size IN ('small', 'medium', 'large')),
    color VARCHAR(50),
    temperament VARCHAR(100), -- e.g., 'calm, friendly', 'playful, energetic', 'shy'
    health_status TEXT,
    vaccination_status BOOLEAN DEFAULT FALSE,
    spayed_neutered BOOLEAN DEFAULT FALSE,
    description TEXT,
    shelter_id INTEGER, -- Assuming this could be a foreign key to a Shelters table if it existed
    housetrained BOOLEAN DEFAULT FALSE,
    good_with_children BOOLEAN DEFAULT TRUE,
    good_with_other_pets BOOLEAN DEFAULT TRUE,
    special_needs TEXT,
    intake_date DATE NOT NULL,
    availability_status VARCHAR(50) DEFAULT 'available' CHECK (availability_status IN ('available', 'pending', 'adopted'))
);

-- Sample Data for Adopters Table
INSERT INTO Adopters (adopter_id, name, email, phone_number, address, lifestyle, household_size, children, other_pets, pet_preference_species, pet_preference_breed, pet_preference_size, pet_preference_temperament, has_yard, experience_level, adoption_status, application_date) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '555-1234', '123 Main St, Anytown', 'active', 2, FALSE, FALSE, 'Dog', 'Labrador', 'medium', 'playful', TRUE, 'experienced', 'approved', '2023-10-01'),
(2, 'Bob The Builder', 'bob@example.com', '555-5678', '456 Oak Rd, Anytown', 'moderate', 1, FALSE, TRUE, 'Cat', 'Any', 'small', 'calm', FALSE, 'intermediate', 'pending', '2023-10-15'),
(3, 'Charlie Brown', 'charlie@example.com', '555-8765', '789 Pine Ln, Anytown', 'sedentary', 3, TRUE, FALSE, 'Dog', 'Beagle', 'small', 'friendly', TRUE, 'novice', 'approved', '2023-11-01'),
(4, 'Diana Prince', 'diana@example.com', '555-4321', '101 Amazon Cir, Anytown', 'active', 1, FALSE, FALSE, 'Any', 'Any', 'Any', 'energetic', TRUE, 'experienced', 'pending', '2023-11-05');

-- Sample Data for Pets Table
INSERT INTO Pets (pet_id, name, species, breed, age, gender, size, color, temperament, health_status, vaccination_status, spayed_neutered, description, shelter_id, housetrained, good_with_children, good_with_other_pets, special_needs, intake_date, availability_status) VALUES
(101, 'Buddy', 'Dog', 'Labrador Retriever', 3, 'male', 'medium', 'Yellow', 'playful, friendly, energetic', 'Excellent', TRUE, TRUE, 'Loves to play fetch and swim.', 1, TRUE, TRUE, TRUE, NULL, '2023-09-01', 'available'),
(102, 'Whiskers', 'Cat', 'Siamese', 2, 'female', 'small', 'Cream', 'calm, affectionate', 'Good, minor allergies', TRUE, TRUE, 'Enjoys lounging and gentle pets.', 1, TRUE, TRUE, FALSE, 'Hypoallergenic food', '2023-08-15', 'available'),
(103, 'Rocky', 'Dog', 'German Shepherd', 5, 'male', 'large', 'Black and Tan', 'loyal, protective, energetic', 'Good, hip dysplasia managed with meds', TRUE, TRUE, 'Former working dog, needs experienced owner.', 2, TRUE, FALSE, FALSE, 'Daily medication for hips', '2023-07-20', 'available'),
(104, 'Lucy', 'Dog', 'Beagle', 1, 'female', 'small', 'Tricolor', 'curious, friendly, playful', 'Excellent', TRUE, TRUE, 'Loves to sniff and explore. Great family dog.', 1, TRUE, TRUE, TRUE, NULL, '2023-09-10', 'pending'),
(105, 'Oliver', 'Cat', 'Domestic Shorthair', 4, 'male', 'medium', 'Orange Tabby', 'independent, playful', 'Excellent', TRUE, TRUE, 'A bit shy at first but warms up.', 2, TRUE, TRUE, TRUE, NULL, '2023-06-05', 'available'),
(106, 'Bella', 'Dog', 'Poodle', 2, 'female', 'small', 'White', 'intelligent, energetic, good with kids', 'Excellent', TRUE, TRUE, 'Hypoallergenic coat, needs regular grooming.', 1, TRUE, TRUE, TRUE, 'Requires grooming', '2023-10-01', 'available'),
(107, 'Max', 'Dog', 'Golden Retriever', 0, 'male', 'medium', 'Golden', 'friendly, energetic, trainable', 'Excellent, puppy shots up to date', TRUE, FALSE, 'Adorable and playful puppy, needs training.', 3, FALSE, TRUE, TRUE, 'Puppy training classes recommended', '2023-11-01', 'available'),
(108, 'Shadow', 'Cat', 'Bombay', 3, 'male', 'medium', 'Black', 'mysterious, calm, affectionate', 'Good', TRUE, TRUE, 'Sleek and loving house panther.', 1, TRUE, FALSE, TRUE, NULL, '2023-08-01', 'adopted'),
(109, 'Daisy', 'Rabbit', 'Holland Lop', 1, 'female', 'small', 'Grey', 'gentle, shy', 'Excellent', TRUE, TRUE, 'Loves carrots and quiet time.', 2, TRUE, TRUE, TRUE, 'Needs a quiet home', '2023-10-20', 'available');

-- Note: `shelter_id` is included but there is no Shelters table in this script.
-- It's assumed it would be a foreign key if that table existed.
-- Boolean values are TRUE/FALSE. Dates are in 'YYYY-MM-DD' format.
-- Temperament can be a list of characteristics.
-- `pet_preference_species = 'Any'` or `pet_preference_breed = 'Any'` etc. in Adopters table means no specific preference.
-- `good_with_children` and `good_with_other_pets` in Pets table are important for matching.
-- `availability_status` in Pets is crucial for filtering.
-- `housetrained` in Pets is a desirable trait.
-- `special_needs` in Pets highlights pets that might need specific care.
-- `experience_level` in Adopters can be matched with pet's needs (e.g. a 'novice' adopter might not be best for a pet with 'behavioral issues' or that 'needs experienced owner').
-- `has_yard` in Adopters could be matched with `size = 'large'` or `temperament = 'energetic'` pets.
-- `children` in Adopters must be considered with `good_with_children` in Pets.
-- `other_pets` in Adopters must be considered with `good_with_other_pets` in Pets.
-- `lifestyle` in Adopters can be matched with `temperament` in Pets (e.g. 'active' adopter with 'energetic' pet).
-- `Adopters.adoption_status` indicates their current application state, not directly used in matching pets but important for the overall process.
-- `Pets.age` = 0 could mean a puppy/kitten less than a year old.
-- `vaccination_status` and `spayed_neutered` are important pet details.
-- `intake_date` for pets can show how long they've been in the shelter.
-- `application_date` for adopters.
```
