Try
{
	$items = New-Object System.Collections.ArrayList
	foreach($obj in Get-WMIObject  Win32_Process  | Sort-Object WS -desc | Select-Object -first 10)
	{
		[void] $items.Add(@{
			"pid" = $obj.ProcessId;
			"user" = "Admin";
			"cpu%" = $obj.CPUPercent;
			"rss"= 0;
			"vsz"= 0;
			"cmd"= $obj.ProcessName;
		})
	}
	$items | ConvertTo-Json
}
Catch
{
	$items = New-Object System.Collections.ArrayList
	$items | ConvertTo-Json
}