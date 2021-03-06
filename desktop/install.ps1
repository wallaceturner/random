Set-ExecutionPolicy RemoteSigned

#install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

[Environment]::SetEnvironmentVariable("Path", $env:Path + ";D:\aaa_development\x_stream_client_sdk\bin", "Machine")
[Environment]::SetEnvironmentVariable("X_STREAM_CLIENT_SDK", "D:\aaa_development\x_stream_client_sdk", "User")
[Environment]::SetEnvironmentVariable("TSMRMSGFILE", "D:\aaa_development\x_stream_client_sdk\bin\tsmr.msg", "User")

[Environment]::SetEnvironmentVariable("MSSQL_CONN_STR", "server=localhost;User Id=sa;Password=P@ssword1", "User")
[Environment]::SetEnvironmentVariable("RAVENDB4_URL", "https://local.investi.com.au:8080/", "User")
[Environment]::SetEnvironmentVariable("RAVENDB_CERT_CN", "*.investi.com.au", "User")

[Environment]::SetEnvironmentVariable("investi_server_location", "wal@investi.com.au", "User")
[Environment]::SetEnvironmentVariable("investi_server_pass", "", "User")


choco feature enable -n allowGlobalConfirmation
choco install notepadplusplus googlechrome -y
choco install vscode msbuild.communitytasks skype git putty sourcetree winscp keepass qpdf telegram 7zip processhacker google-backup-and-sync mremoteng conemu f.lux whatsapp paint.net openconnect-gui signal tixati vlc processhacker screentogif treesizefree slack
choco install nordvpn 
choco install nodejs --version=12.22.1
choco install dotnetcore-sdk
choco install virtualbox vagrant -y
choco install visualstudio2019community --package-parameters "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US"
choco install resharper sql-server-management-studio

#optional
choco install androidstudio -y
choco install obs-studio -y

#vscode extensions
code --install-extension ms-vscode-remote.vscode-remote-extensionpack
code --install-extension jpoissonnier.vscode-styled-components
code --install-extension vscode-icons-team.vscode-icons
code --install-extension rangav.vscode-thunder-client
code --install-extension donjayamanne.githistory

#npm
npm i typescript -g

#client/server certificates for ravendb
certutil -f -importpfx -user D:\GoogleDrive\docs\certificates\investi.com.au\client.pfx
certutil -addstore "Root" "D:\GoogleDrive\docs\certificates\rootCA\rootCA.crt"

#required for FexOnline sln
choco install dotnetcore-sdk --version=2.2.0

d:\software\PC-Span-x64593.msi /quiet /passive EULA=1
d:\software\SpanCom593-x64.msi /quiet /passive EULA=1



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

#clone personal or work repos
git clone wallace_turner@bitbucket.org:wallace_turner/investi.git
git clone w_turner@bitbucket.org:fexglobal/huntsman.git
git clone w_turner@bitbucket.org:fexglobal/webtrader.git
git clone w_turner@bitbucket.org:fexglobal/mercaridirect.git
	
#change git origin if does not include username - takes 2 commands as sourcetree adds 'pushurl' into the git config
git remote set-url origin w_turner@bitbucket.org:fexglobal/mercaridirect.git
git remote set-url --push origin w_turner@bitbucket.org:fexglobal/mercaridirect.git
#git config --get remote.origin.url

#dont use username for github.com - instead it should contain the 'Host' field in ssh config (see https://gist.github.com/jexchan/2351996)
git remote set-url origin git@github.com-wallaceturner:wallaceturner/random.git

#for github wallaceturner repos:
git config user.email "wallaceturner@gmail.com"
git config user.name "wallace_turner"

#to test
ssh -T git@github.com

#bamboo
git remote set-url origin git@github.com-bamboo:bamboo-io/notification-pm.git

#vagrant
#if after calling 'vagrant up' it launches a new VM instead of the existing VM you need to tell vagrant the id of the VM. 
#https://superuser.com/questions/679457/vagrant-virtualbox-vm-is-initializing-new-instead-of-loading-the-existing-vm-aft/682149#682149
# 1) start the VM manually. double click D:\virtual_box_vdis\dev.investi.com.au\dev.investi.com.au.vbox
#if you get 'failed to create the raw output file' delete the serial port (or change path to match existing file)
# 2) get id of image: VBoxManage list vms
# 3) update id by editing file: D:\aaa_development\bitbucket\investi\scripts\vagrant\.vagrant\machines\default\virtualbox\id


#mercari
netsh http add urlacl url=https://+:443/ user=$env:UserDomain\$env:UserName

New-NetFirewallRule -DisplayName '8080' -Profile 'Any' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8080
New-NetFirewallRule -DisplayName '59166' -Profile 'Any' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 59166
Add-Content C:\Windows\System32\drivers\etc\hosts "10.160.4.20`t fexglobitefow01.fglau.com"
Add-Content C:\Windows\System32\drivers\etc\hosts "10.160.4.22`t fexglobetefow01.fglau.com"
Add-Content C:\Windows\System32\drivers\etc\hosts "10.160.4.10`t fexglobfow01.fglau.com"
Add-Content C:\Windows\System32\drivers\etc\hosts "192.168.83.10`t ubuntu"
cp D:\GoogleDrive\docs\confCons.xml C:\Users\vagrant\AppData\Roaming\mRemoteNG
cp D:\GoogleDrive\docs\confCons.xml F:\software\verified



#add SSL cert using D:\Program Files2\httpconfig\HttpConfig.exe

#delete .vs folder if you get red underlines in visual studio
https://stackoverflow.com/questions/21098333/visual-studio-compiles-fine-but-still-shows-red-lines

#conemu setup:
# remove global hotkey for backtick `Settings -> Keys&Macros`
# modify powershell task: `Startup -> Tasks` select '{Shells:Powershell.exe} enter following into text area  -new_console:d:D:\aaa_development powershell.exe

vs code: keyboard shortcuts 'expand selection' 'saveAll'

https://superuser.com/questions/958109/how-to-prevent-windows-10-waking-from-sleep-when-traveling-in-bag

#generate ssh private keys and add public key to remote server
#ssh-keygen -t rsa -b 4096 -C "wallaceturner@gmail.com"
#ssh-keygen -t rsa -b 4096 -C "w.turner@fex.com.au"
#cat ~/.ssh/id_rsa.pub | ssh wal@dev.investi.com.au "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"
#cat ~/.ssh/id_rsa_wallaceturner.pub | ssh wal@wallaceturner.com "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"

cmd /c mklink C:\Users\%username%\AppData\Roaming\Code\User\settings.json D:\GoogleDrive\docs\vscode\settings.json
cmd /c mklink C:\Users\%username%\AppData\Roaming\Code\User\keybindings.json D:\GoogleDrive\docs\vscode\keybindings.json


#before linking you need to remove excess permissions on D:\GoogleDrive\docs\ssh
# Properties -> Security -> Advanced
# Change owner to yourself. 
# Disable Inheritance. (Remove all inherited permissions from this object) - this will remove all users from the list
# Add yourself back in via 'Add' button'. tick 'Replace all child object persmissions'
cmd /c mklink /d C:\Users\%username%\.ssh D:\GoogleDrive\docs\ssh

#https://community.atlassian.com/t5/Sourcetree-questions/Pageant-doesn-t-save-keys/qaq-p/142855



#create startup file to start VMs
C:\Users\%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\start_vm.bat
cd /d D:\aaa_development\GitHub\random\ubuntu
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm ubuntu.docker --type headless