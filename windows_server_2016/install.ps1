#how to create a base box
#git clone https://github.com/joefitzgerald/packer-windows.git
#copy Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO into iso folder
#packer build -var iso_url=./iso/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.iso windows_2016.json
#alternatively you can run simply with the filename to have packer download an image e.g.
#packer build windows_2012_r2.json
#vagrant box add windows_2016 windows_2016_virtualbox.box
#mkdir D:\vagrant\windows_2016
#cd D:\vagrant\windows_2016
#vagrant init windows_2016
#vagrant up

bcdedit /set hypervisorlaunchtype off
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Set-ExecutionPolicy RemoteSigned -f
 
choco feature enable -n allowGlobalConfirmation
choco install tortoisehg vcredist140 googlechrome mremoteng notepadplusplus

dism /online /Enable-Feature /FeatureName:WirelessNetworking /NoRestart
DISM /online /Enable-Feature /FeatureName:TelnetClient /NoRestart
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /NoRestart

Get-ChildItem -Path C:\software\verified\

cd C:\software\verified\
#install pulse
msiexec /i ps-pulse-win-9.0r4.0-b1731-64bitinstaller.msi /quiet /qn

#install SQL server
copy C:\software\en_sql_server_2014_developer_edition_with_service_pack_2_x64_dvd_8967821.iso c:\sqlsvr.iso
Mount-DiskImage C:\sqlsvr.iso -PassThru
d:\setup.exe /ConfigurationFile=C:\vagrant\install_files\ConfigurationFile.ini
Dismount-DiskImage -ImagePath C:\sqlsvr.iso
Remove-Item C:\sqlsvr.iso

New-NetFirewallRule -DisplayName '1433' -Profile 'Any' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 1433
 

 
#sqlcmd -S. -E -Q "sp_attach_db 'WoolLive', 'C:\aaa_development\mssql\WoolLive.mdf','C:\aaa_development\mssql\WoolLive_log.ldf'"
#sqlcmd -S. -E -Q "sp_attach_db 'MercariDirectNightly', 'C:\aaa_development\mssql\MercariDirectNightly.mdf','C:\aaa_development\mssql\MercariDirectNightly_log.LDF'"

#manual config
#https://stackoverflow.com/questions/7694/how-do-i-enable-msdtc-on-sql-server