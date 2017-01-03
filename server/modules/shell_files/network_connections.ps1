Function Get-ActiveTCPConnections {            
[cmdletbinding()]            
param(            
)            
            
try {            
    $TCPProperties = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()            
    $Connections = $TCPProperties.GetActiveTcpConnections()            
    foreach($Connection in $Connections) {            
        if($Connection.LocalEndPoint.AddressFamily -eq "InterNetwork" ) { $IPType = "IPv4" } else { $IPType = "IPv6" }            
        $OutputObj = New-Object -TypeName PSobject            
        $OutputObj | Add-Member -MemberType NoteProperty -Name "LocalAddress" -Value $Connection.LocalEndPoint.Address            
        $OutputObj | Add-Member -MemberType NoteProperty -Name "LocalPort" -Value $Connection.LocalEndPoint.Port            
        $OutputObj | Add-Member -MemberType NoteProperty -Name "RemoteAddress" -Value $Connection.RemoteEndPoint.Address            
        $OutputObj | Add-Member -MemberType NoteProperty -Name "RemotePort" -Value $Connection.RemoteEndPoint.Port            
        $OutputObj | Add-Member -MemberType NoteProperty -Name "State" -Value $Connection.State            
        $OutputObj | Add-Member -MemberType NoteProperty -Name "IPV4Or6" -Value $IPType            
        $OutputObj            
    }            
            
} catch {            
    Write-Error "Failed to get active connections. $_"            
}           
}



Function Get-NetworkConnections {            
[cmdletbinding()]            
param(            
)            
            
try {            
    $Connections = Get-ActiveTCPConnections
    foreach($Connection in $Connections) {
        $OutputObj = New-Object -TypeName PSobject
        $OutputObj | Add-Member -MemberType NoteProperty -Name "connections" -Value 1
        $OutputObj | Add-Member -MemberType NoteProperty -Name "address" -Value "$($Connection.RemoteAddress):$($Connection.RemotePort)"
        $OutputObj
    }            
            
} catch {            
    Write-Error "Failed to get active connections. $_"            
}           
}


Get-NetworkConnections | ConvertTo-Json