# Usage Examples

## CI/CD Deployment

1. Configure environment parameters in `parameters/environments/`.
2. Update role and entitlement definitions as needed.
3. Use onboarding/offboarding scripts and templates to automate user lifecycle.
4. Deploy Bicep templates using Azure CLI or pipelines:
   ```sh
   az deployment group create --resource-group <rg> --template-file onboarding/templates/user-onboarding.bicep --parameters ...
   ```
5. Integrate PowerShell scripts into automation workflows for user provisioning and deprovisioning.

## Example Scenarios

- Automated onboarding for new employees with group assignment and license provisioning.
- Scheduled access reviews for compliance.
- Privileged access management with PIM and recurring reviews.

Refer to the root README and other docs for structure and parameterization details.