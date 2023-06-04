// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(price, feePerMont) =>
      "Preis : ${price} €/kWh, Grundgebühr : ${feePerMont} €/Monat";

  static String m1(period) => "kWh / ${period}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "authBtnLogin": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "authErrorMsgAuthenticationFailed":
            MessageLookupByLibrary.simpleMessage(
                "Login fehlgeschlagen. Bitte später nochmals versuchen."),
        "authInputLabelPassword":
            MessageLookupByLibrary.simpleMessage("Passwort"),
        "authInputLabelServer": MessageLookupByLibrary.simpleMessage("Server"),
        "authInputValidatorMsgEnterValidServer":
            MessageLookupByLibrary.simpleMessage(
                "Geben sie einen validen Server an!"),
        "authInputValidatorMsgPasswordToShort":
            MessageLookupByLibrary.simpleMessage(
                "Geben sie ein gültiges Passwort ein!"),
        "bloodPressureTableHeadDate":
            MessageLookupByLibrary.simpleMessage("Datum"),
        "bloodPressureTableHeadEvening":
            MessageLookupByLibrary.simpleMessage("Abend"),
        "bloodPressureTableHeadMidday":
            MessageLookupByLibrary.simpleMessage("Mittag"),
        "bloodPressureTableHeadMorning":
            MessageLookupByLibrary.simpleMessage("Morgen"),
        "carTableHeadDate": MessageLookupByLibrary.simpleMessage("Datum"),
        "carTableHeadEuro": MessageLookupByLibrary.simpleMessage("€"),
        "carTableHeadEuroPerLiter": MessageLookupByLibrary.simpleMessage("€/l"),
        "carTableHeadKilometers": MessageLookupByLibrary.simpleMessage("km"),
        "carTableHeadLiters": MessageLookupByLibrary.simpleMessage("l"),
        "carTableHeadLitersPer100Kilometers":
            MessageLookupByLibrary.simpleMessage("l/100km"),
        "commonsDialogBtnNo": MessageLookupByLibrary.simpleMessage("Nein"),
        "commonsDialogBtnOkay": MessageLookupByLibrary.simpleMessage("Ok"),
        "commonsDialogBtnYes": MessageLookupByLibrary.simpleMessage("Ja"),
        "commonsDialogTitleAreYouSure":
            MessageLookupByLibrary.simpleMessage("Sind sie sicher?"),
        "commonsDialogTitleErrorOccurred":
            MessageLookupByLibrary.simpleMessage("Fehler"),
        "commonsLogout": MessageLookupByLibrary.simpleMessage("Abmelden"),
        "commonsMsgErrorFailedToLoadData": MessageLookupByLibrary.simpleMessage(
            "Fehler beim Laden der Daten..."),
        "localeNameEnglish": MessageLookupByLibrary.simpleMessage("English"),
        "localeNameGerman": MessageLookupByLibrary.simpleMessage("Deutsch"),
        "localeNameSystem": MessageLookupByLibrary.simpleMessage("System"),
        "patternsDateWeekdayWithDate":
            MessageLookupByLibrary.simpleMessage("E, dd.MM.yyyy"),
        "patternsDateYYYYMMDD":
            MessageLookupByLibrary.simpleMessage("yyyy-MM-dd"),
        "screenTitleCar": MessageLookupByLibrary.simpleMessage("Tanken"),
        "screenTitleCarAddValue":
            MessageLookupByLibrary.simpleMessage("Tanken eintragen"),
        "screenTitleHeart": MessageLookupByLibrary.simpleMessage("Blutdruck"),
        "screenTitleHeartAddValue":
            MessageLookupByLibrary.simpleMessage("Blutdruck eintragen"),
        "screenTitleInfo": MessageLookupByLibrary.simpleMessage("Info"),
        "screenTitleOperating":
            MessageLookupByLibrary.simpleMessage("Nebenkosten"),
        "screenTitleOperatingAddValue":
            MessageLookupByLibrary.simpleMessage("Betriebskosten eintragen"),
        "screenTitleOverview":
            MessageLookupByLibrary.simpleMessage("Übersicht"),
        "screenTitleSettings":
            MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "screenTitleSolarPower":
            MessageLookupByLibrary.simpleMessage("Solar-Strom"),
        "screenTitleSolarPowerAddValue": MessageLookupByLibrary.simpleMessage(
            "Solar-Energie-Ertrag eintragen"),
        "settingsDeviceStorageBtnClearStorageAndLogout":
            MessageLookupByLibrary.simpleMessage(
                "Lösche gespeicherte App-Daten & Abmelden"),
        "settingsDeviceStorageDialogMsgRemoveAllDataAndLogout":
            MessageLookupByLibrary.simpleMessage(
                "Wollen sie wirklich alle App-Daten löschen und abmelden?"),
        "settingsDeviceStorageLabelShowAuthData":
            MessageLookupByLibrary.simpleMessage("Login-Daten anzeigen"),
        "settingsDeviceStorageTableHeadKey":
            MessageLookupByLibrary.simpleMessage("Schlüssel"),
        "settingsDeviceStorageTableHeadValue":
            MessageLookupByLibrary.simpleMessage("Wert"),
        "settingsDeviceStorageTitle":
            MessageLookupByLibrary.simpleMessage("Geräte-Speicher"),
        "settingsLanguageLabelChooseLanguage":
            MessageLookupByLibrary.simpleMessage("Sprache"),
        "settingsLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Sprache"),
        "settingsLayoutLabelShowNavigationTitles":
            MessageLookupByLibrary.simpleMessage(
                "Texte in Navigation anzeigen (Menü, Navigationsleiste)"),
        "settingsLayoutLabelShowOverviewIsometricButtons":
            MessageLookupByLibrary.simpleMessage(
                "In Übersicht isometrische Buttons anzeigen"),
        "settingsLayoutLabelShowOverviewParallaxEffect":
            MessageLookupByLibrary.simpleMessage(
                "In Übersicht Parallax-Effekt anzeigen (CPU intensiv)"),
        "settingsLayoutTitle": MessageLookupByLibrary.simpleMessage("Anzeige"),
        "settingsServerInputLabelServer":
            MessageLookupByLibrary.simpleMessage("Server"),
        "settingsServerInputValidatorMsgEnterServer":
            MessageLookupByLibrary.simpleMessage(
                "Geben sie eine Server-Adresse ein!"),
        "settingsServerInputValidatorMsgProvideValidServer":
            MessageLookupByLibrary.simpleMessage(
                "Geben sie eine gültige Server-Adresse ein!"),
        "settingsServerSnackbarMsgServerRemoved":
            MessageLookupByLibrary.simpleMessage("Server entfernt..."),
        "settingsServerTitle": MessageLookupByLibrary.simpleMessage("Server"),
        "settingsThemeLabelChooseMainColor":
            MessageLookupByLibrary.simpleMessage("Hauptfarbe"),
        "settingsThemeLabelChooseMode":
            MessageLookupByLibrary.simpleMessage("Modus"),
        "settingsThemeModeDark": MessageLookupByLibrary.simpleMessage("Dunkel"),
        "settingsThemeModeLight": MessageLookupByLibrary.simpleMessage("Hell"),
        "settingsThemeModeSystem":
            MessageLookupByLibrary.simpleMessage("System"),
        "settingsThemeTitle":
            MessageLookupByLibrary.simpleMessage("Modus & Farbe"),
        "solarPowerChartLegendItemConsumption":
            MessageLookupByLibrary.simpleMessage("Verbrauch"),
        "solarPowerChartLegendItemFed":
            MessageLookupByLibrary.simpleMessage("Eingespeist"),
        "solarPowerChartLegendItemGenerated":
            MessageLookupByLibrary.simpleMessage("Erzeugt"),
        "solarPowerChartLegendItemTotal":
            MessageLookupByLibrary.simpleMessage("Gesamt"),
        "solarPowerChartSubLegendPriceAndFee": m0,
        "solarPowerTableHeadConsumption":
            MessageLookupByLibrary.simpleMessage("Verbrauch"),
        "solarPowerTableHeadConsumptionAbbrev":
            MessageLookupByLibrary.simpleMessage("Verbr."),
        "solarPowerTableHeadDate":
            MessageLookupByLibrary.simpleMessage("Datum"),
        "solarPowerTableHeadFed":
            MessageLookupByLibrary.simpleMessage("Eingespeist"),
        "solarPowerTableHeadFedAbbrev":
            MessageLookupByLibrary.simpleMessage("Eingesp."),
        "solarPowerTableHeadGenerated":
            MessageLookupByLibrary.simpleMessage("Erzeugt"),
        "solarPowerTableHeadGeneratedAbbrev":
            MessageLookupByLibrary.simpleMessage("Erzeugt"),
        "solarPowerTableHeadTotal":
            MessageLookupByLibrary.simpleMessage("Gesamt"),
        "solarPowerTableHeadTotalAbbrev":
            MessageLookupByLibrary.simpleMessage("Gesamt"),
        "solarPowerTitle": m1,
        "solarPowerTitlePeriodMonth":
            MessageLookupByLibrary.simpleMessage("Monat"),
        "solarPowerTitlePeriodYear":
            MessageLookupByLibrary.simpleMessage("Jahr")
      };
}
