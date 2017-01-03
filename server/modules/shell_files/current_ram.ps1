Try
{
	$obj = Get-WmiObject win32_OperatingSystem
	$items = @{
		"total" = [System.Math]::Round($obj.totalvisiblememorysize/1KB,2);
		"used" = [System.Math]::Round($obj.totalvisiblememorysize/1KB - $obj.freephysicalmemory/1KB,2);
		"free" = [System.Math]::Round($obj.freephysicalmemory/1KB,2);
		}

	$items | ConvertTo-Json
}
Catch
{
	$items = @{
		"total" = 1;
		"used" = 1;
		"free" = 1;
		}
	$items | ConvertTo-Json
}