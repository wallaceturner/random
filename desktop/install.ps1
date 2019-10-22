DISM /online /Enable-Feature /FeatureName:TelnetClient /NoRestart

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Set-ExecutionPolicy RemoteSigned -f

[Environment]::SetEnvironmentVariable("MSSQL_CONN_STR", "database=FEX_MDS;server=192.168.22.10;User Id=sa;Password=P@ssword1", "User")
[Environment]::SetEnvironmentVariable("X_STREAM_CLIENT_SDK", "D:\aaa_development\x_stream_client_sdk", "User")
[Environment]::SetEnvironmentVariable("TSMRMSGFILE", "D:\aaa_development\x_stream_client_sdk\bin\tsmr.msg", "User")
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";D:\aaa_development\x_stream_client_sdk\bin", "Machine")


choco feature enable -n allowGlobalConfirmation
choco install git sourcetree tortoisehg -y
choco install winscp keepass
choco install packer -y
choco install nodejs-lts qpdf -y
choco install telegram -y
choco install 7zip processhacker -y
choco install google-backup-and-sync -y
choco install obs-studio -y
choco install mongodb studio3t sql-server-management-studio mremoteng conemu f.lux resharper nordvpn
choco install dotnetcore-sdk --version=2.2.0
choco install visualstudio2019community --package-parameters "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US"

F:\software\desktop\MSBuild.Community.Tasks.v1.5.0.235.msi

#required for FexOnline sln
F:\software\desktop\PC-Span-x64593.msi
F:\software\desktop\SpanCom593-x64.msi

Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

#Invoke-WebRequest -Uri https://us.download.nvidia.com/GFE/GFEClient/3.20.0.118/GeForce_Experience_v3.20.0.118.exe -OutFile ./GeForce_Experience_v3.20.0.118.exe

#Visual Studio config
#Tools -> Options -> Project and Solutions -> Web Projects: "Stop debugger when browser window is closed".


#mercari
netsh http add urlacl url=https://+:443/ user=$env:UserDomain\$env:UserName

New-NetFirewallRule -DisplayName '8080' -Profile 'Any' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8080
New-NetFirewallRule -DisplayName '59166' -Profile 'Any' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 59166
Add-Content C:\Windows\System32\drivers\etc\hosts "10.160.4.20`t fexglobitefow01.fglau.com"
Add-Content C:\Windows\System32\drivers\etc\hosts "10.160.4.22`t fexglobetefow01.fglau.com"
Add-Content C:\Windows\System32\drivers\etc\hosts "10.160.4.10`t fexglobfow01.fglau.com"
cp F:\Dropbox\docs\confCons.xml C:\Users\vagrant\AppData\Roaming\mRemoteNG
cp F:\Dropbox\docs\confCons.xml F:\software\verified

npm i aurelia-cli@0.34 -g
npm install -g @angular/cli