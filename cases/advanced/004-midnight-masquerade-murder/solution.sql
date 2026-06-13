-- ============================================================
-- SQLNoir Investigations
-- Case #004: The Midnight Masquerade Murder
-- Difficulty: Advanced
-- ============================================================
-- Objective:
-- Identify who murdered Leonard Pierce during the masked ball
-- at the Coconut Grove mansion.
--
-- Investigation Strategy:
-- 1. Retrieve the crime scene report.
-- 2. Review witness statements.
-- 3. Follow the hotel booking clue.
-- 4. Join hotel check-ins with surveillance records.
-- 5. Investigate suspicious phone activity.
-- 6. Use the carpenter clue to narrow the suspect list.
-- 7. Confirm the culprit through final interviews.
-- ============================================================


-- Step 1: Retrieve the crime scene report.
SELECT *
FROM crime_scene
WHERE date = 19871031
  AND location LIKE '%Coconut Grove%';


-- Finding:
-- The report mentioned a hotel booking and suspicious phone activity.


-- Step 2: Retrieve witness statements linked to the crime scene.
SELECT *
FROM witness_statements
WHERE crime_scene_id = 75;


-- Finding:
-- Witnesses mentioned:
-- 1. A booking at The Grand Regency.
-- 2. Room 707.
-- 3. A reservation made yesterday, meaning October 30, 1987.


-- Step 3: Find hotel check-ins matching the witness clues.
SELECT *
FROM hotel_checkins
WHERE hotel_name = 'The Grand Regency'
  AND room_number = 707
  AND check_in_date = 19871030;


-- Finding:
-- Multiple people were linked to the same hotel, room, and date.


-- Step 4: Check whether anyone appeared multiple times in the check-ins.
SELECT 
    person_id,
    COUNT(*) AS number_of_checkins
FROM hotel_checkins
WHERE hotel_name = 'The Grand Regency'
  AND room_number = 707
  AND check_in_date = 19871030
GROUP BY person_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;


-- Finding:
-- person_id 198 appeared 3 times.
-- person_id 123 appeared 2 times.
-- This was suspicious but not enough to solve the case.


-- Step 5: Retrieve people linked to the hotel clue.
SELECT *
FROM person
WHERE id IN (78, 123, 34, 11, 198, 178, 156);


-- Step 6: Join hotel check-ins with surveillance records.
SELECT 
    hc.id,
    hc.person_id,
    sr.note
FROM hotel_checkins AS hc
INNER JOIN surveillance_records AS sr
    ON hc.id = sr.hotel_checkin_id
WHERE hc.hotel_name = 'The Grand Regency'
  AND hc.room_number = 707
  AND hc.check_in_date = 19871030;


-- Finding:
-- person_id 11, Antonio Rossi, had a suspicious surveillance note:
-- Subject was overheard yelling on a phone: "Did you kill him?"


-- Step 7: Investigate phone records connected to Antonio Rossi.
SELECT 
    caller_id,
    recipient_id,
    call_date,
    call_time,
    note
FROM phone_records
WHERE caller_id = 11
   OR recipient_id = 11;


-- Finding:
-- Antonio Rossi called person_id 58.
-- The call note said:
-- "Why did you kill him, bro? You should have left the carpenter do it himself!"
--
-- This introduced two important leads:
-- 1. person_id 58 was involved as a middleman.
-- 2. The true killer was likely a carpenter.


-- Step 8: Find all carpenters.
SELECT *
FROM person
WHERE occupation = 'Carpenter';


-- Finding:
-- Carpenter suspects included:
-- Frank Price, Julie Sanders, Marco Santos, Amy Evans, and Judith Fisher.


-- Step 9: Check final interviews for the middleman, suspicious people, and carpenters.
SELECT *
FROM final_interviews
WHERE person_id IN (58, 11, 198, 51, 90, 97, 134, 176);


-- Finding:
-- person_id 58 admitted to being a middleman.
-- person_id 97 confessed:
-- "I ordered the hit. It was me. You caught me."


-- Step 10: Retrieve the culprit's identity.
SELECT *
FROM person
WHERE id = 97;


-- Finding:
-- person_id 97 is Marco Santos, a carpenter.


-- ============================================================
-- Final Conclusion:
-- The culprit is Marco Santos.
-- ============================================================