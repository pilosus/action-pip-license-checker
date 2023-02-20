## Contributing

### General rules

1. Before writing any *code* take a look at the existing
   [issues](https://github.com/pilosus/action-pip-license-checker/issues?q=).
   If none of them is about the changes you want to contribute, open
   up a new issue. Fixing a typo requires no issue though, just submit
   a Pull Request.

2. If you're looking for an open issue to fix, check out
   labels `help wanted` and `good first issue` on GitHub.

3. If you plan to work on an issue open not by you, write about your
   intention in the comments *before* you start working.


### Development rules

1. Follow the GitHub [fork & pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork) flow.

2. Install [babashka](https://github.com/babashka/babashka/)

3. Make changes to the code.

4. Make sure tests pass:

```
$ bb test
```

5. Open a pull request, refer to the issue you solve.

6. Make sure GitHub Checks (Actions) pass.
