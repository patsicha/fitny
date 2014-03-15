<?
	$mysql_host = "fdb4.biz.nf";
	$mysql_database = "1566088_db";
	$mysql_user = "1566088_db";
	$mysql_password = "n!ck3090";

	$objConnect = mysql_connect($mysql_host, $mysql_user, $mysql_password);;

	$objDB = mysql_select_db("1566088_db");
	$strSQL = "SELECT * FROM profile WHERE 1";
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
	
	mysql_close($objConnect);
	
	echo json_encode($resultArray);
?>