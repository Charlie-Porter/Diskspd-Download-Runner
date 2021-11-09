
Write-Host "This powershell script will download diskspd from https://github.com/microsoft/diskspd/releases/download/v2.0.21a/DiskSpd.zip" -ForegroundColor Green

$client = new-object System.Net.WebClient
$client.DownloadFile("https://github.com/microsoft/diskspd/releases/download/v2.0.21a/DiskSpd.zip","c:\DiskSpd-2.0.21a.zip")


Write-Host 'Download completed at c:\DiskSpd-2.0.21a.zip' -ForegroundColor Green

$file = 'C:\DISKSPD-Ready'
#If the folder does not exist, create it.
if (-not(Test-Path -Path $file -PathType Container)) {
     try {
            
           Write-Host 'The DISKSPD-Ready folder did not exist, so creating it ' -ForegroundColor Green

            Expand-Archive -LiteralPath c:\DiskSpd-2.0.21a.zip -DestinationPath $file
     }
     catch {
         throw $_.Exception.Message
     }


 }

Write-Host 'Runing command diskspd -t2 -o32 -b4k -r4k -w0 -d120 -Sh -D -L -c2G f:\IO.dat > C:\$env:computername-DiskspdResults.txt' -ForegroundColor Green

C:\DISKSPD-Ready\amd64\diskspd -t2 -o32 -b4k -r4k -w0 -d120 -Sh -D -L -c2G f:\IO.dat > C:\$env:computername-DiskspdResults.txt

Write-Host 'Clean up time...' -ForegroundColor Green

Remove-Item 'f:\IO.dat'
Write-Host 'Deleted f:\IO.dat ' -ForegroundColor Yellow
Remove-Item 'c:\DiskSpd-2.0.21a.zip'
Write-Host 'Deleted c:\DiskSpd-2.0.21a.zip ' -ForegroundColor Yellow
Remove-Item 'C:\DISKSPD-Ready' -Recurse
Write-Host 'Deleted C:\DISKSPD-Ready ' -ForegroundColor Yellow

Write-Host 'All Done, please attach computername-DiskspdResults.txt to your Kofax support case, so we can review ' -ForegroundColor Green