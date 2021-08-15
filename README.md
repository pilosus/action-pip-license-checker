# GitHub Action for free/libre and open source license compliance

Detect license names and types for Python PyPI packages. Identify
license types for given license names obtained by third-party
tools. Great coverage of free/libre and open source licenses of all
types:
[public domain](https://en.wikipedia.org/wiki/Public-domain-equivalent_license),
[permissive](https://en.wikipedia.org/wiki/Permissive_software_license),
[copyleft](https://en.wikipedia.org/wiki/Copyleft).

Check Python dependencies, including in `requirements.txt` format for
`pip` package installer, without Python and its tooling
presence. Check license types for dependencies and their licenses
obtained by third-party tools (e.g. JavaScript's
[license-checker](https://www.npmjs.com/package/license-checker))

Based on [pip-license-check](https://github.com/pilosus/pip-license-checker)
command-line tool (see its README for details).

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
      uses: pilosus/action-pip-license-checker
      with:
        requirements: 'requirements.txt'
        fail: 'Copyleft,Error,Other'
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
      uses: pilosus/action-pip-license-checker@v0.3.0
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
      uses: pilosus/action-pip-license-checker@v0.3.0
      with:
        external: 'node_modules_licenses.csv'
        no-external-csv-headers: true
        fail: 'StrongCopyleft,NetworkCopyleft,Other,Error'
        fails-only: true
        exclude: 'node-forge.*'
        with-totals: true
        ...
```

Integration examples:

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

Path to CSV file in format: `package_name,license_name[,...]`.

Separate multiple files with comma: `file1.csv,file2.csv,file3.csv`.

Used to check license types for the list of given packages with their
licenses.

Allows to check license types for JavaScript, Java or any other
dependencies with known licenses.

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
