# 📝 Release Notes

## v1.0.0 – July 24, 2025 - Jayr Abawag

- Initial release of modular Bicep pipeline
- Added `Lint`, `Validate`, `Preview`, and `Deploy` stages
- Conditional logic added for deployment mode execution
- Parameterized for environment and module input
- Implemented triggers for main and feature branches
- Preview mode uses Azure CLI `what-if` for safe review
- Captures deployment outputs into variables for later use
- Support deployment for non-structured directory, by allowing explicit path via variables

## [Future]
- Add support for feature-based deployment triggers
- Implement automated rollback on failed deployments
- Integrate security scanning for Bicep templates
- Secure tasks and stages using conditions
- Add approval gates for critical deployments (PRD)
- Support resources beyond APIM modules
- Enhance deployment condition: restrict deployment to main branch only if PR
- Support deployment non structured dir via path variables