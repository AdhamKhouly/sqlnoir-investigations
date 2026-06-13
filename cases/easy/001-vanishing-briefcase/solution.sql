-- ============================================================
-- SQLNoir Investigations
-- Case #001: The Vanishing Briefcase
-- Difficulty: Easy
-- ============================================================
-- Objective:
-- Identify who stole the briefcase from the Blue Note Lounge.
--
-- Investigation Strategy:
-- 1. Retrieve the crime scene details.
-- 2. Extract the witness description.
-- 3. Match the description against the suspects table.
-- 4. Verify the culprit using interview transcripts.
-- ============================================================


-- Step 1: Retrieve the crime scene report for the Blue Note Lounge.
SELECT *
FROM crime_scene
WHERE location = 'Blue Note Lounge';


-- Finding:
-- The report states that a briefcase containing sensitive documents vanished.
-- A witness saw a man in a trench coat with a scar on his left cheek fleeing the scene.


-- Step 2: Find suspects matching the witness description.
SELECT *
FROM suspects
WHERE attire = 'trench coat'
  AND scar = 'left cheek';


-- Finding:
-- Two suspects matched the description:
-- 1. Frankie Lombardi, suspect ID 3
-- 2. Vincent Malone, suspect ID 183


-- Step 3: Review interview transcripts for both suspects.
SELECT *
FROM interviews
WHERE suspect_id IN (3, 183);


-- Finding:
-- Frankie Lombardi had no confession in the transcript.
-- Vincent Malone's transcript said:
-- "I wasn’t going to steal it, but I did."


-- ============================================================
-- Final Conclusion:
-- The culprit is Vincent Malone.
-- ============================================================