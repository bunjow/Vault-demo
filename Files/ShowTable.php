<?php include "../inc/dbinfo.inc"; ?>
<html>
<body>
<h1>Employees table from database</h1>
<?php
$con  = mysqli_connect(DB_SERVER,DB_USERNAME,DB_PASSWORD,DB_DATABASE);
// Check connection
if (mysqli_connect_errno())
{
echo '<span style="color:red;text-align:center;">Failed to connect to MySQL: </span>' . mysqli_connect_error();
}

$result = mysqli_query($con,"select * from employees");

echo "<table border='1'>
<tr>
<th>Name</th>
<th>Address</th>
</tr>";

while($row = mysqli_fetch_array($result))
{
echo "<tr>";
echo "<td>" . $row['name'] . "</td>";
echo "<td>" . $row['address'] . "</td>";
echo "</tr>";
}
echo "</table>";

mysqli_close($con);

$password=DB_PASSWORD;
echo "<br>";
//echo  "Using DB_PASSWORD ==>  $password \n";
?>
