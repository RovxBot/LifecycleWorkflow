# Parameterization

All configuration is parameterized using YAML files under the `parameters/` directory:
- `global.yaml`: Tenant-wide and company-wide settings.
- `roles.yaml`: Role definitions for access and workflow assignment.
- `environments/`: Environment-specific overrides (dev, prod, test).

Workflows, scripts, and templates reference these parameters for DRY configuration and safe, repeatable deployments across environments.