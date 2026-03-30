# git bisect run

## Description

`git bisect` uses binary search to find the commit that introduced a bug. Instead of manually marking commits as good/bad, `git bisect run` automates it — you give it a command (like `dart test`), and Git decides based on the exit code:

| Exit code       | Meaning                                 |
| --------------- | --------------------------------------- |
| 0               | Good commit                             |
| 1-124, 126, 127 | Bad commit                              |
| 125             | Skip (can't test, e.g. doesn't compile) |

## Example with this project

This project has a deliberate bug introduced in one of its commits. You can find it automatically:

```bash
# Start bisect
git bisect start
git bisect bad HEAD                    # current commit is broken
git bisect good 05f5f5c               # first commit was working fine

# Automated run — let the tests decide good/bad
# Note: bisect checks out at repo root, so we cd into the subproject
git bisect run sh -c 'cd github/git-tips && dart test test/main_test.dart'

# Git finds the first bad commit automatically

# Done — clean up
git bisect reset
```

## Real-world example

Say a test started failing at some point in your project. You'd do:

```bash
# Clone and enter
git clone https://github.com/tsinis/functional_status_codes.git
cd functional_status_codes

# Start bisect
git bisect start
git bisect bad HEAD                    # current commit is broken
git bisect good v0.1.0                 # this tag was working fine

# Automated run — let the tests decide good/bad
git bisect run dart test test/functional_status_codes_test.dart

# Git outputs something like:
# abc123def is the first bad commit
# Author: ...
# Date: ...
# "refactor: changed status code mapping"

# Done — clean up
git bisect reset
```

## Tips

- The command you pass to `bisect run` can be anything — a test runner, a script, a linter.
- For projects that don't compile on some commits, wrap your command in a script that returns 125 on build failure:

```bash
#!/bin/sh
dart compile exe bin/main.dart || exit 125
dart test
```
