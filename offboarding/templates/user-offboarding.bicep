// Bicep template for user offboarding resource cleanup
param userPrincipalName string

// Note: User disablement/removal is handled via PowerShell script:
// See: ./../scripts/offboarding.ps1
// Steps performed:
//   1. Disable user in on-premises Active Directory
//   2. Remove user from all groups (licensing, application access, privileged roles)
//   3. Trigger/document hybrid sync to Entra (AD Connect)
// If direct automation is not possible, ensure a hybrid sync is triggered via AD Connect to update Entra ID.
// This template can be extended to remove user from Azure groups, revoke roles, etc.

// Example placeholder for group removal
// resource groupMembership 'Microsoft.Authorization/groupAssignments@2020-10-01' = {
//   name: 'remove-user-from-group'
//   properties: { ... }
// }
