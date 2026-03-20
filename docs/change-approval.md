# Change Approval

Production changes must be launched from the `prod` branch with a manual `workflow_dispatch`.

Approval expectations:

- the GitHub `prod` environment should require reviewers
- the approver checks release notes, rollback notes, and the prod checklist
- only reviewed changes promoted from `main` should be released

Minimum approval record:

- release owner
- approver
- commit SHA
- validation date
- rollback target commit
