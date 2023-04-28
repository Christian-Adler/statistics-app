import 'package:flutter/material.dart';

class ScreenLayoutBuilder extends StatelessWidget {
  final Widget body; // auch als Builder mit parameter der Widgetgroesse + orientatin
  final Widget drawer; // TODO builder weil muss ja nicht immer erzeugt werden - builder der Navigation- Liste liefert?
  // Der koennte Parameter erhlaten : orientation oder type
  // Small Drawer ? Also nur Icons?
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const ScreenLayoutBuilder(
      {Key? key, required this.body, required this.drawer, this.appBar, this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final orientation = mediaQueryData.orientation;
    final isLandscape = orientation == Orientation.landscape;
    final isTablet = mediaQueryData.size.width > 750;
    // print(orientation);
    // print(mediaQueryData.size);
    // print(isTablet);
    bool useDrawer = true;
    if (isLandscape && isTablet) {
      useDrawer = false;
    }

    // TODO ScreenSize
    // TODO SplitView davon abhaenigi
    return Scaffold(
      appBar: appBar,
      drawer: useDrawer ? drawer : null,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
