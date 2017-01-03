Try 
{
	$obj = Get-WmiObject win32_processor
	$obj.LoadPercentage
}
Catch
{
	Write-Host(0)
}