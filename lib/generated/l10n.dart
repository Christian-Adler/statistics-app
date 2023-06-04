// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get authBtnLogin {
    return Intl.message(
      'Login',
      name: 'authBtnLogin',
      desc: '',
      args: [],
    );
  }

  /// `Could not authenticate you. Please try again later.`
  String get authErrorMsgAuthenticationFailed {
    return Intl.message(
      'Could not authenticate you. Please try again later.',
      name: 'authErrorMsgAuthenticationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Server`
  String get authInputLabelServer {
    return Intl.message(
      'Server',
      name: 'authInputLabelServer',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get authInputLabelPassword {
    return Intl.message(
      'Password',
      name: 'authInputLabelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid server!`
  String get authInputValidatorMsgEnterValidServer {
    return Intl.message(
      'Enter a valid server!',
      name: 'authInputValidatorMsgEnterValidServer',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short!`
  String get authInputValidatorMsgPasswordToShort {
    return Intl.message(
      'Password is too short!',
      name: 'authInputValidatorMsgPasswordToShort',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get commonsLogout {
    return Intl.message(
      'Logout',
      name: 'commonsLogout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get commonsDialogTitleAreYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'commonsDialogTitleAreYouSure',
      desc: '',
      args: [],
    );
  }

  /// `An Error Occurred`
  String get commonsDialogTitleErrorOccurred {
    return Intl.message(
      'An Error Occurred',
      name: 'commonsDialogTitleErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get commonsDialogBtnNo {
    return Intl.message(
      'No',
      name: 'commonsDialogBtnNo',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get commonsDialogBtnOkay {
    return Intl.message(
      'Ok',
      name: 'commonsDialogBtnOkay',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get commonsDialogBtnYes {
    return Intl.message(
      'Yes',
      name: 'commonsDialogBtnYes',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get localeNameSystem {
    return Intl.message(
      'System',
      name: 'localeNameSystem',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get localeNameEnglish {
    return Intl.message(
      'English',
      name: 'localeNameEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Deutsch`
  String get localeNameGerman {
    return Intl.message(
      'Deutsch',
      name: 'localeNameGerman',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get screenTitleOverview {
    return Intl.message(
      'Overview',
      name: 'screenTitleOverview',
      desc: '',
      args: [],
    );
  }

  /// `Operating`
  String get screenTitleOperating {
    return Intl.message(
      'Operating',
      name: 'screenTitleOperating',
      desc: '',
      args: [],
    );
  }

  /// `Enter operating costs`
  String get screenTitleOperatingAddValue {
    return Intl.message(
      'Enter operating costs',
      name: 'screenTitleOperatingAddValue',
      desc: '',
      args: [],
    );
  }

  /// `Solar power`
  String get screenTitleSolarPower {
    return Intl.message(
      'Solar power',
      name: 'screenTitleSolarPower',
      desc: '',
      args: [],
    );
  }

  /// `Enter solar power yield`
  String get screenTitleSolarPowerAddValue {
    return Intl.message(
      'Enter solar power yield',
      name: 'screenTitleSolarPowerAddValue',
      desc: '',
      args: [],
    );
  }

  /// `Refuel`
  String get screenTitleCar {
    return Intl.message(
      'Refuel',
      name: 'screenTitleCar',
      desc: '',
      args: [],
    );
  }

  /// `Enter refuel`
  String get screenTitleCarAddValue {
    return Intl.message(
      'Enter refuel',
      name: 'screenTitleCarAddValue',
      desc: '',
      args: [],
    );
  }

  /// `Blood pressure`
  String get screenTitleHeart {
    return Intl.message(
      'Blood pressure',
      name: 'screenTitleHeart',
      desc: '',
      args: [],
    );
  }

  /// `Enter blood pressure`
  String get screenTitleHeartAddValue {
    return Intl.message(
      'Enter blood pressure',
      name: 'screenTitleHeartAddValue',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get screenTitleSettings {
    return Intl.message(
      'Settings',
      name: 'screenTitleSettings',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get screenTitleInfo {
    return Intl.message(
      'Info',
      name: 'screenTitleInfo',
      desc: '',
      args: [],
    );
  }

  /// `Clear device storage & logout`
  String get settingsDeviceStorageBtnClearStorageAndLogout {
    return Intl.message(
      'Clear device storage & logout',
      name: 'settingsDeviceStorageBtnClearStorageAndLogout',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to remove all app data from your device and log out?`
  String get settingsDeviceStorageDialogMsgRemoveAllDataAndLogout {
    return Intl.message(
      'Do you really want to remove all app data from your device and log out?',
      name: 'settingsDeviceStorageDialogMsgRemoveAllDataAndLogout',
      desc: '',
      args: [],
    );
  }

  /// `Show auth data`
  String get settingsDeviceStorageLabelShowAuthData {
    return Intl.message(
      'Show auth data',
      name: 'settingsDeviceStorageLabelShowAuthData',
      desc: '',
      args: [],
    );
  }

  /// `Key`
  String get settingsDeviceStorageTableHeadKey {
    return Intl.message(
      'Key',
      name: 'settingsDeviceStorageTableHeadKey',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get settingsDeviceStorageTableHeadValue {
    return Intl.message(
      'Value',
      name: 'settingsDeviceStorageTableHeadValue',
      desc: '',
      args: [],
    );
  }

  /// `Device Storage`
  String get settingsDeviceStorageTitle {
    return Intl.message(
      'Device Storage',
      name: 'settingsDeviceStorageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsLanguageLabelChooseLanguage {
    return Intl.message(
      'Language',
      name: 'settingsLanguageLabelChooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsLanguageTitle {
    return Intl.message(
      'Language',
      name: 'settingsLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Display titles in navigation (drawer, app bar)`
  String get settingsLayoutLabelShowNavigationTitles {
    return Intl.message(
      'Display titles in navigation (drawer, app bar)',
      name: 'settingsLayoutLabelShowNavigationTitles',
      desc: '',
      args: [],
    );
  }

  /// `Display isometric bar buttons in overview`
  String get settingsLayoutLabelShowOverviewIsometricButtons {
    return Intl.message(
      'Display isometric bar buttons in overview',
      name: 'settingsLayoutLabelShowOverviewIsometricButtons',
      desc: '',
      args: [],
    );
  }

  /// `Display parallax effect in overview (cpu consuming)`
  String get settingsLayoutLabelShowOverviewParallaxEffect {
    return Intl.message(
      'Display parallax effect in overview (cpu consuming)',
      name: 'settingsLayoutLabelShowOverviewParallaxEffect',
      desc: '',
      args: [],
    );
  }

  /// `Layout`
  String get settingsLayoutTitle {
    return Intl.message(
      'Layout',
      name: 'settingsLayoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Server`
  String get settingsServerInputLabelServer {
    return Intl.message(
      'Server',
      name: 'settingsServerInputLabelServer',
      desc: '',
      args: [],
    );
  }

  /// `Enter a server`
  String get settingsServerInputValidatorMsgEnterServer {
    return Intl.message(
      'Enter a server',
      name: 'settingsServerInputValidatorMsgEnterServer',
      desc: '',
      args: [],
    );
  }

  /// `Provide a valid server address`
  String get settingsServerInputValidatorMsgProvideValidServer {
    return Intl.message(
      'Provide a valid server address',
      name: 'settingsServerInputValidatorMsgProvideValidServer',
      desc: '',
      args: [],
    );
  }

  /// `Server removed...`
  String get settingsServerSnackbarMsgServerRemoved {
    return Intl.message(
      'Server removed...',
      name: 'settingsServerSnackbarMsgServerRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Server`
  String get settingsServerTitle {
    return Intl.message(
      'Server',
      name: 'settingsServerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get settingsThemeLabelChooseMode {
    return Intl.message(
      'Mode',
      name: 'settingsThemeLabelChooseMode',
      desc: '',
      args: [],
    );
  }

  /// `Main Color`
  String get settingsThemeLabelChooseMainColor {
    return Intl.message(
      'Main Color',
      name: 'settingsThemeLabelChooseMainColor',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get settingsThemeModeDark {
    return Intl.message(
      'Dark Mode',
      name: 'settingsThemeModeDark',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get settingsThemeModeLight {
    return Intl.message(
      'Light Mode',
      name: 'settingsThemeModeLight',
      desc: '',
      args: [],
    );
  }

  /// `System Mode`
  String get settingsThemeModeSystem {
    return Intl.message(
      'System Mode',
      name: 'settingsThemeModeSystem',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get settingsThemeTitle {
    return Intl.message(
      'Theme',
      name: 'settingsThemeTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}