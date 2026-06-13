-- ============================================================
-- SQLNoir Investigations
-- Case #002: The Stolen Sound
-- Difficulty: Easy
-- ============================================================
-- Objective:
-- Identify who stole the prized vinyl record from West Hollywood Records.
--
-- Investigation Strategy:
-- 1. Retrieve the crime scene report using the known location and crime type.
-- 2. Use the crime scene ID to retrieve witness clues.
-- 3. Match the witness clues against the suspects table.
-- 4. Verify the culprit using interview transcripts.
-- ============================================================


-- Step 1: Retrieve the crime scene report.
SELECT *
FROM crime_scene
WHERE location = 'West Hollywood Records'
  AND type = 'theft';


-- Finding:
-- The report confirms that a prized vinyl record was stolen
-- from West Hollywood Records during a busy evening.
-- The crime scene ID is 65.


-- Step 2: Retrieve witness clues linked to the crime scene.
SELECT *
FROM witnesses
WHERE crime_scene_id = 65;


-- Finding:
-- Witness 1 saw a man wearing a red bandana rushing out of the store.
-- Witness 2 remembered that the suspect had a distinctive gold watch.


-- Step 3: Find suspects matching both witness clues.
SELECT *
FROM suspects
WHERE bandana_color = 'red'
  AND accessory = 'gold watch';


-- Finding:
-- Three suspects matched the description:
-- 1. Tony Ramirez, suspect ID 35
-- 2. Mickey Rivera, suspect ID 44
-- 3. Rico Delgado, suspect ID 97


-- Step 4: Review interview transcripts for the matching suspects.
SELECT *
FROM interviews
WHERE suspect_id IN (35, 44, 97);


-- Finding:
-- Tony Ramirez denied being near West Hollywood Records.
-- Mickey Rivera denied involvement.
-- Rico Delgado's transcript said:
-- "I couldn't help it. I snapped and took the record."


-- ============================================================
-- Final Conclusion:
-- The culprit is Rico Delgado.
-- ============================================================