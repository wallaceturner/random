#./vs_community__217969693.1566954722.exe /q

#https://www.fosshub.com/ConEmu.html?dwl=ConEmuSetup.190714.exe 
./ConEmuSetup.190714.exe /p:x64 /q
$apps = "F:\software\verified"

& "$apps\flux-setup.exe" /S


sqlcmd -S. -E -Q "sp_attach_db 'WoolLive', 'D:\aaa_development\mssql\WoolLive.mdf','D:\aaa_development\mssql\WoolLive_log.ldf'"
sqlcmd -S. -E -Q "sp_attach_db 'MercariDirectNightly', 'D:\aaa_development\mssql\MercariDirectNightly.mdf','D:\aaa_development\mssql\MercariDirectNightly_log.LDF'"