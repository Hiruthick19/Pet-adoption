# Schema Proposal for Pet Adoption System

## Adopters Table

| Column Name          | Data Type                     | Description                                                                 |
| -------------------- | ----------------------------- | --------------------------------------------------------------------------- |
| `adopter_id`         | INT (Primary Key)             | Unique identifier for each adopter.                                         |
| `name`               | VARCHAR(255)                  | Full name of the adopter.                                                   |
| `email`              | VARCHAR(255) (Unique)         | Email address of the adopter.                                               |
| `phone_number`       | VARCHAR(20)                   | Phone number of the adopter.                                                |
| `address`            | TEXT                          | Physical address of the adopter.                                            |
| `lifestyle`          | ENUM('active', 'moderate', 'sedentary') | Activity level of the adopter (e.g., active, moderate, sedentary).        |
| `household_size`     | INT                           | Number of people living in the adopter's household.                         |
| `children`           | BOOLEAN                       | Whether the adopter has children.                                           |
| `other_pets`         | BOOLEAN                       | Whether the adopter has other pets.                                         |
| `pet_preference_species` | VARCHAR(50)                 | Preferred species of pet (e.g., dog, cat, rabbit).                          |
| `pet_preference_breed` | VARCHAR(100)                | Preferred breed(s) of pet.                                                  |
| `pet_preference_size`  | ENUM('small', 'medium', 'large') | Preferred size of pet.                                                      |
| `pet_preference_temperament` | VARCHAR(100)                | Preferred temperament of pet (e.g., calm, playful, independent).          |
| `has_yard`           | BOOLEAN                       | Whether the adopter has a yard.                                             |
| `experience_level`   | ENUM('novice', 'intermediate', 'experienced') | Adopter's experience level with pets.                                   |
| `adoption_status`    | ENUM('pending', 'approved', 'rejected') | Current status of the adoption application.                               |
| `application_date`   | DATE                          | Date when the adopter submitted their application.                          |

## Pets Table

| Column Name        | Data Type                     | Description                                                                 |
| ------------------ | ----------------------------- | --------------------------------------------------------------------------- |
| `pet_id`           | INT (Primary Key)             | Unique identifier for each pet.                                             |
| `name`             | VARCHAR(255)                  | Name of the pet.                                                            |
| `species`          | VARCHAR(50)                   | Species of the pet (e.g., dog, cat, rabbit).                                |
| `breed`            | VARCHAR(100)                  | Breed of the pet.                                                           |
| `age`              | INT                           | Age of the pet in years.                                                    |
| `gender`           | ENUM('male', 'female', 'unknown') | Gender of the pet.                                                          |
| `size`             | ENUM('small', 'medium', 'large') | Size of the pet.                                                            |
| `color`            | VARCHAR(50)                   | Color of the pet.                                                           |
| `temperament`      | VARCHAR(100)                  | Temperament of the pet (e.g., calm, playful, shy, energetic).             |
| `health_status`    | TEXT                          | Description of the pet's health status, including any known conditions.     |
| `vaccination_status` | BOOLEAN                       | Whether the pet is up-to-date on vaccinations.                              |
| `spayed_neutered`  | BOOLEAN                       | Whether the pet is spayed or neutered.                                      |
| `description`      | TEXT                          | A brief description of the pet, including its history and personality.      |
| `shelter_id`       | INT (Foreign Key)             | Identifier for the shelter where the pet is located.                        |
| `housetrained`     | BOOLEAN                       | Whether the pet is housetrained.                                            |
| `good_with_children` | BOOLEAN                       | Whether the pet is good with children.                                      |
| `good_with_other_pets` | BOOLEAN                       | Whether the pet is good with other pets.                                    |
| `special_needs`    | TEXT                          | Any special needs the pet may have (e.g., dietary restrictions, medication). |
| `intake_date`      | DATE                          | Date when the pet arrived at the shelter.                                   |
| `availability_status` | ENUM('available', 'pending', 'adopted') | Current availability status of the pet.                                   |
