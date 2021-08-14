# GitHub Action for Python dependencies license check

Check Python PyPI package license names and types (permissive, copyleft, etc.) with
[pip-license-check](https://github.com/pilosus/pip-license-checker) tool in GitHub Actions.

Check license types for any list of dependencies with given license names too!

## Usage examples

### Check explicit Python dependencies list for copyleft licenses

```yaml
jobs:
  license_check:
    runs-on: ubuntu-18.04
    steps:
    - name: Checkout the code
      uses: actions/checkout@v2.3.4
      with:
        fetch-depth: 0
    - name: Check Python dependencies license names and type
      id: license_check_report
      uses: pilosus/action-pip-license-checker@v0.2.0
      with:
        requirements: 'requirements.txt'
        fail: 'Copyleft'
        exclude: '^(pylint|aio[-_]*).*'
        with-totals: true
        table-headers: true
    - name: Print report
      if: ${{ always() }}
      run: echo "${{ steps.license_check_report.outputs.report }}"
```

### Check all packages including transitive dependencies

```yaml
jobs:
  license_check:
    runs-on: ubuntu-18.04
    steps:
    - name: Checkout the code
      uses: actions/checkout@v2.3.4
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
      uses: pilosus/action-pip-license-checker@v0.2.0
      with:
        requirements: 'requirements-all.txt'
        fail: 'Copyleft'
        exclude: 'pylint.*'
    - name: Print report
      if: ${{ always() }}
      run: echo "${{ steps.license_check_report.outputs.report }}"
```

### Check CSV file with given package and license names

```yaml
jobs:
  license_check:
    runs-on: ubuntu-18.04
    steps:
    ...
    - name: Check CSV file without headers
      id: license_check_report
      uses: pilosus/action-pip-license-checker@v0.2.0
      with:
        external: 'node_modules_licenses.csv
        no-external-csv-headers: true
    ...
```

Integration examples: [workflow](https://github.com/pilosus/piny/pull/134/files),
[action run 1](https://github.com/pilosus/piny/runs/3051101459?check_suite_focus=true),
[action run 2](https://github.com/pilosus/piny/runs/3330267456?check_suite_focus=true)


## Inputs

All the inputs correspond with `pip-license-checker`'s
[options](https://github.com/pilosus/pip-license-checker#help).

### `requirements`

**Required** Path to requirements file. Defaults to `"requirements.txt"`.

### `external`

Path to CSV file in format: `package_name,license_name[,...]`.

Used to check license types for the list of given packages with their
licenses.

Allows to check license types for JavaScript, Java or any other
dependencies with known licenses.

### `fail`

Return non-zero exit code if license type provided via the input is found.
Use one of the following values:

- `Copyleft` (See [Software licenses and copyright law](https://en.wikipedia.org/wiki/Software_license#Software_licenses_and_copyright_law)
- `Permissive`
- `Other` (EULA, other non standard licenses)
- `Error` (package or its license not found)

### `exclude`

Regular expression (PCRE) to exclude matching packages from the check.

### `pre`

Include pre-release and development versions.

### `with-totals`

Print totals for license types found. Totals appended after the detailed list of the packages.

### `totals-only`

Print only totals for license types found, do not include the detailed list of the packages checked.

### `table-headers`

Print table headers for detailed list of the packages.

### `no-external-csv-headers`

CSV file provided via external input does not contain header line.
By default a CSV file is assumed to have headers.

## Outputs

### `report`

Formatted plain text representation of the license check.


## Disclaimer

Software is provided on an "as-is" basis and makes no warranties
regarding any information provided through it, and disclaims liability
for damages resulting from using it. Using the software does not
constitute legal advice nor does it create an attorney-client
relationship.
