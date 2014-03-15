<?
	$mysql_host = "fdb4.biz.nf";
	$mysql_database = "1566088_db";
	$mysql_user = "1566088_db";
	$mysql_password = "n!ck3090";

	$objConnect = mysql_connect($mysql_host, $mysql_user, $mysql_password);

	$username = mysql_real_escape_string($_POST['username']);
	$password = mysql_real_escape_string($_POST['password']);

	$name = mysql_real_escape_string($_POST['name']);
	$email = mysql_real_escape_string($_POST['email']);
	$gender = mysql_real_escape_string($_POST['gender']);
	$birthday = mysql_real_escape_string($_POST['birthday']);
	$weight = mysql_real_escape_string($_POST['weight']);
	$height = mysql_real_escape_string($_POST['height']);

	$objDB = mysql_select_db("1566088_db");

	$strSQL = "INSERT INTO  `profile` (
`name` ,
`email` ,
`gender` ,
`birthday` ,
`weight` ,
`height`
)
VALUES (
'".$name."',  '".$email."',  '".$gender."',  '".$birthday."',  '".$weight."',  '".$height."'
)";
	mysql_query("SET NAMES UTF8");
	$objQuery = mysql_query($strSQL);

		$strSQL = "INSERT INTO  `member` (
`username` ,
`password`
)
VALUES (
'".$username."',  '".$password."'
)";
	mysql_query("SET NAMES UTF8");
	$objQuery = mysql_query($strSQL);

	$arr = null;
	if(!$objQuery)
	{
		$arr["Status"] = "0";
		$arr["Message"] = "Insert Data Failed";
	}
	else
	{
		$arr["Status"] = "1";
		$arr["Message"] = "Insert Data Successfully";
	}
	
	echo json_encode($arr);

?>