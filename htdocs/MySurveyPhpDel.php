<html>
<head><title>Survey Result</title></head>
<body>
<h2>The Result of the Survey</h2>


<?php
error_reporting(0);

$con_id = mysql_connect("localhost","usr_2014_97","52042012q");
if (!$con_id)
  {
  die('Could not connect: ' . mysql_error());
  }
mysql_select_db("db_2014_97", $con_id);
$item = mysql_query("SELECT * FROM guest");

echo "<form action = \"./MySurveyPhpDel.php\" method = \"post\">";
echo "<table border=\"2\">";
echo "<tr>";
echo "<th>" . "Guest_ID" . "</th>";
echo "<th>" . "Guest_Name" . "</th>";
echo "<th>" . "Age" . "</th>";
echo "<th>" . "Gender" . "</th>";
echo "<th>" . "E_mail" . "</th>";
echo "<th>" . "OP" . "</th>";
echo "</tr>";
while($row = mysql_fetch_array($item))
{
	$pa1=$row['Guest_ID'];
	$str = (string)$pa1;
if($_POST[$str] != "U")
{
	$pa2=$row['Guest_Name'];
	$pa3=$row['Age'];
	$pa4=$row['Gender'];
	$pa5=$row['E_mail'];
	echo  "<tr>";
	echo  "<td>" . $pa1 . "</td>";
	echo  "<td>" . $pa2 . "</td>";
	echo  "<td>" . $pa3 . "</td>";
	echo  "<td>" . $pa4 . "</td>";
	echo  "<td>" . $pa5 . "</td>";
	echo  "<td>" . "<input type=\"checkbox\" name=\"$str\" value=\"U\">" . "</td>";
	echo  "</tr>";
}else
mysql_query("DELETE FROM guest WHERE Guest_ID =$str");
}
echo "</table>";
echo "<input type=\"submit\" value=\"Delete\">";
echo "</form>";
mysql_close($con_id); 
?>
</body>
</html>
