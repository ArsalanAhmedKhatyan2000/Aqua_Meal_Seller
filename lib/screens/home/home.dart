import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/crud/crud.dart';
import 'package:aqua_meals_seller/helper/bottom_navigation_key.dart';
import 'package:aqua_meals_seller/helper/tab_bar.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/models/products.dart';
import 'package:aqua_meals_seller/providers/order_details_provider.dart';
import 'package:aqua_meals_seller/providers/orders_provider.dart';
import 'package:aqua_meals_seller/providers/products_provider.dart';
import 'package:aqua_meals_seller/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String routeName = "/Home";
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CRUD crudOperations = CRUD();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    List<ProductModel> productsList = productProvider.getProductsList;
    final pendingOrdersList = ordersProvider.getPendingOrders(context);
    final confirmedOrdersList = ordersProvider.getConfirmedOrders(context);
    double totalSales = 0;
    for (var item in confirmedOrdersList) {
      totalSales = totalSales +
          orderDetailsProvider.getTotalPriceByOrderID(item.orderID) +
          deliveryPrice;
    }
    return SafeArea(
      bottom: false,
      top: true,
      child: Scaffold(
        extendBody: true,
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(fontSize: getProportionateScreenWidth(20)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(20),
                  bottom: getProportionateScreenHeight(20),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    direction: Axis.horizontal,
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: getProportionateScreenWidth(40),
                    runSpacing: getProportionateScreenHeight(10),
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      HomeCard(
                        title: "Pending Orders",
                        value: pendingOrdersList.isNotEmpty
                            ? "${pendingOrdersList.length}"
                            : "0",
                        onTap: () {
                          TabBarPageIndex.setTabBarIndex(newTabBarIndex: 0);
                          BottomNavigationBarKey.getBottomNavigationBarKey()
                              .currentState!
                              .setPage(1);
                        },
                      ),
                      HomeCard(
                        title: "Confirmed Orders",
                        value: confirmedOrdersList.isNotEmpty
                            ? "${confirmedOrdersList.length}"
                            : "0",
                        onTap: () {
                          TabBarPageIndex.setTabBarIndex(newTabBarIndex: 1);
                          BottomNavigationBarKey.getBottomNavigationBarKey()
                              .currentState!
                              .setPage(1);
                        },
                      ),
                      HomeCard(
                        title: "Total Products",
                        value: productsList.length.toString(),
                        onTap: () {
                          BottomNavigationBarKey.getBottomNavigationBarKey()
                              .currentState!
                              .setPage(0);
                        },
                      ),
                      HomeCard(
                        title: "Total Sales",
                        value: "$totalSales",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String? _title;
  final String? _value;
  final void Function()? _onTap;
  const HomeCard({
    Key? key,
    String? title,
    String? value,
    void Function()? onTap,
  })  : _title = title,
        _value = value,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
      ),
      child: InkWell(
        onTap: _onTap,
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
        child: Container(
          width: getProportionateScreenWidth(120),
          height: getProportionateScreenHeight(120),
          padding: EdgeInsets.all(getProportionateScreenWidth(10)),
          // decoration: BoxDecoration(
          //   color: Colors.red,
          //   borderRadius: BorderRadius.all(
          //       Radius.circular(getProportionateScreenWidth(20))),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(120),
                height: getProportionateScreenHeight(60),
                child: Text(
                  _title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(15),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    _value!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
