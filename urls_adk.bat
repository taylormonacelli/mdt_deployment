rem http://msdn.microsoft.com/en-us/library/windows/hardware/hh825494.aspx#InstallingNonNetworked
wget.exe -P "%CD%\.." --timestamping --input-file urls_adk.txt

cd ..

rem adksetup.exe /quiet /installpath /features +
adksetup.exe /quiet /installpath "%programfiles%\adk" /features +
