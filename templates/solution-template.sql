-- ============================================================
-- SQLNoir Investigations
-- CASE_TITLE
-- Difficulty: DIFFICULTY_LEVEL
-- ============================================================
-- Objective:
-- Briefly describe what this case is trying to solve.
--
-- Investigation Strategy:
-- 1. Retrieve the original case report.
-- 2. Extract the key clues.
-- 3. Query related tables to narrow the suspect list.
-- 4. Verify the culprit using final evidence.
-- ============================================================


-- Step 1: Retrieve the original case report.
SELECT *
FROM table_name
WHERE condition = 'value';


-- Finding:
-- Explain what this query revealed.


-- Step 2: Use the first clue to narrow the investigation.
SELECT *
FROM table_name
WHERE condition = 'value';


-- Finding:
-- Explain what this query revealed.


-- Step 3: Join related tables to connect the evidence.
SELECT 
    t1.column_name,
    t2.column_name
FROM table_one AS t1
INNER JOIN table_two AS t2
    ON t1.id = t2.table_one_id
WHERE t1.condition = 'value';


-- Finding:
-- Explain what this query revealed.


-- Step 4: Check final evidence.
SELECT *
FROM final_table
WHERE id IN (1, 2, 3);


-- Finding:
-- Explain what confirmed the culprit.


-- ============================================================
-- Final Conclusion:
-- The culprit is CULPRIT_NAME.
-- ============================================================