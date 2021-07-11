# GitHub Action for Python dependencies license check

Check Python PyPI package license with
[pip-license-check](https://github.com/pilosus/pip-license-checker)
tool in GitHub Actions.

## Example usage

```yaml
jobs:
  license_check:
    runs-on: ubuntu-18.04
    steps:
    - name: Checkout the code
      uses: actions/checkout@v2.3.4
      with:
        fetch-depth: 0
    - name: Check Python deps licenses
      id: license_check_report
      uses: pilosus/action-pip-license-checker@v0.1.2
      with:
        requirements: 'requirements.txt'
        fail: 'Copyleft'
        exclude: 'aio.*'
        with-totals: true
        table-headers: true
    - name: Print report
      run: echo "${{ steps.license_check_report.outputs.report }}"
```


## Inputs

All the inputs correspond with `pip-license-checker`'s
[options](https://github.com/pilosus/pip-license-checker#help).

### `requirements`

**Required** Path to requirements file. Defaults to `"requirements.txt"`.

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

## Outputs

### `report`

Formatted plain text representation of the license check.


## Disclaimer

Software is provided on an "as-is" basis and makes no warranties
regarding any information provided through it, and disclaims liability
for damages resulting from using it. Using the software does not
constitute legal advice nor does it create an attorney-client
relationship.
