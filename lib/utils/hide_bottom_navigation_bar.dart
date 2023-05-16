import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class HideBottomNavigationBar {
  static final ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  static void setScrollDirection(ScrollDirection userScrollDirection) {
    if (userScrollDirection == ScrollDirection.reverse && visible.value) {
      visible.value = false;
    } else if (userScrollDirection == ScrollDirection.forward && !visible.value) {
      visible.value = true;
    }
  }

  static void setVisible(bool value) {
    if (visible.value != value) {
      visible.value = value;
    }
  }
}
