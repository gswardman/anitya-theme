# Anitya Theme (Shopify) — Git Rules

Read this at the start of every agent session.

## Rules

1. **main is what is live.** The Shopify GitHub integration syncs main to the live theme. Nothing sits on main that is not ready to be seen by customers.
2. **One branch per piece of work.** Names: `shop/<thing>` (e.g. `shop/home-page`). Never work on main directly.
3. **One open shop branch at a time.** That is what stops the pile-up.
4. **Every branch has a preview.** A draft theme connected to the branch. Geordie looks at the preview and says OK.
5. **OK means merge, then clean up in the same step.** Merge to main (squash, one clear commit message), delete the branch, delete the preview theme, tag the release `live-YYYY-MM-DD`.
6. **No uncommitted work at the end of a session.** Anything unfinished is committed and pushed to its branch, with a line in STATE.md saying what it is.
7. **Nothing is deleted without a tag first.** Tag the old branch `archive/<name>`, then delete. The work is always recoverable.

## Shopify specifics

- **Live theme connected to main.** Merging to main updates the live site.
- **Edits in the Shopify theme editor commit straight to whatever branch the theme is connected to.** On the live theme that means main. Pull main before starting any branch.
- **Keep one rollback theme.** After each go-live, keep a copy named `backup-live-YYYY-MM-DD`. Delete the previous one. Rollback: publish the backup, then `git revert` the merge on main.
- **Preview themes die after merge.** Shopify has a theme cap and old drafts confuse everyone.
- **No deletions before 30 Nov 2026.** The theme is still in flux. Unused files stay until the dust settles.

## End-of-session checklist

1. Working tree clean (committed or stashed, pushed to branch).
2. STATE.md updated: current branch, preview link, what is waiting on Geordie.
3. One line appended to the daily log.
