class TabBarPageIndex {
  static int? _tabBArIndex = 0;

  TabBarPageIndex({int? tabBArIndex}) {
    _tabBArIndex = tabBArIndex;
  }

  static int? get getTabBarIndex => _tabBArIndex;

  static setTabBarIndex({required int? newTabBarIndex}) {
    _tabBArIndex = newTabBarIndex;
  }
}
