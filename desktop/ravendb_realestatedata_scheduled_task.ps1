$Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "D:\aaa_development\RealEstateData\scripts\backup_db.ps1" -WorkingDirectory "D:\aaa_development\RealEstateData\scripts\"
$Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-NoExit -NoLogo -NoProfile -File 'D:\aaa_development\RealEstateData\scripts\backup_db.ps1'"
$Trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 4pm
$Settings = New-ScheduledTaskSettingsSet
$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings
Register-ScheduledTask -TaskName 'backup realestatedata db' -InputObject $Task