// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(file) => "Log file ${file} not found!";

  static String m1(period) => "Operating costs / ${period}";

  static String m2(price, feePerMont) =>
      "Price : ${price} €/kWh, Basic fee : ${feePerMont} €/Monat";

  static String m3(period) => "kWh / ${period}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "authBtnLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "authErrorMsgAuthenticationFailed": MessageLookupByLibrary.simpleMessage(
            "Could not authenticate you.\nPlease check credentials or try again later."),
        "authInputLabelPassword":
            MessageLookupByLibrary.simpleMessage("Password"),
        "authInputLabelServer": MessageLookupByLibrary.simpleMessage("Server"),
        "authInputValidatorMsgEnterValidServer":
            MessageLookupByLibrary.simpleMessage("Enter a valid server!"),
        "authInputValidatorMsgPasswordToShort":
            MessageLookupByLibrary.simpleMessage("Password is too short!"),
        "authSettingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "bloodPressureAddValueInputLabelDiastolic":
            MessageLookupByLibrary.simpleMessage("diastolic (lower) (mmHg)"),
        "bloodPressureAddValueInputLabelSystolic":
            MessageLookupByLibrary.simpleMessage("systolic (upper) (mmHg)"),
        "bloodPressureTableHeadDate":
            MessageLookupByLibrary.simpleMessage("Date"),
        "bloodPressureTableHeadEvening":
            MessageLookupByLibrary.simpleMessage("Evening"),
        "bloodPressureTableHeadMidday":
            MessageLookupByLibrary.simpleMessage("Midday"),
        "bloodPressureTableHeadMorning":
            MessageLookupByLibrary.simpleMessage("Morning"),
        "carAddValueInputLabelCentPerLiter":
            MessageLookupByLibrary.simpleMessage("ct/l (1.199€ = 120ct/l)"),
        "carAddValueInputLabelKilometers":
            MessageLookupByLibrary.simpleMessage("Mileage (km)"),
        "carAddValueInputLabelLiters":
            MessageLookupByLibrary.simpleMessage("Liters (rounded) (l)"),
        "carTableHeadDate": MessageLookupByLibrary.simpleMessage("Date"),
        "carTableHeadEuro": MessageLookupByLibrary.simpleMessage("€"),
        "carTableHeadEuroPerLiter": MessageLookupByLibrary.simpleMessage("€/l"),
        "carTableHeadKilometers": MessageLookupByLibrary.simpleMessage("km"),
        "carTableHeadLiters": MessageLookupByLibrary.simpleMessage("l"),
        "carTableHeadLitersPer100Kilometers":
            MessageLookupByLibrary.simpleMessage("l/100km"),
        "commonsDialogBtnCancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "commonsDialogBtnNo": MessageLookupByLibrary.simpleMessage("No"),
        "commonsDialogBtnOkay": MessageLookupByLibrary.simpleMessage("Ok"),
        "commonsDialogBtnSave": MessageLookupByLibrary.simpleMessage("Save"),
        "commonsDialogBtnYes": MessageLookupByLibrary.simpleMessage("Yes"),
        "commonsDialogTitleAreYouSure":
            MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "commonsDialogTitleErrorOccurred":
            MessageLookupByLibrary.simpleMessage("An Error Occurred"),
        "commonsLogout": MessageLookupByLibrary.simpleMessage("Logout"),
        "commonsMsgErrorFailedToLoadData":
            MessageLookupByLibrary.simpleMessage("Failed to load data..."),
        "commonsMsgErrorFailedToSendData":
            MessageLookupByLibrary.simpleMessage("Failed to send data..."),
        "commonsMsgErrorFailedToShareData":
            MessageLookupByLibrary.simpleMessage("Failed to share..."),
        "commonsSnackbarMsgSaved":
            MessageLookupByLibrary.simpleMessage("Saved..."),
        "commonsValidatorMsgEmptyValue":
            MessageLookupByLibrary.simpleMessage("Please enter a value"),
        "commonsValidatorMsgNumberGtZeroRequired":
            MessageLookupByLibrary.simpleMessage(
                "Please provide a valid number > 0"),
        "localeNameEnglish": MessageLookupByLibrary.simpleMessage("English"),
        "localeNameGerman": MessageLookupByLibrary.simpleMessage("Deutsch"),
        "localeNameSystem": MessageLookupByLibrary.simpleMessage("System"),
        "logDialogMsgErrorDeleteLogFailed":
            MessageLookupByLibrary.simpleMessage("Failed to delete log file!"),
        "logDialogMsgQueryDeleteLog": MessageLookupByLibrary.simpleMessage(
            "Do you really want to delete the log file?"),
        "logMsgErrorFileNotFound": m0,
        "logsDialogMsgErrorFailedToClearAllLogs":
            MessageLookupByLibrary.simpleMessage("Failed to clear all logs!"),
        "logsDialogMsgErrorFailedToZipLogs":
            MessageLookupByLibrary.simpleMessage("Failed to zip logs!"),
        "logsDialogMsgQueryDeleteAllLogs": MessageLookupByLibrary.simpleMessage(
            "Do you really want to delete all log files?"),
        "logsLabelChooseLogLevel":
            MessageLookupByLibrary.simpleMessage("Log Level"),
        "logsMsgNoLogFilesFound":
            MessageLookupByLibrary.simpleMessage("No log files found"),
        "operatingAddValueInputLabelPower":
            MessageLookupByLibrary.simpleMessage("Power (kWh)"),
        "operatingAddValueInputLabelPowerFed":
            MessageLookupByLibrary.simpleMessage("Power Fed (kWh)"),
        "operatingAddValueInputLabelPowerHeatingDay":
            MessageLookupByLibrary.simpleMessage("Power Heating HT (kWh)"),
        "operatingAddValueInputLabelPowerHeatingNight":
            MessageLookupByLibrary.simpleMessage("Strom Heating NT (kWh)"),
        "operatingAddValueInputLabelWater":
            MessageLookupByLibrary.simpleMessage(
                "Water (m³ = alle großen Zahlen)"),
        "operatingChartHeating":
            MessageLookupByLibrary.simpleMessage("Heating (kWh)"),
        "operatingChartPowerConsumed":
            MessageLookupByLibrary.simpleMessage("Power consumed (kWh)"),
        "operatingChartPowerConsumedTotal":
            MessageLookupByLibrary.simpleMessage("Power consumed total (kWh)"),
        "operatingChartPowerFed":
            MessageLookupByLibrary.simpleMessage("Power fed (kWh)"),
        "operatingChartPowerGenerated":
            MessageLookupByLibrary.simpleMessage("Power generated (kWh)"),
        "operatingChartPowerGeneratedOwnConsumption":
            MessageLookupByLibrary.simpleMessage(
                "Power generated own consumption (kWh)"),
        "operatingChartWater":
            MessageLookupByLibrary.simpleMessage("Water (m³)"),
        "operatingTitle": m1,
        "operatingTitlePeriodMonth":
            MessageLookupByLibrary.simpleMessage("Month"),
        "operatingTitlePeriodYear":
            MessageLookupByLibrary.simpleMessage("Year"),
        "patternsDateWeekdayWithDate":
            MessageLookupByLibrary.simpleMessage("E, yyyy-MM-dd"),
        "patternsDateYYYYMMDD":
            MessageLookupByLibrary.simpleMessage("yyyy-MM-dd"),
        "screenTitleCar": MessageLookupByLibrary.simpleMessage("Refuel"),
        "screenTitleCarAddValue":
            MessageLookupByLibrary.simpleMessage("Enter refuel"),
        "screenTitleHeart":
            MessageLookupByLibrary.simpleMessage("Blood pressure"),
        "screenTitleHeartAddValue":
            MessageLookupByLibrary.simpleMessage("Enter blood pressure"),
        "screenTitleInfo": MessageLookupByLibrary.simpleMessage("Info"),
        "screenTitleLog": MessageLookupByLibrary.simpleMessage("Log - "),
        "screenTitleLogs":
            MessageLookupByLibrary.simpleMessage("Application logs"),
        "screenTitleOperating":
            MessageLookupByLibrary.simpleMessage("Operating"),
        "screenTitleOperatingAddValue":
            MessageLookupByLibrary.simpleMessage("Enter operating costs"),
        "screenTitleOverview": MessageLookupByLibrary.simpleMessage("Overview"),
        "screenTitleSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "screenTitleSolarPower":
            MessageLookupByLibrary.simpleMessage("Solar power"),
        "screenTitleSolarPowerAddValue":
            MessageLookupByLibrary.simpleMessage("Enter solar power yield"),
        "settingsDeviceStorageBtnClearStorageAndLogout":
            MessageLookupByLibrary.simpleMessage(
                "Clear device storage & logout"),
        "settingsDeviceStorageDialogMsgQueryRemoveAllDataAndLogout":
            MessageLookupByLibrary.simpleMessage(
                "Do you really want to remove all app data from your device and log out?"),
        "settingsDeviceStorageLabelShowAuthData":
            MessageLookupByLibrary.simpleMessage("Show auth data"),
        "settingsDeviceStorageTableHeadKey":
            MessageLookupByLibrary.simpleMessage("Key"),
        "settingsDeviceStorageTableHeadValue":
            MessageLookupByLibrary.simpleMessage("Value"),
        "settingsDeviceStorageTitle":
            MessageLookupByLibrary.simpleMessage("Device Storage"),
        "settingsLanguageLabelChooseLanguage":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settingsLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settingsLayoutLabelShowNavigationTitles":
            MessageLookupByLibrary.simpleMessage(
                "Display titles in navigation (drawer, app bar)"),
        "settingsLayoutLabelShowOverviewIsometricButtons":
            MessageLookupByLibrary.simpleMessage(
                "Display isometric bar buttons in overview"),
        "settingsLayoutLabelShowOverviewParallaxEffect":
            MessageLookupByLibrary.simpleMessage(
                "Display parallax effect in overview (cpu consuming)"),
        "settingsLayoutTitle": MessageLookupByLibrary.simpleMessage("Layout"),
        "settingsServerInputLabelServer":
            MessageLookupByLibrary.simpleMessage("Server"),
        "settingsServerInputValidatorMsgEnterServer":
            MessageLookupByLibrary.simpleMessage("Enter a server"),
        "settingsServerInputValidatorMsgProvideValidServer":
            MessageLookupByLibrary.simpleMessage(
                "Provide a valid server address"),
        "settingsServerSnackbarMsgServerRemoved":
            MessageLookupByLibrary.simpleMessage("Server removed..."),
        "settingsServerTitle": MessageLookupByLibrary.simpleMessage("Server"),
        "settingsThemeLabelChooseMainColor":
            MessageLookupByLibrary.simpleMessage("Main Color"),
        "settingsThemeLabelChooseMode":
            MessageLookupByLibrary.simpleMessage("Mode"),
        "settingsThemeModeDark":
            MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "settingsThemeModeLight":
            MessageLookupByLibrary.simpleMessage("Light Mode"),
        "settingsThemeModeSystem":
            MessageLookupByLibrary.simpleMessage("System Mode"),
        "settingsThemeTitle": MessageLookupByLibrary.simpleMessage("Theme"),
        "solarPowerAddValueInputLabelPowerGenerated":
            MessageLookupByLibrary.simpleMessage("Generated Solar Power (kWh)"),
        "solarPowerChartLegendItemConsumption":
            MessageLookupByLibrary.simpleMessage("Consumption"),
        "solarPowerChartLegendItemFed":
            MessageLookupByLibrary.simpleMessage("Fed"),
        "solarPowerChartLegendItemGenerated":
            MessageLookupByLibrary.simpleMessage("Generated"),
        "solarPowerChartLegendItemTotal":
            MessageLookupByLibrary.simpleMessage("Total"),
        "solarPowerChartSubLegendPriceAndFee": m2,
        "solarPowerTableHeadConsumption":
            MessageLookupByLibrary.simpleMessage("Consumption"),
        "solarPowerTableHeadConsumptionAbbrev":
            MessageLookupByLibrary.simpleMessage("Consum."),
        "solarPowerTableHeadDate": MessageLookupByLibrary.simpleMessage("Date"),
        "solarPowerTableHeadFed": MessageLookupByLibrary.simpleMessage("Fed"),
        "solarPowerTableHeadFedAbbrev":
            MessageLookupByLibrary.simpleMessage("Fed"),
        "solarPowerTableHeadGenerated":
            MessageLookupByLibrary.simpleMessage("Generated"),
        "solarPowerTableHeadGeneratedAbbrev":
            MessageLookupByLibrary.simpleMessage("Gener."),
        "solarPowerTableHeadTotal":
            MessageLookupByLibrary.simpleMessage("Total"),
        "solarPowerTableHeadTotalAbbrev":
            MessageLookupByLibrary.simpleMessage("Total"),
        "solarPowerTitle": m3,
        "solarPowerTitlePeriodMonth":
            MessageLookupByLibrary.simpleMessage("Month"),
        "solarPowerTitlePeriodYear":
            MessageLookupByLibrary.simpleMessage("Year")
      };
}
