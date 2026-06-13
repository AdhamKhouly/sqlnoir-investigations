-- ============================================================
-- SQLNoir Investigations
-- Case #006: The Vanishing Diamond
-- Difficulty: Intermediate
-- ============================================================
-- Objective:
-- Identify who stole the Heart of Atlantis diamond necklace
-- from the Fontainebleau Hotel charity gala.
--
-- Investigation Strategy:
-- 1. Retrieve the crime scene report.
-- 2. Identify the two useful witnesses.
-- 3. Review their witness statements.
-- 4. Match the invitation and attire clues.
-- 5. Verify the marina dock clue.
-- 6. Confirm the culprit using the final interview.
-- ============================================================


-- Step 1: Retrieve the crime scene report.
SELECT *
FROM crime_scene
WHERE location = 'Fontainebleau Hotel';


-- Finding:
-- The Heart of Atlantis necklace disappeared.
-- Only two guests gave valuable clues:
-- 1. A famous actor.
-- 2. A female consultant whose first name ends with "an".


-- Step 2: Identify possible witnesses.
SELECT *
FROM guest
WHERE occupation = 'Actor'
   OR (occupation = 'Consultant' AND name LIKE '%an %');


-- Finding:
-- The famous actor is Clint Eastwood, guest ID 129.
-- The consultant matching the name clue is Vivian Nair, guest ID 116.


-- Step 3: Retrieve witness statements from Vivian Nair and Clint Eastwood.
SELECT 
    g.id,
    g.name,
    ws.clue
FROM guest AS g
INNER JOIN witness_statements AS ws
    ON g.id = ws.guest_id
WHERE g.id IN (116, 129);


-- Finding:
-- Vivian Nair saw someone holding an invitation ending with "-R"
-- and wearing a navy suit with a white tie.
-- Clint Eastwood overheard someone say:
-- "Meet me at the marina, dock 3."


-- Step 4: Find the guest matching the invitation and attire clues.
SELECT 
    g.id AS guest_id,
    g.name,
    g.invitation_code,
    ar.note
FROM guest AS g
INNER JOIN attire_registry AS ar
    ON g.id = ar.guest_id
WHERE g.invitation_code LIKE '%-R'
  AND ar.note = 'navy suit, white tie';


-- Finding:
-- Mike Manning, guest ID 105, matched the invitation and attire clues.


-- Step 5: Verify the marina dock 3 clue.
SELECT *
FROM marina_rentals
WHERE renter_guest_id = 105
  AND dock_number = 3;


-- Finding:
-- Mike Manning rented a boat at dock 3 on the date of the gala.
-- Boat name: Coastal Spirit.


-- Step 6: Check Mike Manning's final interview.
SELECT *
FROM final_interviews
WHERE guest_id = 105;


-- Finding:
-- Mike Manning confessed:
-- "I was the one who took the crystal. I guess I need a lawyer now?"


-- ============================================================
-- Final Conclusion:
-- The culprit is Mike Manning.
-- ============================================================