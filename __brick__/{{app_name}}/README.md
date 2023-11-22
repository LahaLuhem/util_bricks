A new Flutter project.

## Getting Started

### General 'random' Project errors

Change the minSdkVersion in flutter-directory/packages/flutter_tools/gradle/flutter.gradle to 23
every time there is an update.<br>
If intl throws an error about not being able to find a package, generate with `flutter gen-l10n`
.<br>
Use [this link](https://joachimschuster.de/posts/android-studio-fix-markdown-plugin/) as workaround
for rendering MD content in Android Studio

<br>

## Flutter Version Manager (FVM)

### Inspiration

To containerize the setup of a flutter project, as much as possible, without involving actual
Docker.

### Setup

+ [Overview](https://fvm.app/docs/getting_started/overview)
+ [Install](https://fvm.app/docs/getting_started/installation) a standalone (since it is to be used
  globally)
+ Install the [Sidekick GUI](https://github.com/fluttertools/sidekick) for your platform. Use that
  to download, install and manage versions
+ Opening a project should create/read(in case already existing) the [.fvm](.fvm) folder with
  versioning
+ Point the Flutter SDK location (per your IDE-specific settings) to the symlink(shortcut) inside
  the [flutter_sdk](.fvm/flutter_sdk) folder.
+ Create the aliases for short-circuiting `fvm [flutter|dart] <...>` to just `[flutter|dart] <...>`
    + For Linux, just an alias
    + For Windows/Powershell, download my profile
      from [my Github](https://github.com/LahaLuhem/Script-tures/blob/master/shell%20profiles/powershell/Microsoft.PowerShell_profile.ps1)
      .

### FVM error

If a simple flutter command fails with a `git not found in your PATH` due to the new fvm, do the
following:

1. Check if you have git installed properly, with `git --version`
2. Skip the git check in flutter
   a) Go to 'flutter_sdk/bin/internal/shared.bat'
   b) Find a line where something like `SET git_exists=false` is used (~line 56) and set it to true.
3. Confirm that that flutter command works

### Errors while building Pods (iOS + MacOS)

1. Usually resolvable by deleting the [Podfile.lock](ios/Podfile.lock).
2. For CDN-trunk out-of-date-error, try updating the precompiled Firestore SDK (Check the comments
   in [Podfile](ios/Podfile), under 'targets' section).