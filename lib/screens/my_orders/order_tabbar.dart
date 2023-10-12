import 'package:aqua_meals_seller/helper/tab_bar.dart';
import 'package:aqua_meals_seller/screens/my_orders/confirmed_orders.dart';
import 'package:aqua_meals_seller/screens/my_orders/pending_orders.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OrdersTabBar extends StatefulWidget {
  static const String routeName = "/OrdersTabBar";
  const OrdersTabBar({Key? key}) : super(key: key);

  @override
  State<OrdersTabBar> createState() => _OrdersTabBarState();
}

class _OrdersTabBarState extends State<OrdersTabBar>
    with SingleTickerProviderStateMixin {
  final List<Widget> _tabBarViews = const [
    PendingOrders(),
    ConfirmedOrders(),
  ];
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(
      length: _tabBarViews.length,
      vsync: this,
      initialIndex: TabBarPageIndex.getTabBarIndex!,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      initialIndex: TabBarPageIndex.getTabBarIndex!,
      child: Scaffold(
        extendBody: true,
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: Text(
            "Orders",
            style: TextStyle(fontSize: getProportionateScreenWidth(20)),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              _tabBarOptionWidget(
                  icon: MdiIcons.clipboardClockOutline,
                  label: "Pending Orders"),
              _tabBarOptionWidget(
                  icon: MdiIcons.clipboardCheckOutline,
                  label: "Confirmed Orders"),
            ],
            onTap: (newTabIndex) {
              setState(() {
                // tabBarIndex = newTabIndex;
                TabBarPageIndex.setTabBarIndex(newTabBarIndex: newTabIndex);
              });
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabBarViews,
        ),
      ),
    );
  }

  Widget _tabBarOptionWidget(
      {required IconData? icon, required String? label}) {
    return Column(
      children: [
        Icon(icon),
        Text(
          label!,
          style: TextStyle(fontSize: getProportionateScreenWidth(15)),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
