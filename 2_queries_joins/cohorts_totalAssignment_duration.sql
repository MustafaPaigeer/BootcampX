SELECT SUM(duration) AS total_druation
FROM assignment_submissions 
INNER JOIN students ON students.id = student_id 
INNER JOIN cohorts ON cohorts.id = students.cohort_id 
WHERE cohorts.name = 'FEB12';