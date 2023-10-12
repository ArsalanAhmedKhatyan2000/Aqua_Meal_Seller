import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/providers/orders_provider.dart';
import 'package:aqua_meals_seller/screens/my_orders/components/orders_tile.dart';
import 'package:aqua_meals_seller/widgets/build_empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmedOrders extends StatelessWidget {
  static const String routeName = "/ConfirmedOrders";
  const ConfirmedOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final confirmedOrdersList = ordersProvider.getConfirmedOrders(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: confirmedOrdersList.isNotEmpty
          ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: confirmedOrdersList.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  SizedBox(height: getProportionateScreenHeight(10)),
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
              ),
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: confirmedOrdersList[index],
                child: const OrdersTile(isHistoryOrder: true),
              ),
            )
          : const EmptyScreen(
              svgImagePath: "assets/images/pending_orders.svg",
              title: "Oops! Empty Confirmed Orders",
              description:
                  "Sorry, there are no products in the confirmed orders.",
            ),
    );
  }
}
