<?php
	require_once("conn.php");	
	
class Online {
	private function getlink() {
		return new Csdb;
	}
	private function link_result($sql_str, $error_str)
	{
		$link = $this->getlink();
		$result = $link->query($sql_str);
		if ($result == false)
			echo $error_str;
		if (is_object($result))
		{
			if($result->num_rows > 0)
			{
				while( $row = $result->fetch_assoc() )
					$array[] = $row;
			}
			return $array;
		}
		return $result;
	}

	public function select_online($uid, $time) {
		$sql = "select * from cs_online where uid=$uid;";
		$result = $this->link_result($sql, "select online error");
		if( count($result) > 0 )
			return "true";
		return "false";
	}

	public function insert_online($uid, $time) {
		echo "insert";
		$sql = "insert into cs_online values($uid, '$time');";
		$this->link_result($sql, "insert online error");
	}

	public function update_online($uid, $time) {
		echo "update";
		$sql = "update cs_online set time='$time' where uid=$uid;";
		$this->link_result($sql, "update online error");
	}
}
?>
