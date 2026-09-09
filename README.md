# homebrew-tap

Personal Homebrew tap.

## git-cwt

Removes the git worktrees whose branch has already been merged — the worktree
counterpart to [`git-delete-merged-branches`](https://github.com/hartwork/git-delete-merged-branches)
(`git dmb`), which skips any branch that is checked out in a worktree and so
leaves them behind.

```console
$ brew install baptiste-pasquier/tap/git-cwt
$ git cwt                 # dry run
base origin/develop   gh: on (squash merges detected)

would remove .worktrees/fix-login-redirect          (merged into develop)
would remove .worktrees/pr-57                       (PR #57 merged)
        skip .worktrees/spike-caching               uncommitted changes
        skip .worktrees/release-notes               locked

2 to remove, 0 stale. Re-run with -y to apply.

$ git cwt -y              # apply
```

### What counts as merged

Two criteria, either one is enough:

1. The branch is contained in the base branch (`origin/HEAD`, or `-b <base>`).
2. `gh` reports a **merged pull request** for it. This is what catches
   squash-merged branches: squashing rewrites the commits, so such a branch is
   never an ancestor of the base and criterion 1 alone would miss it. Worktrees
   whose branch is named `worktree-pr-<n>` are resolved by PR number instead of
   by head branch.

Without an authenticated `gh`, the header says `gh: off` and only criterion 1
applies — expect squash-merged branches to be reported as `not merged`.

### What is never touched

The main worktree, the worktree you are standing in, locked worktrees, detached
HEADs, and any worktree holding uncommitted changes. A worktree whose directory
was deleted by hand is reported as stale and cleared with `git worktree prune`.

Branch deletion uses `git branch -d`, falling back to `-D` when git refuses.
That fallback is deliberate: `-d` measures merge status against your current
HEAD or the branch's upstream, never against the base branch, so it rejects
branches that landed on the base after you created your working branch.

### Options

| Option | Effect |
| --- | --- |
| `-n`, `--dry-run` | list what would be removed (default) |
| `-y`, `--yes` | remove the worktrees and delete their branches |
| `--no-fetch` | skip the initial `git fetch --prune` |
| `-b`, `--base` | base branch to compare against (default: `origin/HEAD`) |

## License

MIT
