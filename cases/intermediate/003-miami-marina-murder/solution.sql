-- ============================================================
-- SQLNoir Investigations
-- Case #003: The Miami Marina Murder
-- Difficulty: Intermediate
-- ============================================================
-- Objective:
-- Identify the murderer connected to the body found near
-- Coral Bay Marina on August 14, 1986.
--
-- Investigation Strategy:
-- 1. Retrieve the crime scene report.
-- 2. Use location/name clues to identify people seen nearby.
-- 3. Review their interview transcripts.
-- 4. Follow the hotel clue to Sunset hotel check-ins.
-- 5. Join hotel check-ins with surveillance records.
-- 6. Check confessions for the most suspicious people.
-- ============================================================


-- Step 1: Retrieve the crime scene report.
SELECT *
FROM crime_scene
WHERE location = 'Coral Bay Marina';


-- Finding:
-- The report states that two people were seen nearby:
-- 1. Someone living on a 300ish Ocean Drive address.
-- 2. Someone whose first name ends with "ul" and last name ends with "ez".


-- Step 2: Identify the two people from the crime scene clues.
SELECT *
FROM person
WHERE address LIKE '3__ Ocean Drive'
   OR name LIKE '%ul %ez';


-- Finding:
-- Carlos Mendez matched the Ocean Drive clue.
-- Raul Gutierrez matched the name clue.


-- Step 3: Review interviews for those two people.
SELECT 
    i.id AS interview_id,
    p.name,
    p.alias,
    i.transcript
FROM person AS p
INNER JOIN interviews AS i
    ON p.id = i.person_id
WHERE p.address LIKE '3__ Ocean Drive'
   OR p.name LIKE '%ul %ez';


-- Finding:
-- Carlos Mendez saw someone check into a hotel on August 13.
-- Raul Gutierrez heard the hotel had "Sunset" in the name.


-- Step 4: Retrieve Sunset hotel check-ins on August 13, 1986.
SELECT *
FROM hotel_checkins
WHERE hotel_name LIKE '%Sunset%'
  AND check_in_date = 19860813;


-- Finding:
-- This returned many possible check-ins.
-- The suspect list was too broad, so surveillance records were needed.


-- Step 5: Join Sunset hotel check-ins with surveillance records.
SELECT 
    sr.person_id,
    sr.suspicious_activity
FROM hotel_checkins AS hc
INNER JOIN surveillance_records AS sr
    ON hc.person_id = sr.person_id
WHERE hc.hotel_name LIKE '%Sunset%'
  AND hc.check_in_date = 19860813;


-- Finding:
-- The most suspicious activities were:
-- person_id 6: Spotted entering late at night
-- person_id 7: Seen arguing with an unknown person
-- person_id 8: Left suddenly at 3 AM


-- Step 6: Check confessions for the suspicious people.
SELECT 
    sr.person_id,
    p.name,
    sr.suspicious_activity,
    c.confession
FROM hotel_checkins AS hc
INNER JOIN surveillance_records AS sr
    ON hc.person_id = sr.person_id
INNER JOIN confessions AS c
    ON sr.person_id = c.person_id
INNER JOIN person AS p
    ON p.id = c.person_id
WHERE c.person_id IN (6, 7, 8);


-- Finding:
-- Thomas Brown confessed:
-- "Alright! I did it. I was paid to make sure he never left the marina alive."


-- ============================================================
-- Final Conclusion:
-- The culprit is Thomas Brown.
-- ============================================================