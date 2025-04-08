<!-- TOC start (generated with https://github.com/derlin/bitdowntoc) -->

- [Getting Started](#getting-started)
    * [Environment-specific key distribution](#environment-specific-key-distribution)
    * [Firbase config files](#firbase-config-files)
        + [Android](#android)
        + [iOS](#ios)
- [Flutter Version Manager (FVM)](#flutter-version-manager-fvm)
    * [Inspiration](#inspiration)
    * [Setup](#setup)
- [Run configs](#run-configs)
    * [Local (mock)](#local-mock)
- [Errors wiki](#errors-wiki)
    * [General 'random' Project errors](#general-random-project-errors)
    * [FVM error](#fvm-error)
    * [Errors while building Pods (iOS + MacOS)](#errors-while-building-pods-ios-macos)

<!-- TOC end -->

<!-- TOC --><a id="getting-started"></a>

<!-- TOC --><a name="getting-started"></a>
## Getting Started

<!-- TOC --><a id="environment-specific-key-distribution"></a>

<!-- TOC --><a name="environment-specific-key-distribution"></a>
### Environment-specific key distribution

1. Run the [generator script](../scripts/keystore_env_gen.sh). This fetches the encoded keys from
   Bitbucket, decodes them and puts them into the [keystore](lib/env/keystore) directory.
2. Run the Build-Runner (`dart pub run build_runner build --delete-conflictin-outputs`). This will
   generate the boilerplate interop between Dart and .env files
3. DO NOT check the file in [keystore](lib/env/keystore) and the [boilerplate generated
   file](lib/env/env.g.dart) files into a VCS.

<!-- TOC --><a id="firbase-config-files"></a>

<!-- TOC --><a name="firbase-config-files"></a>
### Firbase config files

<!-- TOC --><a id="android"></a>

<!-- TOC --><a name="android"></a>
#### Android

1. Download the 'google-services.json' file from the project in Firebase.
2. Place it in 'android/app/' directory.

<!-- TOC --><a id="ios"></a>

<!-- TOC --><a name="ios"></a>
#### iOS

1. Download the GoogleServices-Info.plist file from the project in Firebase.

<!-- TOC --><a id="flutter-version-manager-fvm"></a>

<!-- TOC --><a name="flutter-version-manager-fvm"></a>
## Flutter Version Manager (FVM)

<!-- TOC --><a id="inspiration"></a>

<!-- TOC --><a name="inspiration"></a>
### Inspiration

To containerize the setup of a flutter project, as much as possible, without involving actual
Docker.

<!-- TOC --><a id="setup"></a>

<!-- TOC --><a name="setup"></a>
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
      from [my Github](https://github.com/LahaLuhem/Script-tures/blob/master/shell%20profiles/powershell/Microsoft.PowerShell_profile.ps1).

<!-- TOC --><a id="errors-wiki"></a>

<!-- TOC --><a name="run-configs"></a>
## Run configs

<!-- TOC --><a name="local-mock"></a>
### Local (mock)
1. Make sure that your Docker engine is running.
2. Ensure that the [mock submodule](../Docker/mock) is properly cloned an configured.
3. Add the `.docker.env` file from NordPass ("Mock webserver keys") to the root of the [mock submodule](../Docker/mock).
4. Ensure that the [Docker plugin](https://plugins.jetbrains.com/plugin/7724-docker) for Android Studio is installed and Docker socket is connected.
   + Android Studio, unlike other JetBrains IDEs, does not have a Docker plugin preinstalled.
   + Also ensure that the Docker engine is running and that the Docker socket is enabled.
5. Use the `Debug launch Staging` run config to have the following done:
   1. Run `CombiPac mock`. This will launch the Prism mock webserver for CombiPac.
   2. Run `Reverse ADB TCP`. This will reverse the TCP connection on the device to listen/point to the localhost exposed port for the Prism mock webserver.

<!-- TOC --><a name="errors-wiki"></a>
## Errors wiki

<!-- TOC --><a id="general-random-project-errors"></a>

<!-- TOC --><a name="general-random-project-errors"></a>
### General 'random' Project errors

Change the minSdkVersion in flutter-directory/packages/flutter_tools/gradle/flutter.gradle to 23
every time there is an update.<br>
If intl throws an error about not being able to find a package, generate with `flutter gen-l10n`
.<br>
Use [this link](https://joachimschuster.de/posts/android-studio-fix-markdown-plugin/) as workaround
for rendering MD content in Android Studio

<br>

<!-- TOC --><a id="fvm-error"></a>

<!-- TOC --><a name="fvm-error"></a>
### FVM error

If a simple flutter command fails with a `git not found in your PATH` due to the new fvm, do the
following:

1. Check if you have git installed properly, with `git --version`
2. Skip the git check in flutter
   a) Go to 'flutter_sdk/bin/internal/shared.bat'
   b) Find a line where something like `SET git_exists=false` is used (~line 56) and set it to true.
3. Confirm that that flutter command works

<!-- TOC --><a id="errors-while-building-pods-ios-macos"></a>

<!-- TOC --><a name="errors-while-building-pods-ios-macos"></a>
### Errors while building Pods (iOS + MacOS)

1. Usually resolvable by deleting the [Podfile.lock](ios/Podfile.lock).
2. For CDN-trunk out-of-date-error, try updating the precompiled Firestore SDK (Check the comments
   in [Podfile](ios/Podfile), under 'targets' section).
