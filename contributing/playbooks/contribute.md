# Prepare A Contribution

1. Read `AGENTS.md`, `CONTRIBUTING.md`, and files surrounding the change.
2. Keep the change focused and preserve unrelated user modifications.
3. Add regression coverage proportional to user impact.
4. Update help and docs for every public behavior change.
5. Run `npm run check`, `git diff --check`, and inspect `git diff`.
6. Scan staged paths and content for secrets or local machine data.
7. Write a PR summary with the problem, solution, safety implications, and
   exact verification performed.
