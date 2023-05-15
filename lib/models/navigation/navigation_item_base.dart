import 'navigation_item_type.dart';

class NavigationItemBase {
  final NavigationItemType navigationItemType;

  NavigationItemBase(this.navigationItemType);

  bool get isNavigation => navigationItemType == NavigationItemType.navigation;

  bool get isDividerSmall => navigationItemType == NavigationItemType.dividerSmall;

  bool get isDividerLarge => navigationItemType == NavigationItemType.dividerLarge;
}
