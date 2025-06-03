# PowerShell script for offboarding automation
param(
    [string]$UserPrincipalName
)

# Offboarding steps for $UserPrincipalName

# Import Active Directory module
Import-Module ActiveDirectory

Write-Host "Offboarding user: $UserPrincipalName"

# 1. Disable user in on-premises Active Directory
Write-Host "Disabling user account in Active Directory..."
Disable-ADAccount -Identity $UserPrincipalName

# 2. Remove user from all groups (licensing, application access, privileged roles)
Write-Host "Removing user from all groups..."
$groups = Get-ADUser -Identity $UserPrincipalName -Properties MemberOf | Select-Object -ExpandProperty MemberOf
foreach ($group in $groups) {
    Remove-ADGroupMember -Identity $group -Members $UserPrincipalName -Confirm:$false
}

# 3. Trigger or document hybrid sync to Entra (AD Connect)
Write-Host "Triggering AD Connect sync (placeholder)..."
# Start-ADSyncSyncCycle -PolicyType Delta
Write-Host "If direct automation is not possible, ensure a hybrid sync is triggered via AD Connect to update Entra ID."