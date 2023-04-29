import 'package:flutter/material.dart';

class MediaQueryUtils {
  final MediaQueryData mediaQueryData;

  /// usage:
  ///
  /// final mediaQueryInfo = MediaQueryUtils(MediaQuery.of(context));
  MediaQueryUtils(this.mediaQueryData);

  Orientation get orientation {
    return mediaOrientation(mediaQueryData);
  }

  bool get isLandscape {
    return mediaIsLandscape(mediaQueryData);
  }

  bool get isTablet {
    return mediaIsTablet(mediaQueryData);
  }

  static Orientation mediaOrientation(MediaQueryData mediaQueryData) {
    return mediaQueryData.orientation;
  }

  static bool mediaIsLandscape(MediaQueryData mediaQueryData) {
    return mediaOrientation(mediaQueryData) == Orientation.landscape;
  }

  static bool mediaIsTablet(MediaQueryData mediaQueryData) {
    return mediaQueryData.size.width > 750;
  }
}
