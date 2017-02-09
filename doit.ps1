if(!(test-path wget.exe)){
	(new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/wget.exe','wget.exe')
}

./wget --quiet --no-check-certificate --limit-rate=2m --directory-prefix=. --timestamping http://installer-bin.streambox.com/7za.exe

$jobs = @()

# Windows Embedded Standard 7 Service Pack 1 Evaluation Edition
$j = {
	param($write_dir)

	@'
# Windows Embedded Standard 7 Service Pack 1 Evaluation Edition
# http://www.microsoft.com/en-us/download/details.aspx?id=11887
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard%207%20SP1%20Toolkit.part01.exe
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard%207%20SP1%20Toolkit.part02.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard%207%20SP1%20Toolkit.part03.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard%207%20SP1%20Toolkit.part04.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard%207%20SP1%20Toolkit.part05.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard%207%20SP1%20Toolkit.part06.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard%207%20SP1%20Toolkit.part07.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard%207%20SP1%20Toolkit.part08.rar
'@ | Out-File -encoding ASCII "$write_dir\urls_ws7e_toolkit.txt"

	$exe="$write_dir\wget.exe"
	&$wget --quiet --no-check-certificate --timestamping --limit-rate=2m `
	  --directory-prefix=$write_dir --input-file="$write_dir\urls_ws7e_toolkit.txt"
	$exe="$write_dir\Standard 7 SP1 Toolkit.part01.exe"
	&$exe -s -d .
	$exe="$write_dir\7za.exe"
	&$7za x -o"Standard 7 SP1 Toolkit" "Standard 7 SP1 Toolkit.iso"
}

$jobs += $j

$script_dir_base = Split-Path -Parent $MyInvocation.MyCommand.Path
foreach($job in $jobs)
{
	Start-Job $job -Arg $script_dir_base
}
