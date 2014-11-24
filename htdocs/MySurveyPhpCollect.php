<html>
<head><title>Thanks for achieve the survey</title></head>
<body>

<?php



//rguest_name = $_POST['thename'];
error_reporting(E_ALL ^ E_DEPRECATED);
//$guest_age = $_POST['age'];
//$guest_email = $_POST['email'];
//$guest_gender = $_POST['gender'];
//$_GET for the variables with "get" method; $_POST for the "post" method;
//$_REQUEST for both plus cookies ($_REQUEST=$_GET+$_POST+$_COOKIE).

//echo("<h2>$output</h2> <br />");
$db = mysql_connect("localhost", "usr_2014_97", "52042012q");
if (!$db) 
	{
           print "Error - Could not connect to MySQL";
           exit;
        }

mysql_select_db("db_2014_97", $db);

$sql_into ="INSERT INTO guest (Guest_Name, Age, Gender, E_mail)
VALUES
('$_POST[thename]',
'$_POST[age]',
'$_POST[gender]',
'$_POST[email]')";

if (!mysql_query($sql_into,$db))
  {
  die('Error: ' . mysql_error());
  }
echo "1 record added";

?>
</body></html>
