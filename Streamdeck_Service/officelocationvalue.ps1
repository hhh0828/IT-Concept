# Define the new office location
#$newOfficeLocation = "OCHANG"
#$companyn = "KSMM"
$usagelocation1 = "KR"
# Define a list of UserPrincipalNames to update
$userPrincipalNamesToUpdate3 = @(
"Rhyubj@asm-au.com",
"kimjw@asm-au.com",


)

# Update the OfficeLocation property for each user in the list
foreach ($userPrincipalName in $userPrincipalNamesToUpdate3) {
    # Get the user object
    $user = Get-AzureADUser -ObjectId $userPrincipalName

    # Update the OfficeLocation property
    #Set-AzureADUser -ObjectId $user.ObjectId -companyname $newOfficeLocation
    Set-AzureADUser -ObjectId $user.ObjectId -usagelocation $usagelocation1
    Write-Host "Updated companyname for $userPrincipalName to $usagelocation1"
}