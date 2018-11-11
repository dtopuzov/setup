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
Note that it will take some time.

## Installed Software

List of installed software:

- Homebrew
- NodeJS (10)
- Maven 
- Java (8 and 11)
- Android SDK (including emulator images)
- Appium (and all of its dependencies)
- NativeScript CLI (and all of its dependencies)

## Troubleshooting

Logs of setup are available at 
```bash
$HOME/logs
```