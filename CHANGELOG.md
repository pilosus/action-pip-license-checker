# Change Log

All notable changes to this project will be documented in this file.
This change log follows the conventions of [keepachangelog.com](http://keepachangelog.com/).

## [Unreleased]

## [v1.0.0-rc2] - 2023-02-25

### Changed

- Used `pip-license-checker` version [0.44.0](https://github.com/pilosus/pip-license-checker/blob/main/CHANGELOG.md): no breaking changes, bugfixes only

## [v1.0.0-rc1] - 2023-02-20

### Changed
- Action code is rewritten from `bash` to `babashka`
  ([#31](https://github.com/pilosus/action-pip-license-checker/issues/31))

## [v0.9.0] - 2023-02-18

See changelog for:
- [v0.9.0-rc1]
- [v0.9.0-rc2]


## [v0.9.0-rc2] - 2023-02-12

### Changed
- Input field `with-totals` deprecated, use `totals` instead.
- Input field `table-headers` deprecated, use `headers` instead.

## [v0.9.0-rc1] - 2023-02-11

### Changed
- Used `pip-license-checker` version [0.43.0](https://github.com/pilosus/pip-license-checker/blob/main/CHANGELOG.md)

### Added
- Input field `verbose` supports integer values: `0` (non-verbose),
  `1` (errors), `2` (errors, info), `3` (errors, info, debug) that
  correspond to a upstream's
  [pip-license-checker](https://github.com/pilosus/pip-license-checker)
  cumulative `-v` option.

### Fixed
- Yanked versions of native Python packages are now checked in case of
  [exact version
  matching](https://peps.python.org/pep-0440/#version-matching) or
  [arbitrary
  equality](https://peps.python.org/pep-0440/#arbitrary-equality)
  [#125](https://github.com/pilosus/pip-license-checker/issues/125)
- Bug with pre-release versions resolution for native Python packages
  fixed
  [#126](https://github.com/pilosus/pip-license-checker/issues/126)

## [v0.8.1] - 2023-01-16
### Fixed
- Addressed a bug with Python package version parsing for
  PEP517-non-compliant packages by bumping `pip-license-checker`
  version to
  [0.42.1](https://github.com/pilosus/pip-license-checker/blob/main/CHANGELOG.md)

## [v0.8.0] - 2023-01-10
### Changed
- Used `pip-license-checker` version [0.42.0](https://github.com/pilosus/pip-license-checker/blob/main/CHANGELOG.md)

## [v0.8.0-rc1] - 2022-12-30
### Changed
- Used `pip-license-checker` version `0.42.0-SNAPSHOT` to migrate over
  PyPI Simple API for releases information

## [v0.7.1] - 2022-12-02
### Changed
- Used `pip-license-checker` version `0.39.0` with error handling &
  verbosity improved

## [v0.7.0] - 2022-11-28
### Added
- `github-token` input field for GitHub OAuth Token to increase
  rate-limits when requesting GitHub API. Recommended to keep a token
  as a GitHub secret.
- `verbose` input field to make output verbose for exceptions
  visibility. `Misc` column is added to a report for errors output.

## [v0.6.3] - 2022-10-15
### Fixed
- Remove deprecated GitHub Actions
  [set-out](https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/),
  use proper
  [multiline](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#multiline-strings)
  string output - by [pachay](https://github.com/pachay),
  [kulapard](https://github.com/kulapard), and
  [pilosus](https://github.com/pilosus)

## [v0.6.2] - 2022-06-25
### Fixed
- Docker image version of `pip-license-checker` bumped to `0.33.0` to
  fix parsing long numbers in Python package versions,
- Deps updates and security updates

## [v0.6.1] - 2021-11-19
### Changed
- Docker image version of `pip-license-checker` bumped to `0.31.0` to
  support both `zlib` and `zlib/libpng` licenses

## [v0.6.0] - 2021-09-13
### Added
- `formatter` input field for printf-style formatting string to format report.

## [v0.5.0] - 2021-08-30
### Changed
- Docker image version of `pip-license-checker` bumped to `0.28.1` to
  support `csv` external file options.

## [v0.4.0] - 2021-08-28
### Changed
- Docker image version of `pip-license-checker` bumped to `0.26.0`.

### Added
- `external-format` input field to specify one of the supported
  external file formats (`csv`, `cocoapods`, `gradle` at the time of
  writing).
- `external-options` input field to alter external file
  processing. Options are specific for each `external-format`.

### Removed
- `no-external-csv-headers` input field.
  Use `externa-options` instead (e.g. `{:skip-header false}`).

## [v0.3.0] - 2021-08-15
### Fixed
- External CSV file support.

### Added
- Multiple items separated by comma for input fields `requirements`,
  `external`, `fail` in the format: `item1,item2,item3`.
- Input `fails-only` field to print only packages of license types
  specified with `fail` input.

### Changed
- `pip-license-checker` docker image verions bumped to 0.22.0

## [v0.2.0] - 2021-08-14
### Added
- Support `pip-license-checker` v0.21.0 with breaking changes,
  see [original CHANGELOG](https://github.com/pilosus/pip-license-checker/blob/main/CHANGELOG.md).
- Input `external` field to provide CSV files with package and license names.
- Input `no-external-csv-headers` field for external CSV files without header line.

## [v0.1.2] - 2021-07-11
### Fixed
- Output license check result for debugging
- Example usage extended with printing nicely formatted report
- Input `requirement` description fixed (default value)

## [v0.1.1] - 2021-07-10
### Added
- Changelog
- Readme disclaimer section

### Fixed
- Multiline output string formatting fixed as per the [workaround](https://github.community/t/set-output-truncates-multiline-strings/16852)

## v0.1.0 - 2021-07-10
### Added
- MVP

[Unreleased]: https://github.com/pilosus/action-pip-license-checker/compare/v1.0.0-rc2...HEAD
[v1.0.0-rc2]: https://github.com/pilosus/action-pip-license-checker/compare/v1.0.0-rc1...v1.0.0-rc2
[v1.0.0-rc1]: https://github.com/pilosus/action-pip-license-checker/compare/v0.9.0...v1.0.0-rc1
[v0.9.0]: https://github.com/pilosus/action-pip-license-checker/compare/v0.9.0-rc2...v0.9.0
[v0.9.0-rc2]: https://github.com/pilosus/action-pip-license-checker/compare/v0.9.0-rc1...v0.9.0-rc2
[v0.9.0-rc1]: https://github.com/pilosus/action-pip-license-checker/compare/v0.8.1...v0.9.0-rc1
[v0.8.1]: https://github.com/pilosus/action-pip-license-checker/compare/v0.8.0...v0.8.1
[v0.8.0]: https://github.com/pilosus/action-pip-license-checker/compare/v0.8.0-rc1...v0.8.0
[v0.8.0-rc1]: https://github.com/pilosus/action-pip-license-checker/compare/v0.7.1...v0.8.0-rc1
[v0.7.1]: https://github.com/pilosus/action-pip-license-checker/compare/v0.7.0...v0.7.1
[v0.7.0]: https://github.com/pilosus/action-pip-license-checker/compare/v0.6.3...v0.7.0
[v0.6.3]: https://github.com/pilosus/action-pip-license-checker/compare/v0.6.2...v0.6.3
[v0.6.2]: https://github.com/pilosus/action-pip-license-checker/compare/v0.6.1...v0.6.2
[v0.6.1]: https://github.com/pilosus/action-pip-license-checker/compare/v0.6.0...v0.6.1
[v0.6.0]: https://github.com/pilosus/action-pip-license-checker/compare/v0.5.0...v0.6.0
[v0.5.0]: https://github.com/pilosus/action-pip-license-checker/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/pilosus/action-pip-license-checker/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/pilosus/action-pip-license-checker/compare/v0.2.0...v0.3.0
[v0.2.0]: https://github.com/pilosus/action-pip-license-checker/compare/v0.1.2...v0.2.0
[v0.1.2]: https://github.com/pilosus/action-pip-license-checker/compare/v0.1.1...v0.1.2
[v0.1.1]: https://github.com/pilosus/action-pip-license-checker/compare/v0.1.0...v0.1.1
