<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "book_store";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// (i) SQL Query to list books authored by Mr. Amitava Das
$query1 = "SELECT BookName, Year FROM Books
          INNER JOIN Author ON Books.Aid = Author.Aid
          WHERE Author.AuthorName = 'Mr. Amitava Das'";

$result1 = $conn->query($query1);

if ($result1->num_rows > 0) {
    echo "<h2>Books Authored by Mr. Amitava Das:</h2>";
    while ($row = $result1->fetch_assoc()) {
        echo "Book: " . $row["BookName"] . ", Year: " . $row["Year"] . "<br>";
    }
} else {
    echo "No books found.";
}

// (ii) SQL Query to display years with more than two books published
$query2 = "SELECT Year, COUNT(BookId) AS BookCount FROM Books
           GROUP BY Year HAVING COUNT(BookId) > 2";

$result2 = $conn->query($query2);

if ($result2->num_rows > 0) {
    echo "<h2>Years with More Than Two Books Published:</h2>";
    while ($row = $result2->fetch_assoc()) {
        echo "Year: " . $row["Year"] . ", Number of Books: " . $row["BookCount"] . "<br>";
    }
} else {
    echo "No years found with more than two books published.";
}

// Close connection
$conn->close();
?>
