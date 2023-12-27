/*<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "attendence";

$con = new mysqli($servername, $username, $password, $dbname);

if ($con->connect_error) {
    die("Connection failed: " . $con->connect_error);
}
//Write the SQL code here (table creation and insertion) which is given below 

$conn->query($sql);

if ($con->query($sql) === TRUE) {
    echo "Data inserted successfully.<br>";
} else {
    echo "Error inserting data: " . $con->error . "<br>";
}
// (a) Write SQL query to count the number of faculties with 'Ph.D' degree and display it
$sql_a = "SELECT COUNT(*) AS phd_faculty_count FROM Faculty WHERE degree = 'Ph.D'";
$result_a = $con->query($sql_a);
$row_a = $result_a->fetch_assoc();
echo "Number of faculties with 'Ph.D' degree: " . $row_a['phd_faculty_count'] . "<br>";

// (b) Write SQL query to list all students of B.Sc. course who have attended at least one class taken by Prof. A. Mandal and display it
$sql_b = "SELECT S.SID, S.Sname, S.course
          FROM Student S
          JOIN Attendance A ON S.SID = A.SID
          JOIN Faculty F ON A.FID = F.FID
          WHERE F.Fname = 'Prof. A. Mandal' AND S.course = 'B.Sc.'";
$result_b = $con->query($sql_b);

if ($result_b->num_rows > 0) {
    echo "<br>List of students of B.Sc. course who have attended at least one class taken by Prof. A. Mandal:<br>";
    while ($row_b = $result_b->fetch_assoc()) {
        echo "Student ID: " . $row_b['SID'] . ", Name: " . $row_b['Sname'] . ", Course: " . $row_b['course'] . "<br>";
    }
} else {
    echo "No matching records found.<br>";
}

$conn->close();
?>*/
---------------------------------------------SQL CODE---------------------------------------------------------------

--Create Faculty table
CREATE TABLE IF NOT EXISTS Faculty (FID INT AUTO_INCREMENT PRIMARY KEY, Fname VARCHAR(50) NOT NULL,
age INT CHECK (age BETWEEN 24 AND 65), degree VARCHAR(25) NOT NULL);


--Create Student table
CREATE TABLE IF NOT EXISTS Student (SID INT PRIMARY KEY,Sname VARCHAR(50) NOT NULL, course VARCHAR(50) NOT NULL,
year INT, phone VARCHAR(10) NOT NULL);


--Create Attendance table
CREATE TABLE IF NOT EXISTS Attendance (FID INT, SID INT, subject VARCHAR(50) NOT NULL, date_of_class DATE NOT NULL, 
number_of_class INT, PRIMARY KEY (FID, SID, subject, date_of_class), FOREIGN KEY (FID) REFERENCES Faculty(FID),
FOREIGN KEY (SID) REFERENCES Student(SID));


--Insert data into Faculty table
INSERT INTO Faculty (Fname, age, degree) VALUES ('Prof. A. Mandal', 40, 'Ph.D'), ('Prof. B. Das', 35, 'M.Tech'),
('Prof. S. Biswas', 43, 'M.Sc'), ('Prof. K. Thakur', 38, 'Ph.D'), ('Prof. A.B. Hajra', 53, 'M.Sc');

--Insert data into Student table
INSERT INTO Student (Sname, course, year, phone) VALUES ('Student1', 'B.Sc.', 2, '1234567890'),
('Student2', 'B.Sc.', 1, '9876543210'), ('Student3', 'B.Tech', 4, '1235557890'),
('Student4', 'M.A.', 2, '1234567770'), ('Student5', 'B.Sc.', 2, '1111567890');

--Insert data into Attendance table
INSERT INTO Attendance (FID, SID, subject, date_of_class, number_of_class) VALUES (1, 1, 'Math', '2023-01-01', 2),
(1, 2, 'Math', '2023-01-01', 2), (2, 3, 'Chemistry', '2023-01-01', 3), (2, 4, 'Chemistry', '2023-01-01', 3),
(3, 1, 'Botany', '2023-01-01', 3), (4, 1, 'Computer Science', '2023-01-01', 3), (4, 2, 'Computer Science', '2023-01-01', 3)
ON DUPLICATE KEY UPDATE number_of_class = VALUES(number_of_class);

-------------------------------------------(a) & (b) solution------------------------------------------------------------

--(a) Write SQL query to count the number of faculties with 'Ph.D' degree and display it:

SELECT COUNT(*) AS phd_faculty_count
FROM Faculty
WHERE degree = 'Ph.D';


--(b) Write SQL query to list all students of B.Sc. course who have attended at least one class taken by Prof. A. Mandal and display it:

SELECT DISTINCT S.SID, S.Sname, S.course
FROM Student S
JOIN Attendance A ON S.SID = A.SID
JOIN Faculty F ON A.FID = F.FID
WHERE F.Fname = 'Prof. A. Mandal' AND S.course = 'B.Sc.';

