# statistics-app


## Create Launcher Icons

- run `flutter pub run flutter_launcher_icons`

## Build apk (Android)

- Increase version in pubspec.yaml
- run `flutter build apk --split-per-abi`
- use `build\app\outputs\flutter-apk\app-arm64-v8a-release.apk`


## IOS

### How to fix Using `ARCHS` setting to build architectures of target `Pods-Runner`

Pod-File ändern:

```
target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end
```

Installation des pod-files (M1/M2-Chip) - Did you try:
- sudo gem install cocoapods
- sudo arch -x86_64 gem install ffi
- arch -x86_64 pod repo update
- arch -x86_64 pod install (im ios Verzeichnis auf Console ausführen!)


## Edit readme.md

https://stackedit.io/app#