SELECT COUNT(assistance_requests.id) as Total_Assistance, teachers.name from assistance_requests
INNER JOIN teachers ON teachers.id = teacher_id
WHERE teachers.name = 'Waylon Boehm'
GROUP BY teachers.name;


-- Total Assistnace Requests for student Elliot Dickinson

SELECT COUNT(assistance_requests.*) as Total_Assistances, students.name from assistance_requests
INNER JOIN students ON students.id = student_id
WHERE students.name = 'Elliot Dickinson'
GROUP BY students.name;



-- All important data about an assistance request.


SELECT teachers.name, students.name,  assignments.name, (completed_at - started_at) as duration from assistance_requests
INNER JOIN students ON students.id = student_id
INNER JOIN teachers ON teachers.id = teacher_id
INNER JOIN assignments ON assignments.id = assignment_id
ORDER BY duration


-- current average time it takes to complete an assistance request


SELECT sum(completed_at - started_at)/count(assistance_requests.*) as Average_Assitance_Request_Duration
FROM assistance_requests

SELECT avg(completed_at - started_at) as average_assistance_request_duration
FROM assistance_requests;

-- Get the average duration of assistance requests for each cohort

SELECT cohorts.name, avg(completed_at - started_at) as Average_Assistance_Time 
FROM cohorts 
JOIN students on cohorts.id = cohort_id
JOIN assistance_requests ON students.id = student_id
GROUP BY cohorts.name;

-- Cohort With Longest Assistances

SELECT cohorts.name, avg(completed_at - started_at) as average_assistance_time
FROM assistance_requests 
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time DESC
LIMIT 1;

-- Average Assistance Request Wait Time

SELECT AVG(started_at - created_at) AS Average_Wait_Time
FROM assistance_requests


-- Total Cohort Assistance Duration

SELECT cohorts.name, SUM(completed_at - started_at) AS total_duration
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_duration;


-- Cohort Average Assistance Duration

SELECT ((SELECT SUM(completed_at - started_at) AS total_duration
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id) / COUNT(DISTINCT students.cohort_id)) as average_total_duration
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id


SELECT avg (total_duration) as average_total_duration
FROM (
  SELECT cohorts.name as cohort, sum(completed_at-started_at) as total_duration
  FROM assistance_requests
  JOIN students ON students.id = student_id
  JOIN cohorts on cohorts.id = cohort_id
  GROUP BY cohorts.name
  ORDER BY total_duration
) as total_durations;


-- Most Confusing Assignments

SELECT assignments.id, assignments.name, assignments.day, assignments.chapter, count(assignment_id) AS total_requests
FROM assignments
JOIN assistance_requests ON assignments.id = assignment_id
GROUP BY assignments.id
ORDER BY total_requests DESC



SELECT assignments.id, name, day, chapter, count(assistance_requests) as total_requests
FROM assignments
JOIN assistance_requests ON assignments.id = assignment_id
GROUP BY assignments.id
ORDER BY total_requests DESC;


-- Total Assignments and duration

SELECT day, count(assignments.id) AS number_of_assignments, sum(duration) AS duration
FROM assignments
GROUP BY day
ORDER BY day

-- Name of Teachers That Assisted

SELECT DISTINCT(teachers.name) as teacher, cohorts.name as cohort
FROM teachers
JOIN assistance_requests ON teachers.id = teacher_id
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
WHERE cohorts.name = 'JUL02'
ORDER BY teachers.name

-- Name of Teachers and Number of Assistances

SELECT DISTINCT teachers.name as teacher, cohorts.name as cohort, count(assistance_requests.teacher_id) as Total_Assistance
FROM teachers
JOIN assistance_requests ON teachers.id = teacher_id
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY Total_Assistance DESC
