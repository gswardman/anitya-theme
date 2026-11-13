# Anitya Theme — Git Rules

1. **Live = main.** The Shopify GitHub integration syncs `main` to the live theme. Never push to main unless the change is ready for customers.
2. **One branch per piece of work.** Name it `<topic>-YYYY-MM-DD` (e.g. `home-page-2026-11-13`). Merge to main only after Geordie approves the preview.
3. **Clean tree at end of session.** Commit or stash everything before signing off. No orphaned local changes.
4. **Tag go-lives.** After a branch merges and is confirmed live, tag it `live-YYYY-MM-DD-<topic>`.
5. **Deletions on a cleanup branch after tagging.** Never delete sections, templates or assets on the same branch that ships new work. Tag the go-live first, then open a separate `cleanup-YYYY-MM-DD` branch.
6. **No deletions before 30 Nov 2026.** The theme is still in flux. Unused files stay until the dust settles.
