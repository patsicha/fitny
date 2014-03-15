<?
	$mysql_host = "fdb4.biz.nf";
	$mysql_database = "1566088_db";
	$mysql_user = "1566088_db";
	$mysql_password = "n!ck3090";

	$objConnect = mysql_connect($mysql_host, $mysql_user, $mysql_password);

	$pid = mysql_real_escape_string($_POST['pid']);
	
	$objDB = mysql_select_db("1566088_db");

	$strSQL = "SELECT * FROM program_detail WHERE id = ".$pid;
	mysql_query("SET NAMES UTF8");
	$objQuery = mysql_query($strSQL);
	$intNumField = mysql_num_fields($objQuery);
	$resultArray1 = array();
	$arr=null;
	while($obResult = mysql_fetch_array($objQuery))
	{
		$arrCol1 = array();
		for($i=0;$i<$intNumField;$i++)
		{
			$arrCol1[mysql_field_name($objQuery,$i)] = $obResult[$i];
		}
		array_push($resultArray1,$arrCol1);
	}

	$arr["Status"] = "1";
	$arr["program"] = $resultArray1;

	echo json_encode($arr);
?>