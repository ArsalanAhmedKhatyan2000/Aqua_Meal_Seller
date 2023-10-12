import 'package:aqua_meals_seller/helper/bottom_navigation_key.dart';
import 'package:aqua_meals_seller/providers/order_details_provider.dart';
import 'package:aqua_meals_seller/providers/orders_provider.dart';
import 'package:aqua_meals_seller/screens/add_Products/add_products.dart';
import 'package:aqua_meals_seller/screens/my_orders/order_tabbar.dart';
import 'package:aqua_meals_seller/screens/my_products/my_products.dart';
import 'package:aqua_meals_seller/screens/home/home.dart';
import 'package:aqua_meals_seller/screens/my_profile/my_profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class BuildCurvedBottomNavigationBar extends StatefulWidget {
  static const String routeName = "/buildCurvedBottomNavigationBar";
  const BuildCurvedBottomNavigationBar({Key? key}) : super(key: key);
  @override
  _BuildCurvedBottomNavigationBarState createState() =>
      _BuildCurvedBottomNavigationBarState();
}

class _BuildCurvedBottomNavigationBarState
    extends State<BuildCurvedBottomNavigationBar> {
  int _page = 2;

  final _screens = [
    const MyProducts(),
    const OrdersTabBar(),
    const Home(),
    const AddProduct(),
    const MyProfile(),
  ];
  // final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const _items2 = <Widget>[
      Icon(MdiIcons.cubeOutline, size: 30),
      Icon(MdiIcons.clipboardTextOutline, size: 30),
      Icon(Icons.home, size: 30),
      Icon(Icons.add, size: 30),
      Icon(Icons.person_rounded, size: 30),
    ];
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    ordersProvider.fetchOrders();
    orderDetailsProvider.fetchOrdersDetails();
    return SafeArea(
      top: true,
      child: Scaffold(
          extendBody: true,
          body: _screens[_page],
          bottomNavigationBar: CustomBottomNavigationBar(
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            // bottomNavigationKey: _bottomNavigationKey,
            bottomNavigationKey:
                BottomNavigationBarKey.getBottomNavigationBarKey(),
            items: _items2,
            context: context,
          )),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final Key? _bottomNavigationKey;
  final dynamic _items;
  final BuildContext _context;
  final void Function(int)? _onTap;
  const CustomBottomNavigationBar({
    Key? key,
    Key? bottomNavigationKey,
    dynamic items,
    context,
    void Function(int)? onTap,
  })  : _bottomNavigationKey = bottomNavigationKey,
        _items = items,
        _onTap = onTap,
        _context = context,
        super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(widget._context)
          .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
      child: CurvedNavigationBar(
        key: widget._bottomNavigationKey,
        index: 2,
        height: 50.0,
        items: widget._items,
        color: Theme.of(context).primaryColor,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.transparent,
        // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: widget._onTap,
        letIndexChange: (index) => true,
      ),
    );
  }
}
