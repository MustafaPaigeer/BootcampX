SELECT SUM(duration) AS total_druation 
FROM assignment_submissions 
INNER JOIN students ON assignment_submissions.student_id = students.id 
WHERE students.name = 'Ibrahim Schimmel';