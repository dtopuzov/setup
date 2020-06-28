# Setup Scripts

## About

Setup scripts that I use to setup my personal Mac Book at home.

List of installed software:

- Homebrew
- NodeJS 12
- Open JDK 8, 11 and 13
- Maven
- Android SDK (including emulator images)
- Appium (and all of its dependencies)

Optional scripts:

- `ide/install-ides.sh` installs IntelliJ IDEA, PyCharm and VS Code.
- `java/install-sikuli.sh` installs Sikuli IDE.
- `ios/setup-disable-firewall.sh` exclude Xcode from macOS firewall rules.

**Notes**: Be careful and use at your own risk!

## Requirements

Manually install latest official Xcode.

## Usage

Set environment variable with password of your user:

```bash
export PASS=<your-pass>
```

Run the script:

```bash
./setup.sh
```

Wait until you see:

```bash
Setup completed!
```

Notes:

- It will take some time.
- Logs are in `$HOME/logs`
- Do not forget to `source $HOME/.bash_profile` after setup is complete.

## Cleanup

If you want to clean your machine from all the installed things you can run the cleanup script.

Enable full cleanup (will erase everything):

```bash
export FORCE_CLEAN=true
```

Run the script:

```bash
./clean.sh
```

Wait until you see:

```bash
Cleanup completed!
```

Note that it will take some time.
