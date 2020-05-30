#install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

[Environment]::SetEnvironmentVariable("MSSQL_CONN_STR", "server=192.168.73.10;User Id=sa;Password=P@ssword1", "User")
[Environment]::SetEnvironmentVariable("X_STREAM_CLIENT_SDK", "D:\aaa_development\x_stream_client_sdk", "User")
[Environment]::SetEnvironmentVariable("TSMRMSGFILE", "D:\aaa_development\x_stream_client_sdk\bin\tsmr.msg", "User")
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";D:\aaa_development\x_stream_client_sdk\bin", "Machine")


choco feature enable -n allowGlobalConfirmation
choco install notepadplusplus googlechrome -y
choco install vscode msbuild.communitytasks skype git sourcetree winscp keepass nodejs-lts qpdf telegram 7zip processhacker google-backup-and-sync mremoteng conemu f.lux resharper nordvpn whatsapp paint.net openconnect-gui
choco install virtualbox vagrant -y
choco install visualstudio2019community --package-parameters "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US"

#Invoke-WebRequest -Uri http://us.download.nvidia.com/Windows/347.88/347.88-desktop-win8-win7-winvista-64bit-international-whql.exe -OutFile ./347.88-desktop-win8-win7-winvista-64bit-international-whql.exe

#optional
choco install androidstudio
choco install obs-studio -y
choco install mongodb studio3t  
choco install dotnetcore-sdk --version=2.2.0
choco install sql-server-management-studio

#required for FexOnline sln
F:\software\desktop\PC-Span-x64593.msi
F:\software\desktop\SpanCom593-x64.msi

Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
DISM /online /Enable-Feature /FeatureName:TelnetClient /NoRestart
vagrant plugin install vagrant-disksize

#Visual Studio config
#Tools -> Options -> Project and Solutions -> Web Projects: "Stop debugger when browser window is closed".

#SourceTree/SSH setup
#open new PS window, navigate to home folder (`cd ~)
ssh-keygen -t rsa -b 4096 -C "wallaceturner@gmail.com"
#log into bitbucket using fex account (w.turner@fex.com.au) and upload new SSH key 
#Your Profile and Settings ->  Personal Settings -> SSH Keys
cat .\.ssh\id_rsa.pub
#open SourceTree select `Tools -> Create or Import SSH Keys` select 'Load' and open .\.ssh\id_rsa
#save this file as .\.ssh\id_rsa.ppk
#start Pageant (from notification menu area) and select 'Add Key' and select the ppk from previous step

#vagrant
#if after calling 'vagrant up' it launches a new VM instead of the existing VM you need to tell vagrant the id of the VM. 
https://superuser.com/questions/679457/vagrant-virtualbox-vm-is-initializing-new-instead-of-loading-the-existing-vm-aft/682149#682149

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


#add SSL cert using D:\Program Files2\httpconfig\HttpConfig.exe

#delete .vs folder if you get red underlines in visual studio
https://stackoverflow.com/questions/21098333/visual-studio-compiles-fine-but-still-shows-red-lines