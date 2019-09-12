#./vs_community__217969693.1566954722.exe /q


$apps = "F:\software\desktop"
Invoke-WebRequest -Uri https://www.fosshub.com/ConEmu.html?dwl=ConEmuSetup.190714.exe  -OutFile ./ConEmuSetup.190714.exe
./ConEmuSetup.190714.exe /p:x64 /q

Invoke-WebRequest -Uri https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.msi -OutFile $apps/vagrant_2.2.5_x86_64.msi

& "$apps\flux-setup.exe" /S


Invoke-WebRequest -Uri https://us.download.nvidia.com/GFE/GFEClient/3.20.0.118/GeForce_Experience_v3.20.0.118.exe -OutFile ./GeForce_Experience_v3.20.0.118.exe
