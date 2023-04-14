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

### Release managements

1. Follow the [SemVer](https://semver.org/) conventions for the release number.
2. Update the [CHANGELOG](https://github.com/pilosus/action-pip-license-checker/blob/main/CHANGELOG.md).
3. Update the [README](https://github.com/pilosus/action-pip-license-checker/blob/main/README.md) if needed.
4. Merge the changes to the `main` branch.
5. Push a version-specific tag, e.g. `v2.1.9`:

```
$ git tag v2.1.9
$ git push origin v2.1.9
```

6. Push a new or over a major version tag, e.g. `v2`.

```
# Delete the old local tag
$ git tag -d v2

# Add a new local tag
$ git tag v2

# Delete the old remote tag
$ git push -d origin v2

# Push the new remote tag
$ git push origin v2
```

7. Draft a new release on the
   [GitHub](https://github.com/pilosus/action-pip-license-checker/releases/new). Make
   sure the version-specific tag and the changelog are used for the
   release notes. Start a discussion thread for the release. Publish
   links to the testing if needed (may be a good idea for release
   candidates).
