# Employment Hero to Entra API-driven Inbound Provisioning Script
# --------------------------------------------------------------
# This script demonstrates the end-to-end flow for integrating Employment Hero (HR system)
# with Microsoft Entra ID using the API-driven inbound provisioning model.
#
# References:
# - API-driven provisioning concepts: https://learn.microsoft.com/en-us/entra/identity/app-provisioning/inbound-provisioning-api-concepts#end-to-end-flow
# - Bulk upload endpoint: https://learn.microsoft.com/en-us/graph/api/synchronization-synchronizationjob-post-bulkupload
# - Employment Hero API: https://developer.employmenthero.com/reference/get-employees
# - SCIM schema: https://learn.microsoft.com/en-us/azure/active-directory/app-provisioning/use-scim-to-provision-users

param (
    [string]$EmploymentHeroApiKey = $env:EMPLOYMENT_HERO_API_KEY,
    [string]$BulkUploadEndpoint = "<ENTER_BULKUPLOAD_ENDPOINT_URL>",
    [string]$BearerToken = "<ENTER_OAUTH_BEARER_TOKEN>"
)

# 1. Extract workforce data from Employment Hero
# ---------------------------------------------
# Replace this with actual API call and paging logic as needed.
Write-Host "Extracting workforce data from Employment Hero..."
$headers = @{
    "Authorization" = "Bearer $EmploymentHeroApiKey"
    "Accept" = "application/json"
}
# Placeholder: Uncomment and implement for production use
# $ehResponse = Invoke-RestMethod -Uri "https://api.employmenthero.com/v1/employees" -Headers $headers
# $ehUsers = $ehResponse.data

# For demonstration, use a sample user
$ehUsers = @(
    @{
        id = "12345"
        email = "jane.doe@example.com"
        first_name = "Jane"
        last_name = "Doe"
        hire_date = "2025-06-01"
    }
)

# 2. Transform data to SCIM schema for Entra /bulkUpload
# ------------------------------------------------------
# See: https://learn.microsoft.com/en-us/azure/active-directory/app-provisioning/use-scim-to-provision-users
Write-Host "Transforming Employment Hero data to SCIM schema..."
$scimUsers = $ehUsers | ForEach-Object {
    @{
        method = "POST"
        path = "/Users"
        bulkId = $_.id
        data = @{
            schemas = @("urn:ietf:params:scim:schemas:core:2.0:User")
            userName = $_.email
            name = @{
                givenName = $_.first_name
                familyName = $_.last_name
            }
            emails = @(@{ value = $_.email; type = "work"; primary = $true })
            externalId = $_.id
            # Map hire date for onboarding workflow triggers
            "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User" = @{
                employeeNumber = $_.id
                hireDate = $_.hire_date
            }
        }
    }
}
$scimBulk = @{
    schemas = @("urn:ietf:params:scim:api:messages:2.0:BulkRequest")
    Operations = $scimUsers
}
$scimJson = $scimBulk | ConvertTo-Json -Depth 10

# 3. Upload SCIM data to Entra /bulkUpload endpoint
# -------------------------------------------------
# See: https://learn.microsoft.com/en-us/graph/api/synchronization-synchronizationjob-post-bulkupload
Write-Host "Uploading SCIM data to Entra /bulkUpload endpoint..."
$uploadHeaders = @{
    "Authorization" = "Bearer $BearerToken"
    "Content-Type" = "application/json"
}
# Placeholder: Uncomment for production use
# $response = Invoke-RestMethod -Method Post -Uri $BulkUploadEndpoint -Headers $uploadHeaders -Body $scimJson

Write-Host "Upload complete. Check provisioning logs in Entra portal for status."

# 4. Ensure onboarding workflow is triggered
# ------------------------------------------
# The onboarding workflow in Entra Lifecycle Workflows should be configured to trigger on employeeHireDate or other mapped attributes.
# See: https://learn.microsoft.com/en-us/entra/identity/governance/lifecycle-workflows-onboarding