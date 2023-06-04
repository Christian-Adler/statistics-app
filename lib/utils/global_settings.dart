import 'dart:core';

class GlobalSettings {
  static double menuScrollPos = 0;
  static double appBarHeight = 0;

  static const _numFirstDrawRelevantProvidersRequired = 2;
  static int _numFirstDrawRelevantProvidersInitialized = 0;

  static void onFirstDrawRelevantProviderInitialized() {
    _numFirstDrawRelevantProvidersInitialized++;
  }

  static bool allFirstDrawRelevantProvidersInitialized() {
    return _numFirstDrawRelevantProvidersInitialized >= _numFirstDrawRelevantProvidersRequired;
  }
}
