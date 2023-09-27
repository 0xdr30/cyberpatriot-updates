# Add-MpPreference -ExlusionPath "C:\Temp" #change to cyberpatriot directory CCS folder
Write-Host 'Have you Documented the readme?'

Write-Host 'Installing Windows Update Module (may take some time). Select "Yes to all" when prompted'
Install-Module PSWindowsUpdate

function Starting-Menu{ 
  Write-Host 'Choose an option:'
  Write-Host '1. Find a File'
  Write-Host '2. Update Local Policy'
  Write-Host '3. MS Defender Scan'
  Write-Host '4. MS Status'
  Write-Host '5. Update Windows'
  Write-Host '6. MalwareBytes'
  Write-Host '7. Automate in Background (Will Prompt for Windows Update)'
  
  #Add new choices here
  
  $choice = Read-Host "Choice "
  switch($choice){ #Read user input, choose from that
    "1" { Find-File }
    "2" { LocalPol }
    "3" { MS-Scan }
    "4" { Get-MpComputerStatus }
    "5" { Update }
    }
}

#Finding Files
function Find-File{
  $path = Read-Host -Prompt 'Input what path you want to search (C:\ to recurse the whole system)'
  $extensions = Read-Host -Prompt 'Input what extensions you want to search for (e.g. mp4, txt, etc.)'
  Get-childitem -Path $path -Recurse -ErrorAction -Include $extensions SilentlyContinue
}

# Scanning for Malware and PUPs
function MS-Scan{
  Write-Host 'Select a Scan Type or Option:'
  Write-Host '1. Quick Scan'
  Write-Host '2. Full Scan'
  Write-Host '3. Update MS Defender'
  $scantype = Read-Host "Choice "
  switch($scantype){
  "1" { Quick-Scan }
  "2" { Full-Scan }
  "3" { Update-Defender }
  }
}
function Update-Defender {
  Start-Job Update-MpSignature
  Set-MpPreference -SignatureScheduleDay Everyday
  Start-MpScan -ScanType QuickScan
  Write-Host "Defender Status: "
  Get-MpComputerStatus
  Write-Host "Past Detection: "
  Get-MpThreatDetection
  Write-Host "Current Threats Detected: "
  Get-MpThreat
}

function Quick-Scan {
  Start-MpScan -ScanType QuickScan
  Write-Host "Defender Status: "
  Get-MpComputerStatus
  Write-Host "Past Detection: "
  Get-MpThreatDetection
  Write-Host "Current Threats Detected: "
  Get-MpThreat
}

function Full-Scan {
  Start-MpScan -ScanType FullScan
  Write-Host "Defender Status: "
  Get-MpComputerStatus
  Write-Host "Past Detection: "
  Get-MpThreatDetection
  Write-Host "Current Threats Detected: "
  Get-MpThreat
}

function Update {
   Write-Host "Installing Windows Updates - Will Reboot when Done"
   Start-Job Get-WindowsUpdate -AcceptAll -Install -AutoReboot
   Write-Host "take your hands off the vm and do some research and stuff while it updates"
}

#Run All
function auto {
  Write-Host 'Searching for Files'
  Find-File
  Start-Job Start-MpScan -ScanType FullScan
  Start-Job Update-Defender
  Start-Job Update
  Write-Host "Do not power off or mess with the machine while it is updating. Let the update use the resources they need"
}



#Run the Script from the Beginning
function check1 {
  Write-Host 'Have you Documented the readme?'
  $answer = Read-Host "yes/no: "
  switch($answer){
    "yes" { Check2 }
    "no" { Write-Host "Do that first" }
  }
}

function check2 {
  Write-Host 'Have you Completed the Forensics Questions and Documented your answers?'
  $answer = Read-Host "yes/no: "
  switch($answer){
    "yes" { check3 }
    "no" { Write-Host "Do that please" }
  }
}
function check3{
  Write-Host 'are you ready to hack?'
  $answer = Read-Host "yes/yes: "
  switch($answer){
    "yes" { Starting-Menu }
    "no" { 
      Write-Host 'too bad'
      Starting-Menu
    }
  }
}

check1