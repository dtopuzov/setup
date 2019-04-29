# Setup Scripts

## Notes

Be careful, scripts might be dangerous!

## Requirements

Manually install latest official Xcode.

## Cleanup

Before running the setup you can optionally clean your machine.

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

## Installed Software

List of installed software:

- Homebrew
- NodeJS (10)
- Maven 
- Open JDK 8 and 11 (default is 8)
- Android SDK (including emulator images)
- Appium (and all of its dependencies)
- NativeScript CLI (and all of its dependencies)
