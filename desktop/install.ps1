Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
 Set-ExecutionPolicy RemoteSigned -f
 
choco feature enable -n allowGlobalConfirmation
choco install git sourcetree tortoisehg -y
choco install packer -y
choco install nodejs-lts -y
choco install telegram -y
choco install 7zip processhacker -y
choco install google-backup-and-sync -y
choco install obs-studio -y
choco install mongodb studio3t

#./vs_community__217969693.1566954722.exe /q
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

cd "F:\software\desktop"

& "./ConEmuSetup.190714.exe" /p:x64 /q

Invoke-WebRequest -Uri https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.msi -OutFile $apps/vagrant_2.2.5_x86_64.msi

& "./flux-setup.exe" /S

& "./VirtualBox-6.0.10-132072-Win.exe" --silent

./SSMS-Setup-ENU.exe /S

#Invoke-WebRequest -Uri https://us.download.nvidia.com/GFE/GFEClient/3.20.0.118/GeForce_Experience_v3.20.0.118.exe -OutFile ./GeForce_Experience_v3.20.0.118.exe

#msiexec /qn /i C:\temp\vagrant_2.2.5_x86_64.msi

msiexec /i "$./tortoisehg-5.0.2-x64.msi" /quiet /qn /norestart

msiexec /qn /l* node-log.txt /i node-v10.16.3-x64.msi