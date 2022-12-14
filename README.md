# self-managed-pipx
Simple script for installing a self managed instance of pipx.

## Usage

To install a self managed instance of `pipx` use:
```shell
curl https://raw.githubusercontent.com/slobberchops/self-managed-pipx/main/install-self-managed-pipx.sh | bash
```

## Uninstallation

To uninstall self managed `pipx` use:

### Installing using a specific python binary

To use a specific python binary version (for example `python3.9`) set the
`PYTHON_BIN` environment variable:

```shell
PYTHON_BIN=python3.9 curl https://raw.githubusercontent.com/slobberchops/self-managed-pipx/main/install-self-managed-pipx.sh | bash
```

```shell
pipx uninstall
```

...because it's, you know, self managed.
