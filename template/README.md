# Ignyte DevOps Modules and Templates Repository

This **devops** repository serves as a centralized reference for Bicep modules and pipeline templates, promoting consistency and reusability across the project. Please review the guidelines below on naming conventions and branching strategy to keep things consistent and organized.

## Naming Conventions Guide

This repository follows strict naming conventions to ensure consistency and clarity across all files, folders, and variables.

### Repository Name
- **devops** (all lowercase, no spaces)

### Folder Names
- Use lowercase with dashes
- Examples: `apim`, `bicep-validate`, `aks-network`

### Bicep Modules
- **File Name**: `main.bicep` (unless a more descriptive name is needed)
- **Parameters/Outputs**: Use `camelCase`

### YAML Pipeline Templates
- **Template File Names**: lowercase with dashes, ending in `-template.yml`
  - Example: `deploy-apim-template.yml`
- **Variables**: Use `camelCase`

### Documentation
- Each module and template folder must include a `README.md` explaining usage, inputs, outputs, and parameters.


## 📌 Branching Strategy

This repository follows a **main/feature branch model** to ensure clean, controlled, and collaborative development.

### 🔹 Main Branch

- The `main` branch serves as the **primary branch** (equivalent to `master`).
- All production-ready Bicep templates and pipeline configurations reside here.
- Only **approved pull requests** are merged into `main`.

### 🔸 Feature Branches

- DevOps/Cloud Infra must create **feature branches** from `main` for any new feature updates.
- **Purpose:** Indicates that the branch is for a new feature.
- Naming convention: `feature/<authorname>/<storynumber>-<short-title>` (e.g. `feature/ross/12345-add-storage-module`)
- All changes must go through a **pull request (PR)** process.
- PRs should include:
  - A clear description of the changes
  - Associated work items (if applicable)
  - Review and approval from at least one team member
- All pipeline runs using this branch should only apply changes to development environments.

### 🔸 PR Branches

- DevOps/Cloud Infra must create **pr branches** from `main` for any new work or updates.
- **Purpose:** used to track pull requests or tie branches directly to a story/ticket number.
- Naming convention: `pr/<authorname>/<storynumber>-<short-title>` (e.g. `pr/ross/12345-add-storage-module`)
- All pipeline runs using this branch should only apply changes to development environments.

### ✅ Pull Request Workflow

1. Create a feature/pr branch from `main`.
2. Make and commit your changes.
3. Push the branch to the remote repository.
4. Open a pull request targeting `main`.
5. Request reviews and address feedback.
6. Once approved, the PR can be merged into `main`.

---

By following this strategy, we ensure:
- Code quality through peer reviews
- Traceability of changes
- A stable and reliable `main` branch for deployments

