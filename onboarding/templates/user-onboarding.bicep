// Bicep template for user onboarding resources
param userPrincipalName string
param displayName string
param department string

resource user 'Microsoft.Entra/Users@1.0.0' = {
  name: userPrincipalName
  properties: {
    displayName: displayName
    department: department
    accountEnabled: true
  }
}

// Assign user to groups (cloud)
// resource groupMembership 'Microsoft.Entra/groups/members@1.0.0' = {
//   name: 'group-object-id/${userPrincipalName}'
//   properties: {
//     memberId: userPrincipalName
//   }
// }

// Assign license (cloud)
// resource licenseAssignment 'Microsoft.Entra/users/licenseAssignments@1.0.0' = {
//   name: '${userPrincipalName}/ENTERPRISEPACK'
//   properties: {
//     skuId: 'ENTERPRISEPACK'
//   }
// }

// Note: All user provisioning is handled via Microsoft Entra ID (cloud-based).
// Application and privileged group assignments are handled by onboarding/scripts/onboarding.ps1
