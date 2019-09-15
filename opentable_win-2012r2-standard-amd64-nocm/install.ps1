
#how to create a base box
#git clone https://github.com/joefitzgerald/packer-windows.git
#copy Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO into iso folder
#packer build -var iso_url=./iso/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.iso windows_2016.json
#vagrant box add windows_2016 windows_2016_virtualbox.box
#mkdir D:\vagrant\windows_2016
#cd D:\vagrant\windows_2016
#vagrant init windows_2016
#vagrant up


Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

cd C:\software\verified	 

./Windows8.1-KB2919355-x64.msu
 
 #REBOOT
 
 Write-Host "Installing 2015 C++ Redist"
 ./vc_redist.x64.exe /q /norestart
 
 Write-Host "Starting Chrome Install"
 ./ChromeStandaloneSetup64.exe /silent /install
 
 #add the following to log msiexec calls: /log tortoisehg_install.log 	 	
 Write-Host "Starting tortoisehg Install"
 msiexec /i tortoisehg-5.0.2-x64.msi /quiet /qn /norestart 
 
 Write-Host "Installing mRemote"
 msiexec /i mRemoteNG-Installer-1.76.20.24615.msi /quiet /qn /norestart
 
 Write-Host "Starting Notepad++ Install"
 ./npp.7.7.1.Installer.x64.exe /S
		 
 dism /online /Enable-Feature /FeatureName:WirelessNetworking /NoRestart
 
DISM /online /Enable-Feature /FeatureName:TelnetClient /NoRestart
 
 
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /NoRestart

#REBOOT

Write-Host "Installing .NET"
 ./NDP472-DevPack-ENU.exe /q /norestart
 
 
 #Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=853016 -OutFile ./SQLServer2017-SSEI-Dev.exe
 #./SQLServer2017-SSEI-Dev.exe /q /IACCEPTSQLSERVERLICENSETERMS
 
 
Get-ChildItem -Path C:\software\verified\
copy C:\software\verified\en_sql_server_2014_developer_edition_with_service_pack_2_x64_dvd_8967821.iso c:\sqlsvr.iso

 Mount-DiskImage C:\sqlsvr.iso -PassThru

New-NetFirewallRule -DisplayName '1433' -Profile 'Any' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 1433
 
d:\setup.exe /ConfigurationFile=C:\vagrant\install_files\ConfigurationFile.ini
 
#sqlcmd -S. -E -Q "sp_attach_db 'WoolLive', 'C:\aaa_development\mssql\WoolLive.mdf','C:\aaa_development\mssql\WoolLive_log.ldf'"
#sqlcmd -S. -E -Q "sp_attach_db 'MercariDirectNightly', 'C:\aaa_development\mssql\MercariDirectNightly.mdf','C:\aaa_development\mssql\MercariDirectNightly_log.LDF'"

#$Password = Read-Host -AsSecureString
#New-LocalUser "vooos" -Password $Password -FullName "John Doe" -Description "Description of this account."
#NET USER vooos $password /ADD /y