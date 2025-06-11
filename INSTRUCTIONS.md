# Pet Adoption Matching System - SQL Script Instructions

## 1. Overview

This project provides a set of SQL scripts to model a basic pet adoption matching system. The core of this system is the `pet_matching.sql` file, which includes:

*   **Table Creation:** SQL `CREATE TABLE` statements for an `Adopters` table (storing information about potential adopters and their preferences) and a `Pets` table (storing details of pets available for adoption).
*   **Sample Data:** SQL `INSERT INTO` statements to populate these tables with illustrative data, allowing for immediate testing of the matching logic.
*   **Matching Query:** A `SELECT` query that implements a scoring system to find suitable pets for a specific adopter based on various criteria like species preference, size, temperament, and lifestyle compatibility.

## 2. Prerequisites

*   **SQL Database System:** You will need access to a SQL-based Relational Database Management System (RDBMS). Examples include:
    *   PostgreSQL
    *   MySQL
    *   SQLite (a good option for local testing as it's file-based)
    *   SQL Server
*   **Database Client/Tool:** A tool to connect to your database and execute SQL scripts (e.g., pgAdmin for PostgreSQL, MySQL Workbench, DBeaver, SQLite Browser, or command-line interfaces like `psql` or `mysql`).
*   **SQL Knowledge (Basic):** Familiarity with basic SQL concepts will be helpful for understanding and potentially customizing the scripts.

**Note on SQL Dialect:** The SQL used in `pet_matching.sql` is fairly standard. However, minor adjustments to data types (e.g., `BOOLEAN` might be `TINYINT(1)` in some MySQL versions) or the syntax for `CHECK` constraints might be needed depending on your specific RDBMS. The script is designed to be as generic as possible.

## 3. How to Use `pet_matching.sql`

The `pet_matching.sql` file is designed to be run as a single script.

1.  **Connect to your Database:** Use your chosen SQL database management tool to connect to your database server or open your local database file (for SQLite).
2.  **Open the Script:** Open the `pet_matching.sql` file in your database tool's SQL editor.
3.  **Execute the Script:** Run the entire content of `pet_matching.sql`.

**What the script does upon execution:**
*   It will first attempt to `DROP` (delete) the `Pets` and `Adopters` tables if they already exist. This allows for easy re-running of the script from a clean state.
*   It will then `CREATE` the `Adopters` and `Pets` tables with the defined schema.
*   Next, it will `INSERT` the sample data provided into both tables.
*   Finally, it will execute the pet matching `SELECT` query.

## 4. The Matching Query

The final `SELECT` query within `pet_matching.sql` (after all the `CREATE` and `INSERT` statements) performs the actual matching.

*   **Pre-configured for Adopter ID 1:** By default, this query is set up to find pet matches for `AdopterID = 1` (Alice Wonderland from the sample data). This is specified within a Common Table Expression (CTE) called `AdopterPreferences`:
    ```sql
    WITH AdopterPreferences AS (
        SELECT
            -- ... columns ...
        FROM Adopters
        WHERE adopter_id = 1 -- <<< SET TARGET ADOPTER_ID HERE
    )
    -- ... rest of the query ...
    ```
*   **Testing with Other Adopters:** To find matches for a different adopter, you need to modify this line. For example, to find matches for Charlie Brown (`adopter_id = 3` in the sample data), change it to:
    ```sql
    WHERE adopter_id = 3
    ```
    The sample `Adopters` table includes IDs 1, 2, 3, and 4 for testing.

## 5. Output

After the script executes, the final `SELECT` query will produce a result set. This output will be:

*   A list of pets from the `Pets` table that are currently `available` for adoption.
*   Each row will represent a pet and include details such as `PetID`, `PetName`, `PetSpecies`, `PetBreed`, `PetTemperament`, etc.
*   Crucially, it will also include a `MatchScore` column. This score is calculated based on how well the pet's characteristics align with the selected adopter's preferences and circumstances.
*   The results are ordered by `MatchScore` in descending order, so the most suitable pets appear at the top.

## 6. Customization and Integration

*   **Adding More Data:** You can easily add more sample adopters or pets by writing additional `INSERT INTO Adopters (...) VALUES (...);` or `INSERT INTO Pets (...) VALUES (...);` statements within the `pet_matching.sql` file (or by running them separately after the initial setup).
*   **Real Application Integration:** In a real-world application (e.g., a web application), this SQL logic would typically be part of the backend system.
    *   The backend code (e.g., written in Python, Java, Node.js) would connect to the database.
    *   The matching query would be executed by this backend code.
    *   The `AdopterID` (and potentially other parameters like specific filter criteria) would be passed dynamically to the query from the application's user interface or business logic, rather than being hardcoded in the SQL.

## 7. Project Files

Here's a summary of the key SQL-related files created during the development of this system:

*   `schema_proposal.md`:
    *   **Purpose:** An initial Markdown document outlining the conceptual schema for the `Adopters` and `Pets` tables, including column names, suggested data types, and descriptions. This was the planning document for the database structure.
*   `database_setup.sql`:
    *   **Purpose:** Contains the SQL `CREATE TABLE` statements derived from the schema proposal and the `INSERT INTO` statements for populating the tables with sample data.
*   `matching_query_draft.sql`:
    *   **Purpose:** The initial draft of the SQL `SELECT` query designed for matching pets to adopters, including the basic scoring logic.
*   **`pet_matching.sql`**:
    *   **Purpose:** This is the **primary, consolidated, and runnable SQL script**. It combines the table creation and data insertion from `database_setup.sql` with the refined and heavily commented matching query from `matching_query_draft.sql`. **This is the file you should use to set up and test the system.**

These files represent the progression from conceptual design to a runnable SQL implementation for the pet matching system.
