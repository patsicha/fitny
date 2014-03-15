<?php

$mysql_host = "fdb4.biz.nf";
$mysql_database = "1566088_db";
$mysql_user = "1566088_db";
$mysql_password = "n!ck3090";

$link = mysql_connect($mysql_host, $mysql_user, $mysql_password);
if (!$link) {
	die('Could not connect: ' . mysql_error());
}

mysql_select_db("1566088_db");
mysql_query("SET NAMES UTF8");
$strSQL = "SELECT * FROM member WHERE username = '".mysql_real_escape_string($_POST["username"])."'";
$objQuery = mysql_query($strSQL);
$objResult = mysql_fetch_array($objQuery);
$arr = null;
if(!$objResult)
{
	//echo "WRONGUSER";
	$arr["Status"] = "0";
	$arr["Message"] = "WRONGUSER";
}
else
{
	$strSQL = "SELECT * FROM member WHERE username = '".mysql_real_escape_string($_POST["username"])."' 
	and password = '".mysql_real_escape_string($_POST["password"])."'";
	$objQuery = mysql_query($strSQL);
	$objResult = mysql_fetch_array($objQuery);
	if(!$objResult)
	{
		//echo "WRONGPASSWORD";
		$arr["Status"] = "1";
		$arr["Message"] = "WRONGPASSWORD";
	}
	else
	{
		//echo "PASS";
		$arr["MemberID"] = $objResult[0];
		$arr["Status"] = "2";
		$arr["Message"] = "PASS";

		$strSQL = "SELECT * FROM profile WHERE id = '".$objResult[0]."'";
		mysql_query("SET NAMES UTF8");
		$objQuery = mysql_query($strSQL);
		$objResult = mysql_fetch_array($objQuery);

		$arr["name"] = $objResult[1];
		$arr["email"] = $objResult[2];
		$arr["gender"] = $objResult[3];
		$arr["birthday"] = $objResult[4];
		$arr["weight"] = $objResult[5];
		$arr["height"] = $objResult[6];

		$strSQL = "SELECT * FROM calendar WHERE userid = ".$arr["MemberID"];
	mysql_query("SET NAMES UTF8");
	$objQuery = mysql_query($strSQL);
	$intNumField = mysql_num_fields($objQuery);
	$resultArray1 = array();
	while($obResult = mysql_fetch_array($objQuery))
	{
		$arrCol1 = array();
		for($i=0;$i<$intNumField;$i++)
		{
			$arrCol1[mysql_field_name($objQuery,$i)] = $obResult[$i];
		}
		array_push($resultArray1,$arrCol1);
	}

	$arr["Calendar"] = $resultArray1;

	$strSQL = "SELECT * FROM program WHERE userid = ".$arr["MemberID"];
	mysql_query("SET NAMES UTF8");
	$objQuery = mysql_query($strSQL);
	$intNumField = mysql_num_fields($objQuery);
	$resultArray = array();
	while($obResult = mysql_fetch_array($objQuery))
	{
		$arrCol = array();
		for($i=0;$i<$intNumField;$i++)
		{
			$arrCol[mysql_field_name($objQuery,$i)] = $obResult[$i];
		}
		array_push($resultArray,$arrCol);
	}

	$arr["Program"] = $resultArray;

	$strSQL = "SELECT * FROM program_detail WHERE 1";
	mysql_query("SET NAMES UTF8");
	$objQuery = mysql_query($strSQL);
	$intNumField = mysql_num_fields($objQuery);
	$resultArray1 = array();
	while($obResult = mysql_fetch_array($objQuery))
	{
		$arrCol1 = array();
		for($i=0;$i<$intNumField;$i++)
		{
			$arrCol1[mysql_field_name($objQuery,$i)] = $obResult[$i];
		}
		array_push($resultArray1,$arrCol1);
	}

	$arr["ProgramDetail"] = $resultArray1;
	}
}

mysql_close($link);

echo json_encode($arr);
?>