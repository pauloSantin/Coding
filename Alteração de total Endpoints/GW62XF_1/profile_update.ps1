$PATH = $PSScriptRoot
$PasswordFile_GW = "$PATH\misc\gw.txt"
$KeyFile_GW = "$PATH\misc\gw.key"
$key_GW = Get-Content $KeyFile_GW
$encrypted_GW = Get-Content $PasswordFile_GW | ConvertTo-SecureString -Key $key_GW
$bstr_GW = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($encrypted_GW)
$password_GW = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr_GW)
$reg_line_check = "\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}"
$counter = 0
$isbatch = '0'

If(!(test-path "$PATH\logs\"))
{
	New-Item -ItemType Directory -Force -Path "$PATH\logs\" | Out-Null
}
If(!(test-path "$PATH\logs\GW\"))
{
	New-Item -ItemType Directory -Force -Path "$PATH\logs\GW\" | Out-Null
}
if (!(Test-Path "$PATH\logs\log.csv"))
{
	'' | select 'DATE', 'CUID', 'HARDWARE', 'RESULT' | Export-Csv "$PATH\logs\log.csv" -NoTypeInformation
}
if (!(Test-Path "$PATH\logs\batch_result.csv"))
{
	'' | select 'DATE', 'Line Number', 'IP Address','Is Executed?' | Export-Csv "$PATH\logs\batch_result.csv" -NoTypeInformation
}



if (!(Test-Path "$PATH\ip.txt"))
{
	Write-Host("Could not find ip.txt. Not executing batch script.")
	$isbatch = '0'
}
else
{
	Write-Host("Found ip.txt")
	$response = Read-Host -Prompt 'Do you want to run batch? (yes or no)'
	if ($response.ToLower() -eq 'yes')
	{
	$isbatch = '1'
	}
	elseif ($response.ToLower() -eq 'no')
	{
	$isbatch = '0'
	}
	else
	{
	$isbatch = '2'
	}
}

if ($isbatch -eq '0')
{
$hostip = Read-Host -Prompt 'Enter IP address of GW'
$port = 22
$tcpobject = new-Object system.Net.Sockets.TcpClient 
#Connect to remote machine's port               
$connect = $tcpobject.BeginConnect($hostip,$port,$null,$null) 
#Configure a timeout before quitting - time in milliseconds 
$wait = $connect.AsyncWaitHandle.WaitOne(20000,$false) 
If (-Not $Wait) {
    $connectiontest = $False
} Else {
    $error.clear()
    $tcpobject.EndConnect($connect) | out-Null 
    If ($Error[0]) {
        Write-warning ("{0}" -f $error[0].Exception.Message)
    } Else {
        $connectiontest = $True
    }
}
if ($connectiontest)
{
Write-Host ("Connection Confirmed")

echo y | & "$($PATH).\plink.exe" -agent -no-antispoof -pw $password_GW root@$hostip "exit"

	Write-Host("Updating far_comm_profile.txt for Network Gateway")
	(echo y | & "$($PATH).\plink.exe" -no-antispoof root@$hostip -pw $password_GW "
	sudo cp /opt/iprf/activity_files/far_comm_profile.txt /opt/iprf/activity_files/far_comm_profile.txt.bk;
	sudo sed -i '/^.*LoadIndicatorMethod.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TrafficPacketsPerDay.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TrafficEvaluationPeriod.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*LOADINDICATORMETHOD.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TRAFFICPACKETSPERDAY.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TRAFFICEVALUATIONPERIOD.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;

	sudo sed -i '/^.*SF_LINK_2  = slot:20691.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TimeSyncDelay.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/Release Date:.*$/Release Date: 2019\/02\/05        Version: P15Z/' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/Max Network Size.*$/Max Network Size: 2010 nodes/' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/Beacon Reserved Bandwidth.*$/Beacon Reserved Bandwidth: 9.1%/' /opt/iprf/activity_files/far_comm_profile.txt
	sudo sed -i 's/Beacon Interval on device.*$/Beacon Interval on device: 277.75 seconds/' /opt/iprf/activity_files/far_comm_profile.txt
	sudo sed -i 's/Beacon Interval on TR.*$/Beacon Interval on TR: about 90 seconds/' /opt/iprf/activity_files/far_comm_profile.txt
	sudo sed -i '/^.*\[RPL\]/,/.*TRICKLE_INTERVAL_MIN.*$/{s/^.*TRICKLE_INTERVAL_MIN.*$/TRICKLE_INTERVAL_MIN        = 14/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*\[RPL\]/,/.*TRICKLE_INTERVAL_DOUBLINGS.*$/{s/^.*TRICKLE_INTERVAL_DOUBLINGS.*$/TRICKLE_INTERVAL_DOUBLINGS  = 8/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*\[RPL\]/,/.*DEF_ROUTE_LIFETIME.*$/{s/^.*DEF_ROUTE_LIFETIME.*$/DEF_ROUTE_LIFETIME          = 24/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*MaxDevicesNormal.*$/{s/^.*MaxDevicesNormal.*$/MaxDevicesNormal            = 2010/;}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*MaxDevicesExtra.*$/{s/^.*MaxDevicesExtra.*$/MaxDevicesExtra             = 2010/;}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_EXT_TR/,/.*AdvLevelMin.*$/{s/^.*AdvLevelMin.*$/AdvLevelMin                 = 6/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_EXT_NODE/,/.*AdvLevelMin.*$/{s/^.*AdvLevelMin.*$/AdvLevelMin                 = 6/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_EXT_NODE/,/.*AdvLevelMax.*$/{s/^.*AdvLevelMax.*$/AdvLevelMax                 = 15/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*AddrReserved.*$/{s/^.*AddrReserved.*$/AddrReserved                = 673, 1346/;}' /opt/iprf/activity_files/far_comm_profile.txt;	
	sudo sed -i '/^.*REG_SLOTFRAME_TR_2/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE         = 11/}' /opt/iprf/activity_files/far_comm_profile.txt
	sudo sed -i '/^.*REG_SLOTFRAME_TR_3/,/.*SF_LINK_1.*$/{s/^.*SF_LINK_1.*$/SF_LINK_1                   = slot:7403; ch_off:0; opt:A______T;        # TR extra adv links/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_SLOTFRAME_TR_3/,/.*SF_LINK_2.*$/{s/^.*SF_LINK_2.*$/SF_LINK_2                   = slot:14806; ch_off:0; opt:A______T;        # TR extra adv links/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_SLOTFRAME_TR_3/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/SF_SIZE                     = 22110/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*ADV_SLOTFRAME_TR_2/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 11/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_SLOTFRAME_NODE_1/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 22110/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*ADV_SLOTFRAME_NODE_2/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 11/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/b:23/b:11/' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/MaxBetweenTriesSec.*$/MaxBetweenTriesSec          = 2000\n    LoadIndicatorMethod         = NODE_COUNT\n    TrafficPacketsPerDay        = 86400\n    TrafficEvaluationPeriod     = 3600/' /opt/iprf/activity_files/far_comm_profile.txt;
	"
	)
	$CURRENTDATE = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
	$CUID = echo y | & "$($PATH).\plink.exe" -no-antispoof root@$hostip -pw $password_GW "sudo sed -n '/CUID/p' /opt/iprf/profile/config.ini | grep -o '.\{14\}$'"
	$NewLine = "{0},{1},{2},{3}" -f $CURRENTDATE, $CUID, "Gateway","COMPLETED"
	$NewLine | add-content -path "$PATH\logs\log.csv"
	$DetailedCapture = echo y | & "$($PATH).\plink.exe" -no-antispoof root@$hostip -pw $password_GW "sudo cat /opt/iprf/activity_files/far_comm_profile.txt"
	$DetailedCapture | Add-Content -path "$PATH\logs\GW\$CUID.txt"
	Write-Host ("Completed!")
	Write-Host ("Restarting Application to apply changes. Please wait 5 minutes for restart to be completed.")
	(echo y | & "$($PATH).\plink.exe" -no-antispoof root@$hostip -pw $password_GW "sudo bash /opt/iprf/firmware/start.sh > /dev/null &") | out-null
	

}
else
{
$CURRENTDATE = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
$NewLine = "{0},{1},{2},{3}" -f $CURRENTDATE, $hostip, "Unknown","FAILED"
$NewLine | add-content -path "$PATH\logs\log.csv"
Write-Host ("GW Collector cannot be reached by IPv4 address. Confirm Power on the unit and ensure SSH is enabled.")
}
}
elseif ($isbatch -eq '1')
{
foreach($line in Get-Content "$($PATH)\ip.txt") 
{
	$counter = $counter + 1
    if($line -match $reg_line_check)
	{
$CURRENTDATE = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
$NewLine = "{0},{1},{2},{3}" -f $CURRENTDATE, $counter, $line, "Yes"
$NewLine | add-content -path "$PATH\logs\batch_result.csv"    
Write-Host ("")    
Write-Host ("Executing Script for line number $counter, IP address $line")
$hostip = $line
$port = 22
$tcpobject = new-Object system.Net.Sockets.TcpClient 
#Connect to remote machine's port               
$connect = $tcpobject.BeginConnect($hostip,$port,$null,$null) 
#Configure a timeout before quitting - time in milliseconds 
$wait = $connect.AsyncWaitHandle.WaitOne(20000,$false) 
If (-Not $Wait) {
    $connectiontest = $False
} Else {
    $error.clear()
    $tcpobject.EndConnect($connect) | out-Null 
    If ($Error[0]) {
        Write-warning ("{0}" -f $error[0].Exception.Message)
    } Else {
        $connectiontest = $True
    }
}
if ($connectiontest)
{
Write-Host ("Connection Confirmed")

echo y | & "$($PATH).\plink.exe" -agent -no-antispoof -pw $password_GW root@$hostip "exit"

	
	Write-Host("Updating far_comm_profile.txt for Network Gateway")
	(echo y | & "$($PATH).\plink.exe" -no-antispoof root@$hostip -pw $password_GW "
	sudo cp /opt/iprf/activity_files/far_comm_profile.txt /opt/iprf/activity_files/far_comm_profile.txt.bk;
	sudo sed -i '/^.*LoadIndicatorMethod.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TrafficPacketsPerDay.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TrafficEvaluationPeriod.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*LOADINDICATORMETHOD.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TRAFFICPACKETSPERDAY.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TRAFFICEVALUATIONPERIOD.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;

	sudo sed -i '/^.*SF_LINK_2  = slot:20691.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*TimeSyncDelay.*$/d' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/Release Date:.*$/Release Date: 2019\/02\/05        Version: P15Z/' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/Max Network Size.*$/Max Network Size: 2010 nodes/' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/Beacon Reserved Bandwidth.*$/Beacon Reserved Bandwidth: 9.1%/' /opt/iprf/activity_files/far_comm_profile.txt
	sudo sed -i 's/Beacon Interval on device.*$/Beacon Interval on device: 277.75 seconds/' /opt/iprf/activity_files/far_comm_profile.txt
	sudo sed -i 's/Beacon Interval on TR.*$/Beacon Interval on TR: about 90 seconds/' /opt/iprf/activity_files/far_comm_profile.txt
	sudo sed -i '/^.*\[RPL\]/,/.*TRICKLE_INTERVAL_MIN.*$/{s/^.*TRICKLE_INTERVAL_MIN.*$/TRICKLE_INTERVAL_MIN        = 14/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*\[RPL\]/,/.*TRICKLE_INTERVAL_DOUBLINGS.*$/{s/^.*TRICKLE_INTERVAL_DOUBLINGS.*$/TRICKLE_INTERVAL_DOUBLINGS  = 8/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*\[RPL\]/,/.*DEF_ROUTE_LIFETIME.*$/{s/^.*DEF_ROUTE_LIFETIME.*$/DEF_ROUTE_LIFETIME          = 24/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*MaxDevicesNormal.*$/{s/^.*MaxDevicesNormal.*$/MaxDevicesNormal            = 2010/;}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*MaxDevicesExtra.*$/{s/^.*MaxDevicesExtra.*$/MaxDevicesExtra             = 2010/;}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_EXT_TR/,/.*AdvLevelMin.*$/{s/^.*AdvLevelMin.*$/AdvLevelMin                 = 6/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_EXT_NODE/,/.*AdvLevelMin.*$/{s/^.*AdvLevelMin.*$/AdvLevelMin                 = 6/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_EXT_NODE/,/.*AdvLevelMax.*$/{s/^.*AdvLevelMax.*$/AdvLevelMax                 = 15/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*AddrReserved.*$/{s/^.*AddrReserved.*$/AddrReserved                = 673, 1346/;}' /opt/iprf/activity_files/far_comm_profile.txt;	
	sudo sed -i '/^.*REG_SLOTFRAME_TR_2/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE         = 11/}' /opt/iprf/activity_files/far_comm_profile.txt
	sudo sed -i '/^.*REG_SLOTFRAME_TR_3/,/.*SF_LINK_1.*$/{s/^.*SF_LINK_1.*$/SF_LINK_1                   = slot:7403; ch_off:0; opt:A______T;        # TR extra adv links/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_SLOTFRAME_TR_3/,/.*SF_LINK_2.*$/{s/^.*SF_LINK_2.*$/SF_LINK_2                   = slot:14806; ch_off:0; opt:A______T;        # TR extra adv links/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_SLOTFRAME_TR_3/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/SF_SIZE                     = 22110/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*ADV_SLOTFRAME_TR_2/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 11/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*REG_SLOTFRAME_NODE_1/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 22110/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i '/^.*ADV_SLOTFRAME_NODE_2/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 11/}' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/b:23/b:11/' /opt/iprf/activity_files/far_comm_profile.txt;
	sudo sed -i 's/MaxBetweenTriesSec.*$/MaxBetweenTriesSec          = 2000\n    LoadIndicatorMethod         = NODE_COUNT\n    TrafficPacketsPerDay        = 86400\n    TrafficEvaluationPeriod     = 3600/' /opt/iprf/activity_files/far_comm_profile.txt;
	"
	)
	$CURRENTDATE = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
	$CUID = echo y | & "$($PATH).\plink.exe" -no-antispoof root@$hostip -pw $password_GW "sudo sed -n '/CUID/p' /opt/iprf/profile/config.ini | grep -o '.\{14\}$'"
	$NewLine = "{0},{1},{2},{3}" -f $CURRENTDATE, $CUID, "Gateway","COMPLETED"
	$NewLine | add-content -path "$PATH\logs\log.csv"
	$DetailedCapture = echo y | & "$($PATH).\plink.exe" -no-antispoof root@$hostip -pw $password_GW "sudo cat /opt/iprf/activity_files/far_comm_profile.txt"
	$DetailedCapture | Add-Content -path "$PATH\logs\GW\$CUID.txt"
	Write-Host ("Completed!")
	Write-Host ("Restarting Application to apply changes. Please wait 5 minutes for restart to be completed.")
	(echo y | & "$($PATH).\plink.exe" -no-antispoof root@$hostip -pw $password_GW "sudo bash /opt/iprf/firmware/start.sh > /dev/null &") | out-null
	

	
}
else
{
Write-Host ("GW Collector cannot be reached by IPv4 address. Confirm Power on the unit and ensure SSH is enabled.")
}

    }
	else
	{
		
		$CURRENTDATE = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
		$NewLine = "{0},{1},{2},{3}" -f $CURRENTDATE, $counter, $line, "No"
		$NewLine | add-content -path "$PATH\logs\batch_result.csv" 
		Write-Host ("")
		Write-Host ("Script could not execute $line in line number $counter due to wrong format")
	}
}
}
else 
{
#test
Write-Host ("Please re-run the script enter your response as yes or no.")
}