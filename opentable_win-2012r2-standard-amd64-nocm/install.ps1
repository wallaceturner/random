cd C:/aaa_development/downloads	 
 
 Write-Host "Installing 2015 C++ Redist"
 ./vc_redist.x64.exe /q /norestart
 
 Write-Host "Installing .NET"
 ./NDP472-DevPack-ENU.exe /q /norestart
 
 Write-Host "Starting Chrome Install"
 ./ChromeStandaloneSetup64.exe /silent /install
 
 Write-Host "Starting tortoisehg Install"
 msiexec /i tortoisehg-5.0.2-x64.msi /quiet /qn /norestart /log tortoisehg_install.log 	 	
 
 Write-Host "Installing mRemote"
 msiexec /i mRemoteNG-Installer-1.76.20.24615.msi /quiet /qn /norestart /log mRemoteNG_install.log 	 	
 
 Write-Host "Starting Notepad++ Install"
 ./npp.7.5.4.Installer.exe /S
		 
 dism /online /Enable-Feature /FeatureName:WirelessNetworking /NoRestart
 
 DISM /Online /Enable-Feature /FeatureName:NetFx3 /All 
 
 DISM /online /Enable-Feature /FeatureName:TelnetClient
 #Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=853016 -OutFile ./SQLServer2017-SSEI-Dev.exe
 #./SQLServer2017-SSEI-Dev.exe /q /IACCEPTSQLSERVERLICENSETERMS
 
 copy C:\software\verified\en_sql_server_2014_developer_edition_with_service_pack_2_x64_dvd_8967821.iso c:\sqlsvr.iso
 Mount-DiskImage C:\sqlsvr.iso -PassThru

New-NetFirewallRule -DisplayName '1433' -Profile 'Any' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 1433

 #d:\setup.exe /q /ACTION=Install /FEATURES=SQL /INSTANCENAME=MSSQLSERVER /AGTSVCACCOUNT="NT AUTHORITY\Network Service" /IACCEPTSQLSERVERLICENSETERMS
 #d:\setup.exe /ConfigurationFile=C:\software\verified\ConfigurationFile.ini
 
 #sqlcmd -S. -E -Q "sp_attach_db 'WoolLive', 'C:\aaa_development\mssql\WoolLive.mdf','C:\aaa_development\mssql\WoolLive_log.ldf'"
#sqlcmd -S. -E -Q "sp_attach_db 'MercariDirectNightly', 'C:\aaa_development\mssql\MercariDirectNightly.mdf','C:\aaa_development\mssql\MercariDirectNightly_log.LDF'"

$Password = Read-Host -AsSecureString
New-LocalUser "vooos" -Password $Password -FullName "John Doe" -Description "Description of this account."
NET USER vooos $password /ADD /y