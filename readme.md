# dotfiles

## Getting Started

To bootstrap the system, run these two scripts in succession first to install
install frequently used programs and symlink configuration files to the right place.

```bash
sudo bash ./install-common.sh
sudo bash ./install-dotfiles.sh
```

<details>
<summary>Further Notes</summary>
In a few cases `cargo install` in `install-common.sh` may fail to install certain
programs on some Unix distributions if there are no binary packages to be found for
your distribution. Installing `cargo` from `apt` may also give you an outdated version
of Rust, which is why this script will install `cargo` from source if cargo could
not be detected on your system.
</details>

## Opt-In Customizations

Independent of the aforementioned step you can run these scripts in addition to
that to install a few programs from source:

* `install-git.sh`
* `install-pwsh.sh`
* `install-python.sh`

Each script gives you can option to specify a target version. A fairly recent
default version is also hard-coded into the script if no version is entered.

## More Scripts

The `utils.sh` script defines (as the name of the script already implies) a small
set of helper functions.
