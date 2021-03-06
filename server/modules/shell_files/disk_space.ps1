$items = New-Object System.Collections.ArrayList
foreach($obj in get-WmiObject win32_logicaldisk)
{
	[void] $items.Add(@{
	"file_system" = $obj.DeviceId;
	"size" = [System.Math]::Round($obj.Size/1GB,2);
	"avail" = [System.Math]::Round($obj.FreeSpace/1GB,2);
	"used" = [System.Math]::Round(($obj.Size-$obj.FreeSpace)/1GB,2);
	"mounted" = $obj.DeviceId;
	"used%" = [System.Math]::Round(100*(($obj.Size-$obj.FreeSpace)/($obj.Size+1)),2);
	})
}

$items | ConvertTo-Json