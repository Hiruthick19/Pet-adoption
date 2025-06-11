-- SQL statements for creating Adopters and Pets tables, inserting sample data,
-- and running a sample pet matching query.

--------------------------------------------------------------------------------
-- PART 1: Database Setup (Creating Tables and Inserting Sample Data)
--------------------------------------------------------------------------------

-- Drop tables if they exist (optional, for easy re-running of the script)
DROP TABLE IF EXISTS Pets;
DROP TABLE IF EXISTS Adopters;

-- Create Adopters Table
-- Stores information about potential adopters and their preferences.
CREATE TABLE Adopters (
    adopter_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    address TEXT,
    lifestyle VARCHAR(50) CHECK (lifestyle IN ('active', 'moderate', 'sedentary')), -- Adopter's general activity level
    household_size INTEGER DEFAULT 1,
    children BOOLEAN DEFAULT FALSE, -- Does the adopter have children?
    other_pets BOOLEAN DEFAULT FALSE, -- Does the adopter have other pets?
    pet_preference_species VARCHAR(50), -- Preferred species (e.g., 'Dog', 'Cat', or 'Any')
    pet_preference_breed VARCHAR(100), -- Preferred breed (e.g., 'Labrador', 'Siamese', or 'Any')
    pet_preference_size VARCHAR(50) CHECK (pet_preference_size IN ('small', 'medium', 'large', 'Any')), -- Preferred pet size
    pet_preference_temperament VARCHAR(100), -- Preferred pet temperament (e.g., 'calm', 'playful', or 'Any')
    has_yard BOOLEAN DEFAULT FALSE, -- Does the adopter have a yard?
    experience_level VARCHAR(50) CHECK (experience_level IN ('novice', 'intermediate', 'experienced')), -- Adopter's experience with pets
    adoption_status VARCHAR(50) DEFAULT 'pending' CHECK (adoption_status IN ('pending', 'approved', 'rejected')), -- Status of their adoption application
    application_date DATE NOT NULL -- Date of application
);

-- Create Pets Table
-- Stores information about pets available for adoption.
CREATE TABLE Pets (
    pet_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    species VARCHAR(50) NOT NULL, -- Species of the pet (e.g., 'Dog', 'Cat', 'Rabbit')
    breed VARCHAR(100), -- Breed of the pet
    age INTEGER, -- Age of the pet in years (0 for pets less than a year old)
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'unknown')),
    size VARCHAR(50) CHECK (size IN ('small', 'medium', 'large')), -- Size of the pet
    color VARCHAR(50),
    temperament VARCHAR(100), -- Temperament of the pet (e.g., 'calm, friendly', 'playful, energetic')
    health_status TEXT, -- General health status
    vaccination_status BOOLEAN DEFAULT FALSE, -- Is the pet vaccinated?
    spayed_neutered BOOLEAN DEFAULT FALSE, -- Is the pet spayed/neutered?
    description TEXT, -- Detailed description of the pet
    shelter_id INTEGER, -- FK to a potential Shelters table
    housetrained BOOLEAN DEFAULT FALSE, -- Is the pet housetrained?
    good_with_children BOOLEAN DEFAULT TRUE, -- Is the pet good with children?
    good_with_other_pets BOOLEAN DEFAULT TRUE, -- Is the pet good with other pets?
    special_needs TEXT, -- Any special needs (e.g., dietary, medical)
    intake_date DATE NOT NULL, -- Date the pet arrived at the shelter
    availability_status VARCHAR(50) DEFAULT 'available' CHECK (availability_status IN ('available', 'pending', 'adopted')) -- Current adoption status of the pet
);

-- Sample Data for Adopters Table
INSERT INTO Adopters (adopter_id, name, email, phone_number, address, lifestyle, household_size, children, other_pets, pet_preference_species, pet_preference_breed, pet_preference_size, pet_preference_temperament, has_yard, experience_level, adoption_status, application_date) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '555-1234', '123 Main St, Anytown', 'active', 2, FALSE, FALSE, 'Dog', 'Labrador Retriever', 'medium', 'playful', TRUE, 'experienced', 'approved', '2023-10-01'),
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
(109, 'Daisy', 'Rabbit', 'Holland Lop', 1, 'female', 'small', 'Grey', 'gentle, shy', 'Excellent', TRUE, TRUE, 'Loves carrots and quiet time.', 2, TRUE, TRUE, TRUE, 'Needs a quiet home', '2023-10-20', 'available'),
(110, 'Cooper', 'Dog', 'Australian Shepherd', 2, 'male', 'medium', 'Blue Merle', 'highly energetic, intelligent, needs job', 'Excellent', TRUE, TRUE, 'Needs a very active home, great for sports.', 3, TRUE, TRUE, FALSE, 'Not ideal for first-time owners', '2023-09-15', 'available');

--------------------------------------------------------------------------------
-- PART 2: Pet Matching Query
--------------------------------------------------------------------------------

-- This query finds suitable pets for a specific adopter based on a scoring system.
-- It uses a Common Table Expression (CTE) to first select the preferences
-- of the target adopter.

-- Adopter ID for whom we are finding matches.
-- Replace '1' with the desired adopter_id from the Adopters table.
-- For this example, adopter_id = 1 is 'Alice Wonderland'.
WITH AdopterPreferences AS (
    SELECT
        adopter_id,
        name,
        lifestyle,
        children AS has_children, -- Renamed for clarity in the main query
        other_pets AS has_other_pets, -- Renamed for clarity
        pet_preference_species,
        pet_preference_breed,
        pet_preference_size,
        pet_preference_temperament
    FROM Adopters
    WHERE adopter_id = 1 -- <<< SET TARGET ADOPTER_ID HERE
)
SELECT
    p.pet_id AS PetID,
    p.name AS PetName,
    p.species AS PetSpecies,
    p.breed AS PetBreed,
    p.age AS PetAge,
    p.gender AS PetGender,
    p.size AS PetSize,
    p.temperament AS PetTemperament,
    p.description AS PetDescription,
    p.health_status AS PetHealthStatus,
    p.housetrained AS PetIsHousetrained,
    p.good_with_children AS PetIsGoodWithChildren,
    p.good_with_other_pets AS PetIsGoodWithOtherPets,
    p.availability_status AS PetAvailabilityStatus,
    (
        -- MatchScore Calculation: Points are awarded based on how well pet attributes match adopter preferences.

        -- Score for species match:
        -- +10 if pet's species matches adopter's preferred species (and preference is not 'Any').
        -- +5 if adopter has no specific species preference ('Any' or NULL).
        (
            CASE
                WHEN ap.pet_preference_species IS NOT NULL AND ap.pet_preference_species <> 'Any' AND p.species = ap.pet_preference_species THEN 10
                WHEN ap.pet_preference_species IS NULL OR ap.pet_preference_species = 'Any' THEN 5
                ELSE 0
            END
        ) +

        -- Score for breed match:
        -- +5 if pet's breed matches adopter's preferred breed (and preference is not 'Any').
        -- +2 if adopter has no specific breed preference ('Any' or NULL).
        -- Note: Adopters.pet_preference_breed was 'Labrador' in schema, changed to 'Labrador Retriever' in sample data for Alice.
        -- This query will match p.breed = 'Labrador Retriever' with ap.pet_preference_breed = 'Labrador Retriever'.
        (
            CASE
                WHEN ap.pet_preference_breed IS NOT NULL AND ap.pet_preference_breed <> 'Any' AND p.breed = ap.pet_preference_breed THEN 5
                WHEN ap.pet_preference_breed IS NULL OR ap.pet_preference_breed = 'Any' THEN 2
                ELSE 0
            END
        ) +

        -- Score for size match:
        -- +5 if pet's size matches adopter's preferred size (and preference is not 'Any').
        -- +2 if adopter has no specific size preference ('Any' or NULL).
        (
            CASE
                WHEN ap.pet_preference_size IS NOT NULL AND ap.pet_preference_size <> 'Any' AND p.size = ap.pet_preference_size THEN 5
                WHEN ap.pet_preference_size IS NULL OR ap.pet_preference_size = 'Any' THEN 2
                ELSE 0
            END
        ) +

        -- Score for temperament match (based on adopter's specific temperament preference):
        -- +5 if pet's temperament description contains the adopter's preferred temperament (e.g., 'playful', 'calm').
        --    This uses LIKE '%value%' to allow for flexible matching within the temperament string.
        -- +2 if adopter has no specific temperament preference ('Any' or NULL).
        (
            CASE
                WHEN ap.pet_preference_temperament IS NOT NULL AND ap.pet_preference_temperament <> 'Any' AND p.temperament LIKE '%' || ap.pet_preference_temperament || '%' THEN 5
                WHEN ap.pet_preference_temperament IS NULL OR ap.pet_preference_temperament = 'Any' THEN 2
                ELSE 0
            END
        ) +

        -- Score for compatibility with children:
        -- +10 if the pet is good with children OR the adopter does not have children.
        (
            CASE
                WHEN p.good_with_children = TRUE OR ap.has_children = FALSE THEN 10
                ELSE 0
            END
        ) +

        -- Score for compatibility with other pets:
        -- +10 if the pet is good with other pets OR the adopter does not have other pets.
        (
            CASE
                WHEN p.good_with_other_pets = TRUE OR ap.has_other_pets = FALSE THEN 10
                ELSE 0
            END
        ) +

        -- Score for lifestyle and pet's temperament broad match:
        -- +3 if adopter's general lifestyle aligns with common keywords in pet's temperament.
        -- This is a more general match than the specific pet_preference_temperament.
        (
            CASE
                WHEN ap.lifestyle = 'active' AND (p.temperament LIKE '%energetic%' OR p.temperament LIKE '%playful%') THEN 3
                WHEN ap.lifestyle = 'moderate' AND (p.temperament LIKE '%calm%' OR p.temperament LIKE '%friendly%' OR p.temperament LIKE '%affectionate%') THEN 3
                WHEN ap.lifestyle = 'sedentary' AND (p.temperament LIKE '%calm%' OR p.temperament LIKE '%shy%' OR p.temperament LIKE '%gentle%') THEN 3
                ELSE 0
            END
        ) +

        -- Score for housetrained pet:
        -- +5 if the pet is housetrained.
        (
            CASE WHEN p.housetrained = TRUE THEN 5 ELSE 0 END
        )

    ) AS MatchScore
FROM
    Pets p, AdopterPreferences ap -- Implicit cross join, but AdopterPreferences CTE has only one row due to adopter_id filter.
WHERE
    p.availability_status = 'available' -- Only consider pets that are currently available for adoption.
ORDER BY
    MatchScore DESC; -- Show the best matches first.

-- Example: To run for Charlie Brown (adopter_id = 3), change `WHERE adopter_id = 1` to `WHERE adopter_id = 3` in the CTE.
-- Charlie's preferences: Dog, Beagle, small, friendly. Has children. Sedentary lifestyle.
-- Expected high scores for: Lucy (Beagle, if available), other small, friendly dogs good with children.
-- Let's test with Adopter 3 (Charlie Brown) who has children and prefers a small, friendly dog.
-- Change `adopter_id = 1` to `adopter_id = 3` in the CTE above and re-run if desired.
-- For this saved script, it's set to Alice (adopter_id = 1).
-- Alice's preferences: Dog, Labrador Retriever, medium, playful. No children, no other pets. Active lifestyle.
-- Expected high scores for: Buddy (Labrador). Max (Golden Retriever puppy, also playful/energetic). Cooper (Australian Shepherd, energetic).
