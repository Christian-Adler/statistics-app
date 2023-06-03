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

  /// `German`
  String get localeNameGerman {
    return Intl.message(
      'German',
      name: 'localeNameGerman',
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
