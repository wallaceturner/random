Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Set-ExecutionPolicy RemoteSigned -f

[Environment]::SetEnvironmentVariable("X_STREAM_CLIENT_SDK", "D:\aaa_development\x_stream_client_sdk", "User")
[Environment]::SetEnvironmentVariable("TSMRMSGFILE", "D:\aaa_development\x_stream_client_sdk\bin\tsmr.msg", "User")
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";D:\aaa_development\x_stream_client_sdk\bin", "Machine")


choco feature enable -n allowGlobalConfirmation
choco install git sourcetree tortoisehg -y
choco install packer -y
choco install nodejs-lts -y
choco install telegram -y
choco install 7zip processhacker -y
choco install google-backup-and-sync -y
choco install obs-studio -y
choco install mongodb studio3t sql-server-management-studio mremoteng conemu f.lux resharper
choco install dotnetcore-sdk --version=2.2.0

F:\software\desktop\MSBuild.Community.Tasks.v1.5.0.235.msi

#required for FexOnline sln
F:\software\desktop\PC-Span-x64593.msi
F:\software\desktop\SpanCom593-x64.msi

Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All

#Invoke-WebRequest -Uri https://us.download.nvidia.com/GFE/GFEClient/3.20.0.118/GeForce_Experience_v3.20.0.118.exe -OutFile ./GeForce_Experience_v3.20.0.118.exe

#mercari
netsh http add urlacl url=https://+:443/ user=$env:UserDomain\$env:UserName