$computers = @(
    '8.8.8.8'
    '10.0.0.1'
    '1.1.1.1'
)

 # 1 minute
 $limit_in_minutes = 2

 $start_timer = Get-Date
 Do {
    #para o loop
    Start-Sleep -Seconds 60
    $current_time = Get-Date

    $TimeStampFormat = 'yyyyMMdd HH:mm:ss'
    $TimeStamp = [datetime]::Now.ToString($TimeStampFormat)

        foreach ($computer in $computers) {
        $pingComputer = Test-Connection $computer -Count 1 -Quiet 
        if ($pingComputer) {
            #Write-Output $TimeStamp + " $computer 1"
            $TimeStamp + " $computer 1" | Out-File -FilePath C:\Temp\Services.txt -Append   
        } else {
            #Write-Output $TimeStamp + " $computer 0"  
            $TimeStamp + " $computer 0" | Out-File -FilePath C:\Temp\Services.txt -Append    
        }
    }

    $running_hours = [int]((New-TimeSpan –Start $start_timer –End $current_time).hours)
    $running_minutes = [int]((New-TimeSpan –Start $start_timer –End $current_time).minutes) 
    $running_seconds = [int]((New-TimeSpan –Start $start_timer –End $current_time).seconds) 
    Write-Output  "Running for: $($running_hours)h:$($running_minutes)m:$($running_seconds)s" 
 } Until ($running_minutes -ge $limit_in_minutes)


 #Start-Sleep -Seconds 5