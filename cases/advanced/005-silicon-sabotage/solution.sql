-- ============================================================
-- SQLNoir Investigations
-- Case #005: The Silicon Sabotage
-- Difficulty: Advanced
-- ============================================================
-- Objective:
-- Identify who sabotaged the QuantaX microprocessor at QuantumTech.
--
-- Investigation Strategy:
-- 1. Retrieve the incident report.
-- 2. Review witness statements.
-- 3. Use keycard and Helsinki server clues.
-- 4. Investigate employee email trails.
-- 5. Check Facility 18 access logs.
-- 6. Identify the employee who accessed Facility 18 after Elizabeth.
-- ============================================================


-- Step 1: Retrieve the QuantumTech incident report.
SELECT *
FROM incident_reports
WHERE location LIKE '%QuantumTech%';


-- Finding:
-- Incident ID 74.
-- Incident date: 19890421.
-- Prototype destroyed and data erased from servers.


-- Step 2: Retrieve witness statements linked to the incident.
SELECT *
FROM witness_statements
WHERE incident_id = 74;


-- Finding:
-- Employee 145 heard someone mention a server in Helsinki.
-- Employee 134 saw someone holding a keycard marked QX-
-- followed by a two-digit odd number.


-- Step 3: Find keycard records matching the QX clue.
SELECT *
FROM keycard_access_logs
WHERE keycard_code LIKE 'QX-0__'
  AND substr(keycard_code, -1) IN ('1', '3', '5', '7', '9')
  AND access_date = 19890421;


-- Finding:
-- This returned many employees, so the suspect list was too broad.


-- Step 4: Join keycard access logs with Helsinki server access.
SELECT 
    ca.employee_id,
    ca.server_location,
    ca.access_date,
    ca.access_time
FROM computer_access_logs AS ca
INNER JOIN keycard_access_logs AS ka
    ON ca.employee_id = ka.employee_id
WHERE ka.keycard_code LIKE 'QX-0__'
  AND substr(ka.keycard_code, -1) IN ('1', '3', '5', '7', '9')
  AND ka.access_date = 19890421
  AND ca.server_location LIKE '%Helsinki%';


-- Finding:
-- employee_id 99 matched the keycard and Helsinki server clues.


-- Step 5: Review emails connected to employee 99.
SELECT *
FROM email_logs
WHERE sender_employee_id = 99
   OR recipient_employee_id = 99;


-- Finding:
-- employee_id 99 received an alarm-related email from employee_id 263.


-- Step 6: Identify employees 99 and 263.
SELECT *
FROM employee_records
WHERE id IN (99, 263);


-- Finding:
-- employee_id 99 is Elizabeth Gordon.
-- employee_id 263 is Norman Owens.


-- Step 7: Review witness statements for Elizabeth and Norman.
SELECT *
FROM witness_statements
WHERE employee_id IN (99, 263);


-- Finding:
-- Elizabeth said she received an email about the alarm system
-- and went to check it out.
-- Norman had no direct witness statement here.


-- Step 8: Check Norman Owens' keycard access records.
SELECT *
FROM keycard_access_logs
WHERE employee_id = 263;


-- Finding:
-- No records were found.


-- Step 9: Review Norman Owens' email history.
SELECT *
FROM email_logs
WHERE sender_employee_id = 263
   OR recipient_employee_id = 263;


-- Finding:
-- Norman received anonymous instructions:
-- 1. Move "L" into Facility 18 before 9.
-- 2. Trigger a minor alert or routine checkup.
-- 3. Unlock 18 quietly by 9.
-- 4. Another person would use his own credentials shortly after L leaves.
--
-- This suggests Elizabeth was being framed.


-- Step 10: Check Facility 18 access logs on the incident date.
SELECT *
FROM facility_access_logs
WHERE facility_name = 'Facility 18'
  AND access_date = 19890421;


-- Finding:
-- Elizabeth Gordon entered Facility 18 at 08:55.
-- Hristo Bogoev entered Facility 18 at 09:01.
-- This matches the suspicious email plan.


-- Step 11: Identify employee 297.
SELECT *
FROM employee_records
WHERE id = 297;


-- Finding:
-- employee_id 297 is Hristo Bogoev.


-- ============================================================
-- Final Conclusion:
-- The culprit is Hristo Bogoev.
-- ============================================================