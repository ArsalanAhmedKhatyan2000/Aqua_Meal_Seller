import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/models/orders.dart';
import 'package:aqua_meals_seller/providers/order_details_provider.dart';
import 'package:aqua_meals_seller/providers/orders_provider.dart';
import 'package:aqua_meals_seller/screens/my_orders/components/order_detail_tile.dart';
import 'package:aqua_meals_seller/screens/my_orders/components/orders_tile.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/widgets/build_empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PendingOrders extends StatelessWidget {
  static const String routeName = "/pendingOrdersRoute";
  const PendingOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final pendingOrdersList = ordersProvider.getPendingOrders(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: pendingOrdersList.isNotEmpty
          ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: pendingOrdersList.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  SizedBox(height: getProportionateScreenHeight(10)),
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
              ),
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: pendingOrdersList[index],
                child: const OrdersTile(isHistoryOrder: false),
              ),
            )
          : const EmptyScreen(
              svgImagePath: "assets/images/pending_orders.svg",
              title: "Oops! Empty Pending Orders",
              description:
                  "Sorry, there are no products in the pending orders.",
            ),
    );
  }
}

class CustomExpensionTile extends StatelessWidget {
  const CustomExpensionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrdersModel>(context);
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    final orderDetailsItems =
        orderDetailsProvider.getItemsByOrderID(ordersModel.orderID!);
    double totalPrice =
        orderDetailsProvider.getTotalPriceByOrderID(ordersModel.orderID!);
    double grossTotal =
        totalPrice + (ordersModel.sellerIDs!.length * deliveryPrice) + orderTax;
    Color textColor = context.isLightMode
        ? Theme.of(context).textTheme.bodyText1!.color!
        : whiteColor.withOpacity(0.7);
    Color greenColor =
        context.isLightMode ? Colors.green : Colors.green.withOpacity(0.7);

    ///////
    // final ordersDetailsModel = Provider.of<OrderDetailsModel>(context);
    // final productsProvider = Provider.of<ProductsProvider>(context);
    // final getCurrProduct =
    //     productsProvider.findProdById(ordersDetailsModel.productID!);
    ///////
    // final orderModel =
    //     ordersProvider.getOrdersByOrderID(ordersDetailsModel.orderID);
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateScreenHeight(5),
      ),
      backgroundColor: Theme.of(context).cardColor,
      collapsedBackgroundColor: Theme.of(context).cardColor,
      leading: Container(
        // color: Colors.white.withOpacity(0.5),
        width: SizeConfig.screenWidth / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Order ID: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
                TextSpan(
                  text: ordersModel.orderID,
                  style: TextStyle(
                    color: textColor,
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
              ]),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "No. of Products: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
                TextSpan(
                  text: orderDetailsItems.length.toString(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
              ]),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/images/cash_on_delivery.svg",
                  color: greenColor,
                  fit: BoxFit.cover,
                  width: getProportionateScreenWidth(15),
                  height: getProportionateScreenHeight(15),
                ),
                SizedBox(width: getProportionateScreenWidth(5)),
                Text(
                  ordersModel.paymentMethod == 0
                      ? "Cash on Delivery"
                      : "Online Payment",
                  style: TextStyle(
                    color: greenColor,
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      title: const Text(""),
      trailing: Container(
        // color: Colors.white.withOpacity(0.5),
        width: SizeConfig.screenWidth / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "$grossTotal Rs",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.red,
                fontSize: getProportionateScreenWidth(12),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.access_time_outlined,
                  color: Colors.red,
                  size: getProportionateScreenWidth(15),
                ),
                SizedBox(width: getProportionateScreenWidth(5)),
                Text(
                  // DateFormat("d-M-y").add_jm().format(ordersModel.orderDate!),
                  "19-12-2022 11:13 AM",
                  style: TextStyle(
                    color: context.isLightMode
                        ? Theme.of(context).textTheme.bodyText1!.color!
                        : whiteColor.withOpacity(0.7),
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      children: [
        Divider(color: Theme.of(context).textTheme.bodyText1!.color),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            // vertical: getProportionateScreenHeight(5),
          ),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: orderDetailsItems.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) =>
                SizedBox(height: getProportionateScreenHeight(10)),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
            ),
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: orderDetailsItems[index],
              child: const OrderDetailsTile(),
            ),
          ),
        )
      ],
    );
  }
}
