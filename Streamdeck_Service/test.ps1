
$users = Get-AzureAdUser -All $true

$LusersArray = New-Object System.Collections.Generic.List[System.Object]
foreach ($user in $users) {
    
    $assignedLicenses = $user.AssignedLicenses

    
    if ($assignedLicenses.Count -gt 0) {
       
        foreach ($license in $assignedLicenses) 
	{

        if ($User.usagelocation -eq "KR"){
		if ($license.SkuId -eq "cbdc14ab-d96c-4c30-b9f4-6ada7cdc1d46"){
            	Write-Host "UserPrincipalName: $($user.UserPrincipalName), $($user.department), $($user.usagelocation), $($user.companyname), $($user.PhysicalDeliveryOfficeName)"
                                
                $LusersArray += $user.UserPrincipalName
		}
    	}
    }
}
}

write-host $Lusers