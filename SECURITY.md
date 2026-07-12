# Security Policy

## Reporting A Vulnerability

Do not open a public issue for vulnerabilities that could expose user files,
credentials, command execution, package sources, or restore data.

Use GitHub's private vulnerability reporting for this repository when it is
available. Otherwise contact Angel Gonzalez through the private contact method
listed on the GitHub profile associated with this repository.

Include the affected command, platform, reproduction steps, expected behavior,
and potential impact. Remove real credentials and personal paths from logs.

## Supported Version

The latest commit on `main` is supported. This project does not currently
maintain older release branches.

## Security Expectations

- Existing configuration must be backed up before replacement.
- Dry-run must not modify persistent user state.
- Restore must refuse to overwrite post-install user changes.
- Installers must not overwrite unrelated commands.
- Backup manifests and custom paths must remain inside their documented trust boundaries.
- Errors after configuration backup begins must trigger rollback.
- Downloads must use HTTPS and documented upstream sources.
- Secrets and machine-specific private values must never be tracked.
