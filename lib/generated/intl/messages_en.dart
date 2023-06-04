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

  static String m0(price, feePerMont) =>
      "Price : ${price} €/kWh, Basic fee : ${feePerMont} €/Monat";

  static String m1(period) => "kWh / ${period}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "authBtnLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "authErrorMsgAuthenticationFailed":
            MessageLookupByLibrary.simpleMessage(
                "Could not authenticate you. Please try again later."),
        "authInputLabelPassword":
            MessageLookupByLibrary.simpleMessage("Password"),
        "authInputLabelServer": MessageLookupByLibrary.simpleMessage("Server"),
        "authInputValidatorMsgEnterValidServer":
            MessageLookupByLibrary.simpleMessage("Enter a valid server!"),
        "authInputValidatorMsgPasswordToShort":
            MessageLookupByLibrary.simpleMessage("Password is too short!"),
        "bloodPressureTableHeadDate":
            MessageLookupByLibrary.simpleMessage("Date"),
        "bloodPressureTableHeadEvening":
            MessageLookupByLibrary.simpleMessage("Evening"),
        "bloodPressureTableHeadMidday":
            MessageLookupByLibrary.simpleMessage("Midday"),
        "bloodPressureTableHeadMorning":
            MessageLookupByLibrary.simpleMessage("Morning"),
        "carTableHeadDate": MessageLookupByLibrary.simpleMessage("Date"),
        "carTableHeadEuro": MessageLookupByLibrary.simpleMessage("€"),
        "carTableHeadEuroPerLiter": MessageLookupByLibrary.simpleMessage("€/l"),
        "carTableHeadKilometers": MessageLookupByLibrary.simpleMessage("km"),
        "carTableHeadLiters": MessageLookupByLibrary.simpleMessage("l"),
        "carTableHeadLitersPer100Kilometers":
            MessageLookupByLibrary.simpleMessage("l/100km"),
        "commonsDialogBtnNo": MessageLookupByLibrary.simpleMessage("No"),
        "commonsDialogBtnOkay": MessageLookupByLibrary.simpleMessage("Ok"),
        "commonsDialogBtnYes": MessageLookupByLibrary.simpleMessage("Yes"),
        "commonsDialogTitleAreYouSure":
            MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "commonsDialogTitleErrorOccurred":
            MessageLookupByLibrary.simpleMessage("An Error Occurred"),
        "commonsLogout": MessageLookupByLibrary.simpleMessage("Logout"),
        "commonsMsgErrorFailedToLoadData":
            MessageLookupByLibrary.simpleMessage("Failed to load data..."),
        "localeNameEnglish": MessageLookupByLibrary.simpleMessage("English"),
        "localeNameGerman": MessageLookupByLibrary.simpleMessage("Deutsch"),
        "localeNameSystem": MessageLookupByLibrary.simpleMessage("System"),
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
        "settingsDeviceStorageDialogMsgRemoveAllDataAndLogout":
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
        "solarPowerChartLegendItemConsumption":
            MessageLookupByLibrary.simpleMessage("Consumption"),
        "solarPowerChartLegendItemFed":
            MessageLookupByLibrary.simpleMessage("Fed"),
        "solarPowerChartLegendItemGenerated":
            MessageLookupByLibrary.simpleMessage("Generated"),
        "solarPowerChartLegendItemTotal":
            MessageLookupByLibrary.simpleMessage("Total"),
        "solarPowerChartSubLegendPriceAndFee": m0,
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
        "solarPowerTitle": m1,
        "solarPowerTitlePeriodMonth":
            MessageLookupByLibrary.simpleMessage("Month"),
        "solarPowerTitlePeriodYear":
            MessageLookupByLibrary.simpleMessage("Year")
      };
}
