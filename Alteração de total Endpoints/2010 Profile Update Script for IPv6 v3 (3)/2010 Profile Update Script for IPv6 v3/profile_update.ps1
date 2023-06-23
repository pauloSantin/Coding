$PATH = $PSScriptRoot
$PasswordFile_Gap = "$PATH\misc\gap.txt"
$PasswordFile_GW = "$PATH\misc\gw.txt"
$KeyFile_Gap = "$PATH\misc\gap.key"
$KeyFile_GW = "$PATH\misc\gw.key"
$key_Gap = Get-Content $KeyFile_Gap
$key_GW = Get-Content $KeyFile_GW
$encrypted_Gap = Get-Content $PasswordFile_Gap | ConvertTo-SecureString -Key $key_Gap
$encrypted_GW = Get-Content $PasswordFile_GW | ConvertTo-SecureString -Key $key_GW
$bstr_Gap = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($encrypted_Gap)
$bstr_GW = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($encrypted_GW)
$password_Gap = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr_Gap)
$password_GW = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr_GW)
$reg_line_check = "\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}"
$counter = 0
$isbatch = '0'

If(!(test-path "$PATH\logs\"))
{
	New-Item -ItemType Directory -Force -Path "$PATH\logs\" | Out-Null
}
If(!(test-path "$PATH\logs\Gap\"))
{
	New-Item -ItemType Directory -Force -Path "$PATH\logs\Gap\" | Out-Null
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
	Write-Host("ip.txt file not found. Please confirm ip.txt file exists in same folder.")

}
else
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

echo y | & "$($PATH).\plink.exe" -agent -no-antispoof -pw $password_GW far@$hostip "exit"
	if ((echo y | . "$($PATH).\plink.exe" -batch -ssh -no-antispoof -t far@$hostip -pw $password_GW "exit" 2>&1 ) -match '^Access.*denied')
	{
	Write-Host("Updating far_comm_profile.txt for Gap Collector")
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo cp /opt/iprf/activity_files/far_comm_profile.txt /opt/iprf/activity_files/far_comm_profile.txt.bk" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*SF_LINK#2  = slot:20691.*$/d' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*TimeSyncDelay.*$/d' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i 's/Release Date:.*$/Release Date: 2019\/02\/05        Version: P15Z/' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i 's/Max Network Size.*$/Max Network Size: 2010 nodes/' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i 's/Beacon Reserved Bandwidth.*$/Beacon Reserved Bandwidth: 9.1%/' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i 's/Beacon Interval on device.*$/Beacon Interval on device: 277.75 seconds/' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i 's/Beacon Interval on TR.*$/Beacon Interval on TR: about 90 seconds/' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*\[RPL\]/,/.*TRICKLE_INTERVAL_MIN.*$/{s/^.*TRICKLE_INTERVAL_MIN.*$/    TRICKLE_INTERVAL_MIN  = 14/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*\[RPL\]/,/.*TRICKLE_INTERVAL_DOUBLINGS.*$/{s/^.*TRICKLE_INTERVAL_DOUBLINGS.*$/    TRICKLE_INTERVAL_DOUBLINGS  = 8/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*\[RPL\]/,/.*DEF_ROUTE_LIFETIME.*$/{s/^.*DEF_ROUTE_LIFETIME.*$/    DEF_ROUTE_LIFETIME  = 24/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*MaxDevicesNormal.*$/{s/^.*MaxDevicesNormal.*$/    MaxDevicesNormal     = 2010/;}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*MaxDevicesExtra.*$/{s/^.*MaxDevicesExtra.*$/    MaxDevicesExtra              = 2010/;}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*REG_EXT_TR/,/.*AdvLevelMin.*$/{s/^.*AdvLevelMin.*$/    AdvLevelMin  = 6/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*REG_EXT_NODE/,/.*AdvLevelMin.*$/{s/^.*AdvLevelMin.*$/    AdvLevelMin  = 6/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*REG_EXT_NODE/,/.*AdvLevelMax.*$/{s/^.*AdvLevelMax.*$/    AdvLevelMax  = 15/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*AddrReserved.*$/{s/^.*AddrReserved.*$/    AddrReserved  = 673, 1346/;}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null	
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*REG_SLOTFRAME_TR#2/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE         = 11/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null	
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*REG_SLOTFRAME_TR#3/,/.*SF_LINK#1.*$/{s/^.*SF_LINK#1.*$/    SF_LINK#1  = slot:7403; ch_off:0; opt:A______T;     # TR extra adv links/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*REG_SLOTFRAME_TR#3/,/.*SF_LINK#2.*$/{s/^.*SF_LINK#2.*$/    SF_LINK#2  = slot:14806; ch_off:0; opt:A______T;     # TR extra adv links/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null	
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*REG_SLOTFRAME_TR#3/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 22110/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*ADV_SLOTFRAME_TR#2/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 11/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null	
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*REG_SLOTFRAME_NODE/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 22110/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i '/^.*ADV_SLOTFRAME_NODE#2/,/.*SF_SIZE.*$/{s/^.*SF_SIZE.*$/    SF_SIZE  = 11/}' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo sed -i 's/b:23/b:11/' /opt/iprf/activity_files/far_comm_profile.txt" | out-null
	$CURRENTDATE = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
	$CUID = & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sed -n '/CUID/p' /opt/iprf/profile/config.ini | grep -o '.\{14\}$'" 
	$NewLine = "{0},{1},{2},{3}" -f $CURRENTDATE, $CUID, "Gap Collector","COMPLETED"
	$NewLine | add-content -path "$PATH\logs\log.csv"
	$DetailedCapture = & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "cat /opt/iprf/activity_files/far_comm_profile.txt" 
	$DetailedCapture | Add-Content -path "$PATH\logs\Gap\$CUID.txt"
	Write-Host ("Completed!")
	Write-Host ("Restarting Application to apply changes. Please wait 5 minutes for restart to be completed.")
	(echo $password_Gap | & "$($PATH).\plink.exe" -no-antispoof -batch -t far@$hostip -pw $password_Gap "sudo reboot") | out-null
	}

	else
	{
	Write-Host("Updating far_comm_profile.txt for Network Gateway")
	(echo y | & "$($PATH).\plink.exe" -no-antispoof far@$hostip -pw $password_GW "
	sudo cp /opt/iprf/activity_files/far_comm_profile.txt /opt/iprf/activity_files/far_comm_profile.txt.bk;
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
	"
	)
	$CURRENTDATE = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
	$CUID = echo y | & "$($PATH).\plink.exe" -no-antispoof far@$hostip -pw $password_GW "sudo sed -n '/CUID/p' /opt/iprf/profile/config.ini | grep -o '.\{14\}$'"
	$NewLine = "{0},{1},{2},{3}" -f $CURRENTDATE, $CUID, "Gateway","COMPLETED"
	$NewLine | add-content -path "$PATH\logs\log.csv"
	$DetailedCapture = echo y | & "$($PATH).\plink.exe" -no-antispoof far@$hostip -pw $password_GW "sudo cat /opt/iprf/activity_files/far_comm_profile.txt"
	$DetailedCapture | Add-Content -path "$PATH\logs\GW\$CUID.txt"
	Write-Host ("Completed!")
	Write-Host ("Restarting Application to apply changes. Please wait 5 minutes for restart to be completed.")
	(echo y | & "$($PATH).\plink.exe" -no-antispoof far@$hostip -pw $password_GW "sudo bash /opt/iprf/firmware/start.sh > /dev/null &") | out-null
	}
	
}


    

}
}