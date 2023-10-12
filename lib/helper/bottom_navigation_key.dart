import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarKey {
  BottomNavigationBarKey._();

  static final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey();

  static GlobalKey<CurvedNavigationBarState> getBottomNavigationBarKey() {
    return _bottomNavigationKey;
  }
}
