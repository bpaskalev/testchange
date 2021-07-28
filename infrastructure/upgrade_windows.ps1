$lu="C:\tools\lastupdated.txt"
$updateDay=6
if (([int](get-date).DayOfWeek).Equals($updateDay) -and ((test-path $lu ) -and  ( (((get-date) - (get-date -date (Get-Content $lu)) | Select-Object  -expand Days ) -gt 6 )) -or !(test-path $lu) ) ){
        $webClient = New-Object System.Net.WebClient
        $url = 'https://go.microsoft.com/fwlink/?LinkID=799445'
        $file = "$($dir)\Win10Upgrade.exe"
        $webClient.DownloadFile($url,$file)
        Start-Process -wait -FilePath $file -ArgumentList ' /NoReboot /NoRestartUI /NoRestart /skipeula /auto upgrade /copylogs $dir'

        REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
        REG ADD "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
        REG ADD "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
        Get-Date -Format o > $lu
        restart-computer -f
}
#if (([int](get-date).DayOfWeek).Equals($updateDay) -and ((test-path $lu ) -and  ( (((get-date) - (get-date -date (Get-Content $lu)) | Select-Object  -expand Days ) -lt 2 )) -or !(test-path $lu) ) ){
#        stop-computer
#}
