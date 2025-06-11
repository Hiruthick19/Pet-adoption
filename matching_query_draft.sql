WITH AdopterPreferences AS (
    -- Select preferences for a specific adopter
    SELECT
        adopter_id,
        name,
        lifestyle, -- e.g., 'active', 'moderate', 'sedentary'
        children AS has_children,
        other_pets AS has_other_pets,
        pet_preference_species,
        pet_preference_breed,
        pet_preference_size,
        pet_preference_temperament -- e.g., 'calm', 'playful'
    FROM Adopters
    WHERE adopter_id = :selected_adopter_id -- Placeholder for the specific adopter ID
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
        -- Score Calculation
        (
            CASE
                WHEN ap.pet_preference_species IS NOT NULL AND ap.pet_preference_species <> 'Any' AND p.species = ap.pet_preference_species THEN 10
                WHEN ap.pet_preference_species IS NULL OR ap.pet_preference_species = 'Any' THEN 5 -- Partial points if no specific species preference
                ELSE 0
            END
        ) +
        (
            CASE
                WHEN ap.pet_preference_breed IS NOT NULL AND ap.pet_preference_breed <> 'Any' AND p.breed = ap.pet_preference_breed THEN 5
                WHEN ap.pet_preference_breed IS NULL OR ap.pet_preference_breed = 'Any' THEN 2 -- Partial points if no specific breed preference
                ELSE 0
            END
        ) +
        (
            CASE
                WHEN ap.pet_preference_size IS NOT NULL AND ap.pet_preference_size <> 'Any' AND p.size = ap.pet_preference_size THEN 5
                WHEN ap.pet_preference_size IS NULL OR ap.pet_preference_size = 'Any' THEN 2 -- Partial points if no specific size preference
                ELSE 0
            END
        ) +
        (
            -- Matching Adopter's lifestyle preference (pet_preference_temperament) with Pet's temperament
            -- This is an interpretation of "+5 points if Pets.ActivityLevel matches Adopters.LifestyleActivityLevel"
            -- using available fields.
            CASE
                WHEN ap.pet_preference_temperament IS NOT NULL AND ap.pet_preference_temperament <> 'Any' AND p.temperament LIKE '%' || ap.pet_preference_temperament || '%' THEN 5
                WHEN ap.pet_preference_temperament IS NULL OR ap.pet_preference_temperament = 'Any' THEN 2
                ELSE 0
            END
        ) +
        (
            CASE
                WHEN p.good_with_children = TRUE OR ap.has_children = FALSE THEN 10
                ELSE 0
            END
        ) +
        (
            CASE
                WHEN p.good_with_other_pets = TRUE OR ap.has_other_pets = FALSE THEN 10
                ELSE 0
            END
        )
        -- Additional scoring criteria can be added here:
        -- For example, matching adopter's general lifestyle with pet's temperament more broadly
        + (
            CASE
                WHEN ap.lifestyle = 'active' AND (p.temperament LIKE '%energetic%' OR p.temperament LIKE '%playful%') THEN 3
                WHEN ap.lifestyle = 'moderate' AND (p.temperament LIKE '%calm%' OR p.temperament LIKE '%friendly%') THEN 3
                WHEN ap.lifestyle = 'sedentary' AND (p.temperament LIKE '%calm%' OR p.temperament LIKE '%shy%') THEN 3
                ELSE 0
            END
        )
        -- Points if pet is housetrained
        + (CASE WHEN p.housetrained = TRUE THEN 5 ELSE 0 END)

    ) AS MatchScore
FROM
    Pets p, AdopterPreferences ap
WHERE
    p.availability_status = 'available'
ORDER BY
    MatchScore DESC;
