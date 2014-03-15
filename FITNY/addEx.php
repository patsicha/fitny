<?
	$mysql_host = "fdb4.biz.nf";
	$mysql_database = "1566088_db";
	$mysql_user = "1566088_db";
	$mysql_password = "n!ck3090";

	$objConnect = mysql_connect($mysql_host, $mysql_user, $mysql_password);

	$pid = mysql_real_escape_string($_POST['pid']);
	$exid = mysql_real_escape_string($_POST['exid']);
	$userid = mysql_real_escape_string($_POST['userid']);
	$exAmount = mysql_real_escape_string($_POST['exAmount']);
	
	$objDB = mysql_select_db("1566088_db");
	$strSQL="INSERT INTO `program_detail`(`id`, `exerciseID`, `amount`) VALUES (".$pid.",'".$exid."','".$exAmount."')";
	mysql_query("SET NAMES UTF8");
	$objQuery = mysql_query($strSQL);



	$arr=null;

$strSQL = "SELECT * FROM calendar WHERE userid = ".$userid;
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

	$strSQL = "SELECT * FROM program WHERE userid = ".$userid;
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
	$arr["Status"] = "11";

	echo json_encode($arr);
?>