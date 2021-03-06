
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

Write-Host 'Command information can be found here: https://docs.microsoft.com/en-us/azure-stack/hci/manage/diskspd-overview'-ForegroundColor Green
Write-Host 'For this test w50 (-w50 is equivalent to 50% read and 50% write'-ForegroundColor Green
Write-Host 'Runing command DiskSpd -t2 -o32 -b4k -r4k -w50 -d5 -Sh -D -L -c1G C:\IO.dat > C:\$env:computername-DiskspdResults.txt' -ForegroundColor Green

C:\DISKSPD-Ready\amd64\DiskSpd -t2 -o32 -b4k -r4k -w50 -d120 -Sh -D -L -c1G C:\IO.dat > C:\$env:computername-DiskspdResults.txt

Write-Host 'Clean up time...' -ForegroundColor Green

Remove-Item 'C:\IO.dat'
Write-Host 'Deleted C:\IO.dat ' -ForegroundColor Yellow
Remove-Item 'c:\DiskSpd-2.0.21a.zip'
Write-Host 'Deleted c:\DiskSpd-2.0.21a.zip ' -ForegroundColor Yellow
Remove-Item 'C:\DISKSPD-Ready' -Recurse
Write-Host 'Deleted C:\DISKSPD-Ready ' -ForegroundColor Yellow

Write-Host 'All Done, please attach computername-DiskspdResults.txt to your support case, so we can review ' -ForegroundColor Green
