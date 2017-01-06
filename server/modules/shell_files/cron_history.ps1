Try
{
	$schedule = new-object -com("Schedule.Service")
	$schedule.connect() 
	$tasks = $schedule.getfolder("\").gettasks(0)
	$items = New-Object System.Collections.ArrayList
	foreach($obj in $tasks)
	{
		Write-Host($obj)
		[void] $items.Add(@{
			"time" = $obj.LastRunTime;
			"user" = "";
			"message" = $obj.Name;
			"data" = $obj.Xml;
		})
	}
	$items | ConvertTo-Json
}
Catch
{
	$items = New-Object System.Collections.ArrayList
	$items | ConvertTo-Json
}