# GitHub Action for detecting license names and types

Detect license names and types for Python PyPI packages. Identify
license types for given license names obtained by third-party
tools. Great coverage of free/libre and open source licenses of all
types:
[public domain](https://en.wikipedia.org/wiki/Public-domain-equivalent_license),
[permissive](https://en.wikipedia.org/wiki/Permissive_software_license),
[copyleft](https://en.wikipedia.org/wiki/Copyleft).

Supported formats:

- **Python**: packages or `requirements.txt` (detect license name and license type)
- **JavaScript**: CSV files generated by [license-checker](https://www.npmjs.com/package/license-checker) (detect license type)
- **iOS**: Apple Plist files generated by [CocoaPods Acknowledgements plugin](https://github.com/CocoaPods/cocoapods-acknowledgements) (detect license type)
- **Android**: JSON files generated by [Gradle License Plugin](https://github.com/jaredsburrows/gradle-license-plugin) (detect license type)
- **Other**: CSV files with package name and license name columns (detect license type).

Based on [pip-license-check](https://github.com/pilosus/pip-license-checker) command-line tool.

## Usage examples

### Check all Python packages including transitive dependencies

```yaml
jobs:
  license_check:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout the code
      uses: actions/checkout@v2
      with:
        fetch-depth: 0
    - name: Setup Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.6'
    - name: Get explicit and transitive dependencies
      run: |
        pip install -r requirements.txt
        pip freeze > requirements-all.txt
    - name: Check python
      id: license_check_report
      uses: pilosus/action-pip-license-checker@v0.8.0-rc1
      with:
        requirements: 'requirements-all.txt'
        fail: 'Copyleft'
        exclude: '(?i)^(pylint|aio[-_]*).*'
    - name: Print report
      if: ${{ always() }}
      run: echo "${{ steps.license_check_report.outputs.report }}"
```

### Check CSV file generated by JavaScript `license-checker` package

```yaml
jobs:
  license_check:
    runs-on: ubuntu-lastest
    steps:
    ...
    - name: Check license-checker CSV file without headers
      id: license_check_report
      uses: pilosus/action-pip-license-checker@v0.8.0-rc1
      with:
        external: 'npm-license-checker.csv'
        external-format: 'csv'
        external-options: '{:skip-header true}'
        fail: 'StrongCopyleft,NetworkCopyleft,Other,Error'
        fails-only: true
        exclude: 'your-company-name.*'
        exclude-license: '(?i)copyright'
        totals: true
        verbose: true
        github-token: ${{ secrets.OAUTH_TOKEN_GITHUB }}
        ...
```

### Check JSON file generated by Android `gradle-license-plugin` package

```yaml
jobs:
  license_check:
    runs-on: ubuntu-latest
    steps:
    ...
    - name: Check gradle-license-plugin JSON file
      id: license_check_report
      uses: pilosus/action-pip-license-checker@v0.8.0-rc1
      with:
        external: 'gradle-license-plugin.json'
        external-format: 'gradle'
        external-options: '{:fully-qualified-names false}'
        fail: 'StrongCopyleft,NetworkCopyleft,Other,Error'
        fails-only: true
        exclude: 'your-company-name.*'
        totals: true
        ...
```

### Check Plist file generated by iOS `cocoapods-acknowledgements` package

```yaml
jobs:
  license_check:
    runs-on: ubuntu-latest
    steps:
    ...
    - name: Check cocoapods-acknowledgements Plist file
      id: license_check_report
      uses: pilosus/action-pip-license-checker@v0.8.0-rc1
      with:
        external: 'cocoapods-acknowledgements.plist'
        external-format: 'cocoapods'
        external-options: '{:skip-header true :skip-footer true}'
        fail: 'StrongCopyleft,NetworkCopyleft,Other,Error'
        fails-only: true
        exclude: 'your-company-name.*'
        totals: true
        ...
```


### Supported file formats and their options

See the [documentation](https://github.com/pilosus/pip-license-checker#external-file-formats).

### Integration examples

- [Explicit dependencies only](https://github.com/pilosus/piny/pull/134/files)
  and its [action run](https://github.com/pilosus/piny/runs/3051101459?check_suite_focus=true)
- [Explicit and transitive dependencies](https://github.com/pilosus/piny/pull/140/files)
  and its [action run](https://github.com/pilosus/piny/runs/3330267456?check_suite_focus=true)
- [Third-party license list in CSV file](https://github.com/pilosus/piny/pull/141/files)
  and its [action run](https://github.com/pilosus/piny/runs/3333900660?check_suite_focus=true)


## Inputs

All the inputs correspond with `pip-license-checker`'s
[options](https://github.com/pilosus/pip-license-checker#help).

### `requirements`

Path to requirements file, e.g. `requirements.txt`. Separate multiple files with comma: `file1.txt,file2.txt,file3.txt`.

### `external`

Path to an external file. Separate multiple files with comma: `file1.csv,file2.csv,file3.csv`.

Used to check license types for the list of given packages with their
licenses.

Allows to check license types for JavaScript, Java or any other
dependencies with known licenses in one of the supported file formats.

### `external-format`

External file format: `csv`, `cocoapods`, `gradle`, etc.

See the full list of supported formats and their documentation
[here](https://github.com/pilosus/pip-license-checker#external-file-formats).

### `external-options`

String of options in [EDN format](http://edn-format.org/).

See the [documentation](https://github.com/pilosus/pip-license-checker#external-file-options) for more details.

### `fail`

Return non-zero exit code if license type provided via the input is found.
Use one of the following values:

- `WeakCopyleft`
- `StrongCopyleft`
- `NetworkCopyleft`
- `Copyleft` (includes all of above types of copyleft)
- `Permissive`
- `Other` (EULA, other non standard licenses)
- `Error` (package or its license not found)

Separate multiple license types with comma: `Copyleft,Other,Error`.

### `fails-only`

Print only packages of license types specified with `fail` input.

### `exclude`

Regular expression (PCRE) to exclude matching packages from the check.

### `exclude-license`

Regular expression (PCRE) to exclude matching license names from the check.

### `pre`

Include pre-release and development versions.

### `totals`

Print totals for license types found. Totals appended after the detailed list of the packages.

### `totals-only`

Print only totals for license types found, do not include the detailed list of the packages checked.

### `headers`

Print table headers for detailed list of the packages.

### `formatter`

Printf-style formatter string for report formatting. Default value is `%-35s %-55s %-30s`.

### `github-token`

GitHub OAuth Token to increase rate-limits when requesting GitHub
API. Recommended to keep a token as a GitHub secret.

### `verbose`

Make output verbose for exceptions visibility. `Misc` column is added
to a report for errors output.

## Outputs

### `report`

Formatted plain text representation of the license check.

## Disclaimer

Software is provided on an "as-is" basis and makes no warranties
regarding any information provided through it, and disclaims liability
for damages resulting from using it. Using the software does not
constitute legal advice nor does it create an attorney-client
relationship.
