http://brandonpadgett.com/powershell/Local-gpo-powershell/

################################################################################################################


function Starting-Menu{ 
  Write-Host 'Choose an option:'
  Write-Host '1. Find a file'
  Write-Host '2. Update Local Policy'
  Write-Host '3. MS Defender Scan'
  Write-Host '4. Automated'
  
  #Add new choices here
  
  $choice = Read-Host "Choose a choice"
  switch($choice){ #Read user input, choose from that
    "1" { Find-File }
    "2" { LocalPol }
    "3" { MS-Scan }
    "4" { All-Of-The-Above }
    }
}

#Finding Files
function Find-File{
  $path = Read-Host -Prompt 'Input what path you want to search'
  $extensions = Read-Host -Prompt 'Input what extensions you want to search for'
  Get-childitem -Path $path -Recurse -ErrorAction -Include $extensions SilentlyContinue
}

# Scanning for Malware and PUPs
function MS-Scan{
  $scantype = Read-Host -Prompt 'Choose a Scan Type:'
  Write-Host '1. Quick Scan'
  Write-Host '2. Full Scan'
  Write-Host '3. Update MS Defender'
  switch($scantype){
  "1" { Quick-Scan }
  "2" { Full-Scan }
  "3" { Update-Defender }
  }
}

function Update-Defender {
  Update-MpSignature
  Set-MpPreference -SignatureScheduleDay Everyday
  Start-MpScan -ScanType QuickScan
}

function Quick-Scan {
  Start-MpScan -ScanType QuickScan
}

function Full-Scan {
  Start-MpScan -ScanType FullScan
}

#Run All
function All-Of-The-Above {
  MS-Scan
  Update-Defender
  Write-Host "Work in Progress, some vulnerabilities are not scripted for automation"
}


Starting-Menu
