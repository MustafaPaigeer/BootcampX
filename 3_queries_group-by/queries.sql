-- Assignment per Day

SELECT day, count(assignments.*) AS total_assignments
FROM assignments
GROUP BY day
ORDER BY day;

-- Busy Days

SELECT day, count(*) as total_assignments 
FROM assignments
GROUP BY day
HAVING count(*) >= 10
ORDER BY day;


 
--Get all cohorts with 18 or more students.

SELECT cohorts.name as cohort_name, count(students.*) as student_count
FROM cohorts
JOIN students ON cohorts.id = cohort_id
GROUP BY cohorts.name
HAVING COUNT(students.*) >= 18
ORDER BY student_count;

--Get the total number of assignment submissions for each cohort.

SELECT cohorts.name as cohort_name, count(assignment_submissions.*) as total_submissions
FROM cohorts
JOIN students ON cohorts.id = cohort_id
JOIN assignment_submissions ON students.id = student_id
GROUP BY cohorts.name
ORDER BY total_submissions DESC


-- Get currently enrolled students' average assignment completion time.

SELECT students.name, AVG(assignment_submissions.duration) as average_assigment_duration
FROM students
JOIN assignment_submissions ON students.id = student_id
WHERE students.end_date IS NULL
GROUP BY students.name
ORDER BY average_assigment_duration DESC


-- Get the students who's average time it takes to complete an assignment is less than the average 
-- estimated time it takes to complete an assignment.

SELECT students.name, AVG(assignment_submissions.duration) as average_assigment_duration, AVG(assignments.duration) as average_estimated_duration
FROM students
JOIN assignment_submissions ON students.id = student_id
JOIN assignments ON assignments.id = assignment_id
WHERE students.end_date IS NULL
GROUP BY students.name
HAVING AVG(assignment_submissions.duration) < AVG(assignments.duration)
ORDER BY average_assigment_duration;