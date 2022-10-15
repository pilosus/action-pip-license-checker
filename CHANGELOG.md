# Change Log

All notable changes to this project will be documented in this file.
This change log follows the conventions of [keepachangelog.com](http://keepachangelog.com/).

## [Unreleased]
### Fixed
- Nothing here yet

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


[Unreleased]: https://github.com/pilosus/pip-license-checker/compare/v0.6.3...HEAD
[v0.6.3]: https://github.com/pilosus/pip-license-checker/compare/v0.6.2...v0.6.3
[v0.6.2]: https://github.com/pilosus/pip-license-checker/compare/v0.6.1...v0.6.2
[v0.6.1]: https://github.com/pilosus/pip-license-checker/compare/v0.6.0...v0.6.1
[v0.6.0]: https://github.com/pilosus/pip-license-checker/compare/v0.5.0...v0.6.0
[v0.5.0]: https://github.com/pilosus/pip-license-checker/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/pilosus/pip-license-checker/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/pilosus/pip-license-checker/compare/v0.2.0...v0.3.0
[v0.2.0]: https://github.com/pilosus/pip-license-checker/compare/v0.1.2...v0.2.0
[v0.1.2]: https://github.com/pilosus/pip-license-checker/compare/v0.1.1...v0.1.2
[v0.1.1]: https://github.com/pilosus/pip-license-checker/compare/v0.1.0...v0.1.1
