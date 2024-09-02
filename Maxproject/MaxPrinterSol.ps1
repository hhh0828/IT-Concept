# Please ask me(hyunho) to add the code if there's a additional driver and printer added on the new site.
# Do not copy and paste the code to your computer- here's a confidential data and data loss risk.
# Do not change Access Token and the Application information. the token expiration date is January 15th 2026.
# Copyright by IT-Concept.
#requirement
#MS graph API & Permission
#Hash_Table key and value
#Sysnative & pnputil syswow64
#printer mandatory files
#Token Access
#for * for array
#Log & directory & eventviewer
#data flow & case switch line
#intune

# declare variable and group
# create hashtable for IPaddress.


$MaximusRegion_IPHash = @{
    "MXSKR-SG-S-BUCHEON" = "10.82
    "MXSKR-SG-S-BUPYEONG" = "10.82
    "MXSKR-SG-S-INCHEON" = "10.82
    "MXSKR-SG-S-WONJU" = "10.82
    "MXSKR-SG-S-BUSAN" = "10.82
    "MXSKR-SG-S-GWANAK" = "10.82
    "MXSKR-SG-S-SEOULEAST" = "10.82
    "MXSKR-SG-S-GOYANG" = "10.82
    "MXSKR-SG-S-YONGIN" = "10.82
    "MXSKR-SG-S-SIHEUNG" = "10.82
    "MXSKR-SG-S-GANGNEUNG" = "10.82
    "MXSKR-SG-S-GWANGJU" = "10.82
    "MXSKR-SG-S-JEONJU" = "10.82
    "MXSKR-SG-S-SEJONG" = "10.82
    "MXSKR-SG-S-CHEONGJU" = "10.82
    "MXSKR-SG-S-BUSANEAST" = "10.82
    "MXSKR-SG-S-ULSAN" = "10.82
    "MXSKR-SG-S-GIMHAE" = "10.82
    "MXSKR-SG-S-CHANGWON" = "10.82
    "MXSKR-SG-S-CHUNCHEON" = "10.82
    "MXSKR-SG-S-BUSANDONGSEO" = "10.82
    "Huntress Test" = "10.10
    "Test_deploy_Intune" = "8.8
}

#add your printerdriver for each printer group. for example if you need to add a printer on the script you need to put your printer same as below and add the group on the proper group.

$D430Group = @('MXSKR-SG-S-CHANGWON')
$D420Group = @('MXSKR-SG-S-BUPYEONG','MXSKR-SG-S-INCHEON','MXSKR-SG-S-BUSAN')
$SamsungGroup = @('MXSKR-SG-S-ULSAN')
$KMB128DN = @('MXSKR-SG-S-BUCHEON','MXSKR-SG-S-WONJU','MXSKR-SG-S-GWANAK','MXSKR-SG-S-SEOULEAST','MXSKR-SG-S-GOYANG','MXSKR-SG-S-YONGIN','MXSKR-SG-S-SIHEUNG','MXSKR-SG-S-GANGNEUNG','MXSKR-SG-S-GWANGJU','MXSKR-SG-S-JEONJU','MXSKR-SG-S-SEJONG','MXSKR-SG-S-CHEONGJU','MXSKR-SG-S-CHUNCHEON','MXSKR-SG-S-CHANGWON')
$OJP8710 = @('MXSKR-SG-S-BUSANDONGSEO')
$C2265 = @('MXSKR-SG-S-BUSANEAST','Huntress test')
$C3725 = @('Test_deploy_Intune','MXSKR-SG-S-GIMHAE','MXSKR-SG-U-IT admins')

#Allgroup = the group elements for each printer
$AllGroup = @($D430Group,$D420Group,$SamsungGroup,$KMB128DN,$OJP8710,$C2265,$C3725)

#Allgroups = to verify name with the string variable
$AllGroups = @("D430Group", "D420Group", "SamsungGroup", "KMB128DN", "OJP8710", "C2265", "C3725")




<#
##when the User Context disabled by MAX.
$proc = Get-CimInstance Win32_Process -Filter "name = 'explorer.exe'"
$username = Invoke-CimMethod -InputObject $proc[0] -MethodName GetOwner | select-object -ExpandProperty user
Test-Path -Path  "C:\Users\$username"
$userprincipalname = $username + "@maximuskr.co.kr"

>#











<#
# find UPN, the user who enrolled the device to intune. it will not change.
$userprincipalname = $null 

function Search-RegistryForKey {
    param (
        [string]$registryPath
    )

    $subKeys = Get-ChildItem -Path $registryPath
    foreach ($subKey in $subKeys) {
        $upn = (Get-ItemProperty -Path "$($subKey.PSPath)" -Name UPN -ErrorAction SilentlyContinue).UPN
        if ($upn -ne $null) {
            $global:userprincipalname = $upn 
            return
        }
        Search-RegistryForKey -registryPath "$($subKey.PSPath)"
    }
}

$registryPath = "HKLM:\SOFTWARE\Microsoft\Enrollments"
Search-RegistryForKey -registryPath $registryPath

$userprincipalname
#>

$filePath = "C:\itc\systemdetail.txt"
$userprincipalname = Get-Content -Path $filePath -TotalCount 1
$userprincipalname

<#
##find Displayname which synced with  ADDC on regiestry.
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI"
$displayName = (Get-ItemProperty -Path $registryPath -Name "LastLoggedOnDisplayName").LastLoggedOnDisplayName
$displayName
#>

#Azure AD app registration
$clientId = 
$clientSecret = 
$tenantId = 

# Define the Microsoft Graph API endpoint for token acquisition
$tokenEndpoint = "https://login.microsoftonline.com/$tenantId/oauth2/token"

# Get the access token using client credentials flow
$tokenRequestBody = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
    resource      = "https://graph.microsoft.com"
}

# Explicitly set Content-Type header
$headers = @{
    'Content-Type' = 'application/x-www-form-urlencoded'
}

# Make a POST request to retrieve the access token
$tokenResponse = Invoke-RestMethod -Uri $tokenEndpoint -Method Post -Body $tokenRequestBody -Headers $headers

# Extract the access token
$accessToken = $tokenResponse.access_token

$allusers = @()
# Retrieve the user ID using Microsoft Graph API
$user = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/users?`$filter=userprincipalname eq '$userprincipalname'" -Headers @{Authorization = "Bearer $accessToken"} -Method get

#matching user
<#
for ($i=0; $i -le $User.value.userprincipalname.Count-1; $i++)
{
if($User.value.userprincipalname[$i] -eq $userPrincipalName)
	{
		$userId = $user.value.id[$i]
		$userid
	}
}
#>
$userId = $user.value.id


# Define the Microsoft Graph API endpoint for group membership
$groupMembershipEndpoint = "https://graph.microsoft.com/v1.0/users/{0}/memberOf" -f $userId

# Make a GET request to retrieve the user's group membership
$headers = @{
    Authorization = "Bearer $accessToken"
}

try {
    $response = Invoke-RestMethod -Uri $groupMembershipEndpoint -Headers $headers -Method get
    $groups = $response.value | Where-Object { $_.securityEnabled -eq $true } | Select-Object -ExpandProperty displayName
$RegionGroup = 'DefaultNotFound'
$PrinterGroup = 'Default'
$groups | out-file -filepath C:\itc\Security_Group_List.txt
Write-Host "Azure AD security groups for region of $($userprincipalname):"


    foreach ($group in $groups) {
       
	##check with index one by one if the array named group has a security group we are looking for.

	for ($i=0; $i -le $Allgroup.count-1; $i++)
	{
		#$Allgroup[$i]
		for($j=0; $j -le $Allgroup[$i].count-1; $j++)
		{
			if($Allgroup[$i][$j].Trim() -eq $group.Trim())
			{
				#retrieve the security group matched to Allgroup
				$RegionGroup = $Allgroup[$i][$j]
				$PrinterGroup = $Allgroups[$i]
				break
			}
		}	
	}

    }
}

catch {
    Write-Host "Error accessing group membership:"
    Write-Host $_.Exception.Message
}


#detect rule
##check user enrollment date  **this retrive UTC time Please add +9:00 KST.
$thehostname = hostname
$userdevice = invoke-restmethod -uri "https://graph.microsoft.com/v1.0/users/$userprincipalname/manageddevices"  -Headers $headers -Method get
for ($i=0; $i -le $userdevice.value.count-1; $i++)
{
$userdevice.value.devicename
if ($userdevice.value[$i].devicename -eq $thehostname)
{$enrollmentdate = $userdevice.value[$i].enrolledDateTime
break}

}


$enrollmentdate_timevalue = [datetime]::ParseExact($enrollmentdate, "yyyy-MM-ddTHH:mm:ssZ", $null)
$currentDateTime = Get-Date
$currentDateTimeUtc = $currentDateTime.TouniversalTime()
$timeDifference = $currentDateTimeUtc - $enrollmentDate_timevalue
$passeddays = $timedifference.Totaldays
$haspassed24hours = $timedifference.Totaldays -ge 1



# the list of Region and Printers Printer IP. 
$RegionGroup
$PrinterGroup
$printerIP = $MaximusRegion_IPHash.$RegionGroup

# Log and history of user.
$currentdate = get-date -format MM/dd/yyyy
Add-content -path C:\itc\Security_Group_List.txt -value "'$currentdate' and '$RegionGroup' and '$PrinterGroup' and '$printerIP'"
Add-content -path C:\itc\Security_Group_List.txt -value "check the device enrollment date"
Add-content -path C:\itc\Security_Group_List.txt -value "'$enrollmentdate' checkd that '$passeddays' days passed after windows enrollment"

if (-not $hasPassed24Hours) {

	write-output "notinstalled"
}
#if the value is greater than 1 days we can see it's already installed on the user computer. so just added the content as below and see the log when the detect rule comes out.
#exit the whole code assuming it's already installed
else {
Add-content -path C:\itc\Security_Group_List.txt -value "Completed"
exit}




###need to be fixed when the issue is validated .


$ScriptPath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

New-Item -ItemType Directory -path c:\PrinterITC\Printerdrivercollection
Start-Sleep -Seconds 2
Copy-Item -Path "$ScriptPath\Printerdrivercollection.zip" -Destination c:\PrinterITC
Start-Sleep -Seconds 10
expand-archive c:\PrinterITC\Printerdrivercollection.zip -DestinationPath c:\PrinterITC\Printerdrivercollection
Start-Sleep -Seconds 10

#-------------------------------------------------------#Switch go to port and if matched, go to make a value--------------------------------------------------------------------------------------------------------------------------------------------




##need to validate the variables, check if it works and the path which the file would be installed....





#Fixed Value 
#$printerIP = $MaximusRegion_IPHash.$RegionGroup
$printerNameBnW         = "Maximus Printer B&W"
$printerNameColor       = "Maximus Printer Color"




$eventlogCategory       = 3

# LOGGING PARAMETERS
$global:logging         = $True
$global:verboselog      = $False
$global:logtoEventlog   = $True
$global:logtoFile       = $False
$global:logTimeDate     = $True
$global:eventlogSource  = "IT-Concept"

switch ( $PrinterGroup )
{
D430Group
{
# SET PARAMETERS HERE
$driverInf              = "oemsetup.inf"
$driverName             = "Sindoh D430 PCL 6"
$PrinterPortNameBnW     = "TCPIP:SindohD430BnW"
$PrinterPortNameColor   = "TCPIP:SindohD430Color"
}

D420Group
{
# SET PARAMETERS HERE
$driverInf              = "KOAXTJA_.INF"
$driverName             = "SINDOH D420/CM Series PCL"
$PrinterPortNameBnW     = "TCPIP:SindohD420BnW"
$PrinterPortNameColor   = "TCPIP:SindohD420Color"
}

SamsungGroup
{
# SET PARAMETERS HERE
$driverInf              = "us016.inf"
$driverName             = "Samsung Universal Print Driver 3"
$PrinterPortNameBnW     = "TCPIP:SamsungPrintB&W"
$PrinterPortNameColor   = "TCPIP:SamsungPrintColor"
}

KMB128DN
{
# SET PARAMETERS HERE
$driverInf              = "KOBxxK__01.inf"
$driverName             = "KONICA MINOLTA Universal V4 PCL"
$PrinterPortNameBnW     = "TCPIP:KMB128BnW"
$PrinterPortNameColor   = "TCPIP:KMB128Color"
}

OJP8710
{
# SET PARAMETERS HERE
$driverInf              = "hpygid20.inf"
$driverName             = "HP OfficeJet Pro 8710"
$PrinterPortNameBnW     = "TCPIP:OJP8710BnW"
$PrinterPortNameColor   = "TCPIP:OJP8710Color"
}

C2265
{
# SET PARAMETERS HERE
$driverInf              = "FF6MBAL.inf"
$driverName             = "FF K539p for DocuCentre-V C2265 PCL 6"
$PrinterPortNameBnW     = "TCPIP:C2265BnW"
$PrinterPortNameColor   = "TCPIP:C2265Color"
}

C3725
{
# SET PARAMETERS HERE
$driverInf              = "CNP60MA64.INF"
$driverName             = "Canon Generic Plus PCL6"
$PrinterPortNameBnW     = "TCPIP:C3725BnW"
$PrinterPortNameColor   = "TCPIP:C3725Color"
}

}
# EXECUTION PARAMETERS
$driverInfFile          = "c:\PrinterITC\Printerdrivercollection\$PrinterGroup\$driverInf"
$PNPUtil = [System.IO.Path]::Combine($env:SystemRoot, 'sysnative', 'pnputil.exe')
#$PNPUtil                = [System.Environment]::SystemDirectory + "\pnputil.exe"


##########################################################################################################################

Function LogWrite
{
    Param (
        [Parameter(Mandatory=$True)]
        [string]$Logstring,
        [Parameter(Mandatory=$True)]
        [string]$type,
        [Parameter(Mandatory=$False)]
        [string]$v    
    )
    #Check if Logging is wanted
    if ( $global:logging -eq $True ) {
        
        #Determine Log Entry Type        
        Switch ($type) {
            start { 
                $logType    = "[Start]"
                $elogtype   = "Information"
                $logColour  = "Green"
            }
            i { 
                $logType    = "[Info]"
                $elogtype   = "Information"
                $logColour  = "White"
            }
            w { 
                $logType    = "[Warning]"
                $elogtype   = "Warning"
                $logColour  = "Yellow"
            }
            e { 
                $logType    = "[Error]"
                $elogtype   = "Error"
                $logColour  = "Red"
            }
            end { 
                $logType    = "[End]"
                $elogtype   = "Information"
                $logColour  = "Green"
            }
        }
        #Log Time Date for each log entry
        if ( $global:logTimeDate -eq $True ) {
            $TimeStamp = Get-Date -Format "yyyy-MM-dd-HH:mm"
            $TimeStamp = "[$TimeStamp]"
        } else {
            $TimeStamp = $Null
        }
        #Create Eventlog Source
        if ( $global:logtoEventlog -eq $True ) {
            #Check if log source exists
            $checkLogSourceExists = [System.Diagnostics.EventLog]::SourceExists( "$global:eventlogSource" )
            if ( $checkLogSourceExists -eq $False ) {
                New-EventLog -LogName Application -Source $global:eventlogSource -ErrorAction SilentlyContinue
            }
        }

        #Check if Verbose logging enabled and of log entry is marked as verbose
        if ( $global:verboselog -eq $True -and $v -eq $True ) {
            #Check if Log Entry is marked as verbose       
                if ( $global:logtoFile -eq $True ) { 
                    Add-Content $Logfile -value "$TimeStamp[Verbose]$logType $logstring" -ErrorAction Stop
                }
                if ( $global:logtoEventlog -eq $True ) { 
                    Write-EventLog `
                        -LogName Application `
                        -Source $global:eventlogSource `
                        -EntryType $elogtype `
                        -EventID 1 `
                        -Category $eventlogCategory `
                        -Message $logstring `
                        -ErrorAction Stop
                }
                Write-Host "[Verbose]$logType $logstring" -ForegroundColor $logColour

        } else {
            #Check if log is verbose if it is dont log it otherwise log a standard entry
            if ( $v -eq $True ) {        
                #Do Nothing
            } else {
                #Write Standard Log Entry
                if ( $global:logtoFile -eq $True ) {
                    Add-Content $Logfile -value "$TimeStamp$logType $logstring" -ErrorAction Stop
                }
                if ( $global:logtoEventlog -eq $True ) { 
                    Write-EventLog `
                        -LogName Application `
                        -Source $global:eventlogSource `
                        -EntryType $elogtype `
                        -EventID 1 `
                        -Category $eventlogCategory `
                        -Message $logstring `
                        -ErrorAction Stop 
                }
            }

            #Write Standard Log Entries to Screen if verbose logging is enabled
            if ( $global:verboselog -eq $True ) {
                Write-Host "$logType $logstring" -ForegroundColor $logColour
            }
        }

    }
}

# WHERE THE MAGIC HAPPENS
LogWrite "Installing Printer `n`rPrinter: $driverName`n`rDriver: $driverInf" -type start

try {
	LogWrite "PNP the Driver $driverInfFile" -type i
	& $PNPUtil  /add-driver $driverInfFile
    
    LogWrite "Add Printer Driver: $driverName" -type i
	Add-PrinterDriver $driverName
    
    LogWrite "Create the printer: $printerNameBnW" -type i
    Add-PrinterPort         -Name $PrinterPortNameBnW       -PrinterHostAddress $printerIP
    Add-Printer             -Name $PrinterNameBnW           -PortName $PrinterPortNameBnW   -DriverName $driverName
    Set-PrintConfiguration  -PrinterName $PrinterNameBnW    -PaperSize A4                   -Color $false


    LogWrite "Create the printer: $printerNameColor" -type i
    Add-PrinterPort         -Name $printerPortNameColor     -PrinterHostAddress $printerIP
    Add-Printer             -Name $printerNameColor         -PortName $PrinterPortNameColor -DriverName $driverName
    Set-PrintConfiguration  -PrinterName $printerNameColor  -PaperSize A4                   -Color $true
    $defaultPrinter = Get-WMIObject -ClassName win32_printer | Where-Object -Property Name -eq "Maximus Printer Color"
    $defaultPrinter.SetDefaultPrinter()  | Out-Null

    #End of Script
    LogWrite "$eventlogSource script completed successfully - $TimeDate" -type end
}
catch [system.exception] {
	$err = $_.Exception.Message
	LogWrite "Unable to deploy printer driver, error:`r`n$err" -type e
    
    #End of Script
    LogWrite "$eventlogSource script completed unsuccessfully - $TimeDate" -type end
} 

Add-content -path C:\itc\Security_Group_List.txt -value "Completed"

#after installation, all the driver and useless files needed to be removed on user computer.
# Specify the directory path

$directory = "c:\PrinterITC\Printerdrivercollection"

# Check if the directory exists
if (Test-Path -Path $directory -PathType Container) {
    # Remove all files within the directory
    Get-ChildItem -Path $directory | Remove-Item -Force -recurse
    # Remove the directory itself
    Remove-Item -Path $directory -Force
    Write-Output "The directory $directory and all its contents have been removed."
} else {
    Write-Output "Directory $directory does not exist."
}

#test
