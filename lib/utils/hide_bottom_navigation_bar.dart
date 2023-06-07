import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class HideBottomNavigationBar {
  static final ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  static void setScrollPosition(ScrollPosition scrollPos) {
    // Scroller ganz oben? Dann auf jeden Fall wieder anzeigen
    if (scrollPos.pixels == 0) {
      visible.value = true;
    } else if (scrollPos.userScrollDirection == ScrollDirection.reverse && visible.value) {
      visible.value = false;
    } else if (scrollPos.userScrollDirection == ScrollDirection.forward && !visible.value) {
      visible.value = true;
    }
  }

  static void setVisible(bool value) {
    if (visible.value != value) {
      visible.value = value;
    }
  }
}
