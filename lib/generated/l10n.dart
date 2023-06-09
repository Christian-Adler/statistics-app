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

  /// `Settings`
  String get authSettingsTitle {
    return Intl.message(
      'Settings',
      name: 'authSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `diastolic (lower) (mmHg)`
  String get bloodPressureAddValueInputLabelDiastolic {
    return Intl.message(
      'diastolic (lower) (mmHg)',
      name: 'bloodPressureAddValueInputLabelDiastolic',
      desc: '',
      args: [],
    );
  }

  /// `systolic (upper) (mmHg)`
  String get bloodPressureAddValueInputLabelSystolic {
    return Intl.message(
      'systolic (upper) (mmHg)',
      name: 'bloodPressureAddValueInputLabelSystolic',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get bloodPressureTableHeadDate {
    return Intl.message(
      'Date',
      name: 'bloodPressureTableHeadDate',
      desc: '',
      args: [],
    );
  }

  /// `Evening`
  String get bloodPressureTableHeadEvening {
    return Intl.message(
      'Evening',
      name: 'bloodPressureTableHeadEvening',
      desc: '',
      args: [],
    );
  }

  /// `Midday`
  String get bloodPressureTableHeadMidday {
    return Intl.message(
      'Midday',
      name: 'bloodPressureTableHeadMidday',
      desc: '',
      args: [],
    );
  }

  /// `Morning`
  String get bloodPressureTableHeadMorning {
    return Intl.message(
      'Morning',
      name: 'bloodPressureTableHeadMorning',
      desc: '',
      args: [],
    );
  }

  /// `ct/l (1.199€ = 120ct/l)`
  String get carAddValueInputLabelCentPerLiter {
    return Intl.message(
      'ct/l (1.199€ = 120ct/l)',
      name: 'carAddValueInputLabelCentPerLiter',
      desc: '',
      args: [],
    );
  }

  /// `Mileage (km)`
  String get carAddValueInputLabelKilometers {
    return Intl.message(
      'Mileage (km)',
      name: 'carAddValueInputLabelKilometers',
      desc: '',
      args: [],
    );
  }

  /// `Liters (rounded) (l)`
  String get carAddValueInputLabelLiters {
    return Intl.message(
      'Liters (rounded) (l)',
      name: 'carAddValueInputLabelLiters',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get carTableHeadDate {
    return Intl.message(
      'Date',
      name: 'carTableHeadDate',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get carTableHeadKilometers {
    return Intl.message(
      'km',
      name: 'carTableHeadKilometers',
      desc: '',
      args: [],
    );
  }

  /// `l`
  String get carTableHeadLiters {
    return Intl.message(
      'l',
      name: 'carTableHeadLiters',
      desc: '',
      args: [],
    );
  }

  /// `€/l`
  String get carTableHeadEuroPerLiter {
    return Intl.message(
      '€/l',
      name: 'carTableHeadEuroPerLiter',
      desc: '',
      args: [],
    );
  }

  /// `€`
  String get carTableHeadEuro {
    return Intl.message(
      '€',
      name: 'carTableHeadEuro',
      desc: '',
      args: [],
    );
  }

  /// `l/100km`
  String get carTableHeadLitersPer100Kilometers {
    return Intl.message(
      'l/100km',
      name: 'carTableHeadLitersPer100Kilometers',
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

  /// `Cancel`
  String get commonsDialogBtnCancel {
    return Intl.message(
      'Cancel',
      name: 'commonsDialogBtnCancel',
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

  /// `Save`
  String get commonsDialogBtnSave {
    return Intl.message(
      'Save',
      name: 'commonsDialogBtnSave',
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

  /// `Failed to load data...`
  String get commonsMsgErrorFailedToLoadData {
    return Intl.message(
      'Failed to load data...',
      name: 'commonsMsgErrorFailedToLoadData',
      desc: '',
      args: [],
    );
  }

  /// `Failed to share...`
  String get commonsMsgErrorFailedToShareData {
    return Intl.message(
      'Failed to share...',
      name: 'commonsMsgErrorFailedToShareData',
      desc: '',
      args: [],
    );
  }

  /// `Saved...`
  String get commonsSnackbarMsgSaved {
    return Intl.message(
      'Saved...',
      name: 'commonsSnackbarMsgSaved',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a value`
  String get commonsValidatorMsgEmptyValue {
    return Intl.message(
      'Please enter a value',
      name: 'commonsValidatorMsgEmptyValue',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a valid number > 0`
  String get commonsValidatorMsgNumberGtZeroRequired {
    return Intl.message(
      'Please provide a valid number > 0',
      name: 'commonsValidatorMsgNumberGtZeroRequired',
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

  /// `Do you really want to delete the log file?`
  String get logDialogMsgQueryDeleteLog {
    return Intl.message(
      'Do you really want to delete the log file?',
      name: 'logDialogMsgQueryDeleteLog',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete log file!`
  String get logDialogMsgErrorDeleteLogFailed {
    return Intl.message(
      'Failed to delete log file!',
      name: 'logDialogMsgErrorDeleteLogFailed',
      desc: '',
      args: [],
    );
  }

  /// `Log file {file} not found!`
  String logMsgErrorFileNotFound(String file) {
    return Intl.message(
      'Log file $file not found!',
      name: 'logMsgErrorFileNotFound',
      desc: '',
      args: [file],
    );
  }

  /// `Failed to clear all logs!`
  String get logsDialogMsgErrorFailedToClearAllLogs {
    return Intl.message(
      'Failed to clear all logs!',
      name: 'logsDialogMsgErrorFailedToClearAllLogs',
      desc: '',
      args: [],
    );
  }

  /// `Failed to zip logs!`
  String get logsDialogMsgErrorFailedToZipLogs {
    return Intl.message(
      'Failed to zip logs!',
      name: 'logsDialogMsgErrorFailedToZipLogs',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete all log files?`
  String get logsDialogMsgQueryDeleteAllLogs {
    return Intl.message(
      'Do you really want to delete all log files?',
      name: 'logsDialogMsgQueryDeleteAllLogs',
      desc: '',
      args: [],
    );
  }

  /// `No log files found`
  String get logsMsgNoLogFilesFound {
    return Intl.message(
      'No log files found',
      name: 'logsMsgNoLogFilesFound',
      desc: '',
      args: [],
    );
  }

  /// `Power (kWh)`
  String get operatingAddValueInputLabelPower {
    return Intl.message(
      'Power (kWh)',
      name: 'operatingAddValueInputLabelPower',
      desc: '',
      args: [],
    );
  }

  /// `Power Fed (kWh)`
  String get operatingAddValueInputLabelPowerFed {
    return Intl.message(
      'Power Fed (kWh)',
      name: 'operatingAddValueInputLabelPowerFed',
      desc: '',
      args: [],
    );
  }

  /// `Power Heating HT (kWh)`
  String get operatingAddValueInputLabelPowerHeatingDay {
    return Intl.message(
      'Power Heating HT (kWh)',
      name: 'operatingAddValueInputLabelPowerHeatingDay',
      desc: '',
      args: [],
    );
  }

  /// `Strom Heating NT (kWh)`
  String get operatingAddValueInputLabelPowerHeatingNight {
    return Intl.message(
      'Strom Heating NT (kWh)',
      name: 'operatingAddValueInputLabelPowerHeatingNight',
      desc: '',
      args: [],
    );
  }

  /// `Water (m³ = alle großen Zahlen)`
  String get operatingAddValueInputLabelWater {
    return Intl.message(
      'Water (m³ = alle großen Zahlen)',
      name: 'operatingAddValueInputLabelWater',
      desc: '',
      args: [],
    );
  }

  /// `Power consumed (kWh)`
  String get operatingChartPowerConsumed {
    return Intl.message(
      'Power consumed (kWh)',
      name: 'operatingChartPowerConsumed',
      desc: '',
      args: [],
    );
  }

  /// `Power consumed total (kWh)`
  String get operatingChartPowerConsumedTotal {
    return Intl.message(
      'Power consumed total (kWh)',
      name: 'operatingChartPowerConsumedTotal',
      desc: '',
      args: [],
    );
  }

  /// `Power fed (kWh)`
  String get operatingChartPowerFed {
    return Intl.message(
      'Power fed (kWh)',
      name: 'operatingChartPowerFed',
      desc: '',
      args: [],
    );
  }

  /// `Power generated (kWh)`
  String get operatingChartPowerGenerated {
    return Intl.message(
      'Power generated (kWh)',
      name: 'operatingChartPowerGenerated',
      desc: '',
      args: [],
    );
  }

  /// `Power generated own consumption (kWh)`
  String get operatingChartPowerGeneratedOwnConsumption {
    return Intl.message(
      'Power generated own consumption (kWh)',
      name: 'operatingChartPowerGeneratedOwnConsumption',
      desc: '',
      args: [],
    );
  }

  /// `Heating (kWh)`
  String get operatingChartHeating {
    return Intl.message(
      'Heating (kWh)',
      name: 'operatingChartHeating',
      desc: '',
      args: [],
    );
  }

  /// `Water (m³)`
  String get operatingChartWater {
    return Intl.message(
      'Water (m³)',
      name: 'operatingChartWater',
      desc: '',
      args: [],
    );
  }

  /// `Operating costs / {period}`
  String operatingTitle(String period) {
    return Intl.message(
      'Operating costs / $period',
      name: 'operatingTitle',
      desc: '',
      args: [period],
    );
  }

  /// `Month`
  String get operatingTitlePeriodMonth {
    return Intl.message(
      'Month',
      name: 'operatingTitlePeriodMonth',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get operatingTitlePeriodYear {
    return Intl.message(
      'Year',
      name: 'operatingTitlePeriodYear',
      desc: '',
      args: [],
    );
  }

  /// `E, yyyy-MM-dd`
  String get patternsDateWeekdayWithDate {
    return Intl.message(
      'E, yyyy-MM-dd',
      name: 'patternsDateWeekdayWithDate',
      desc: '',
      args: [],
    );
  }

  /// `yyyy-MM-dd`
  String get patternsDateYYYYMMDD {
    return Intl.message(
      'yyyy-MM-dd',
      name: 'patternsDateYYYYMMDD',
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

  /// `Info`
  String get screenTitleInfo {
    return Intl.message(
      'Info',
      name: 'screenTitleInfo',
      desc: '',
      args: [],
    );
  }

  /// `Log - `
  String get screenTitleLog {
    return Intl.message(
      'Log - ',
      name: 'screenTitleLog',
      desc: '',
      args: [],
    );
  }

  /// `Application logs`
  String get screenTitleLogs {
    return Intl.message(
      'Application logs',
      name: 'screenTitleLogs',
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

  /// `Overview`
  String get screenTitleOverview {
    return Intl.message(
      'Overview',
      name: 'screenTitleOverview',
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
  String get settingsDeviceStorageDialogMsgQueryRemoveAllDataAndLogout {
    return Intl.message(
      'Do you really want to remove all app data from your device and log out?',
      name: 'settingsDeviceStorageDialogMsgQueryRemoveAllDataAndLogout',
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

  /// `Generated Solar Power (kWh)`
  String get solarPowerAddValueInputLabelPowerGenerated {
    return Intl.message(
      'Generated Solar Power (kWh)',
      name: 'solarPowerAddValueInputLabelPowerGenerated',
      desc: '',
      args: [],
    );
  }

  /// `Generated`
  String get solarPowerChartLegendItemGenerated {
    return Intl.message(
      'Generated',
      name: 'solarPowerChartLegendItemGenerated',
      desc: '',
      args: [],
    );
  }

  /// `Fed`
  String get solarPowerChartLegendItemFed {
    return Intl.message(
      'Fed',
      name: 'solarPowerChartLegendItemFed',
      desc: '',
      args: [],
    );
  }

  /// `Consumption`
  String get solarPowerChartLegendItemConsumption {
    return Intl.message(
      'Consumption',
      name: 'solarPowerChartLegendItemConsumption',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get solarPowerChartLegendItemTotal {
    return Intl.message(
      'Total',
      name: 'solarPowerChartLegendItemTotal',
      desc: '',
      args: [],
    );
  }

  /// `Price : {price} €/kWh, Basic fee : {feePerMont} €/Monat`
  String solarPowerChartSubLegendPriceAndFee(String price, String feePerMont) {
    return Intl.message(
      'Price : $price €/kWh, Basic fee : $feePerMont €/Monat',
      name: 'solarPowerChartSubLegendPriceAndFee',
      desc: '',
      args: [price, feePerMont],
    );
  }

  /// `kWh / {period}`
  String solarPowerTitle(String period) {
    return Intl.message(
      'kWh / $period',
      name: 'solarPowerTitle',
      desc: '',
      args: [period],
    );
  }

  /// `Month`
  String get solarPowerTitlePeriodMonth {
    return Intl.message(
      'Month',
      name: 'solarPowerTitlePeriodMonth',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get solarPowerTitlePeriodYear {
    return Intl.message(
      'Year',
      name: 'solarPowerTitlePeriodYear',
      desc: '',
      args: [],
    );
  }

  /// `Consumption`
  String get solarPowerTableHeadConsumption {
    return Intl.message(
      'Consumption',
      name: 'solarPowerTableHeadConsumption',
      desc: '',
      args: [],
    );
  }

  /// `Consum.`
  String get solarPowerTableHeadConsumptionAbbrev {
    return Intl.message(
      'Consum.',
      name: 'solarPowerTableHeadConsumptionAbbrev',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get solarPowerTableHeadDate {
    return Intl.message(
      'Date',
      name: 'solarPowerTableHeadDate',
      desc: '',
      args: [],
    );
  }

  /// `Fed`
  String get solarPowerTableHeadFed {
    return Intl.message(
      'Fed',
      name: 'solarPowerTableHeadFed',
      desc: '',
      args: [],
    );
  }

  /// `Fed`
  String get solarPowerTableHeadFedAbbrev {
    return Intl.message(
      'Fed',
      name: 'solarPowerTableHeadFedAbbrev',
      desc: '',
      args: [],
    );
  }

  /// `Generated`
  String get solarPowerTableHeadGenerated {
    return Intl.message(
      'Generated',
      name: 'solarPowerTableHeadGenerated',
      desc: '',
      args: [],
    );
  }

  /// `Gener.`
  String get solarPowerTableHeadGeneratedAbbrev {
    return Intl.message(
      'Gener.',
      name: 'solarPowerTableHeadGeneratedAbbrev',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get solarPowerTableHeadTotal {
    return Intl.message(
      'Total',
      name: 'solarPowerTableHeadTotal',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get solarPowerTableHeadTotalAbbrev {
    return Intl.message(
      'Total',
      name: 'solarPowerTableHeadTotalAbbrev',
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
