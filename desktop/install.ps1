#./vs_community__217969693.1566954722.exe /q

#https://www.fosshub.com/ConEmu.html?dwl=ConEmuSetup.190714.exe 
./ConEmuSetup.190714.exe /p:x64 /q
$apps = "F:\software\verified"

& "$apps\flux-setup.exe" /S


Invoke-WebRequest -Uri https://us.download.nvidia.com/GFE/GFEClient/3.20.0.118/GeForce_Experience_v3.20.0.118.exe -OutFile ./GeForce_Experience_v3.20.0.118.exe
