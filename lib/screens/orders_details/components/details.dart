import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/providers/order_details_provider.dart';
import 'package:aqua_meals_seller/providers/orders_provider.dart';
import 'package:aqua_meals_seller/widgets/build_custom_button.dart';
import 'package:aqua_meals_seller/widgets/build_label_with_value.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  final String? _orderID;

  const Details({Key? key, required String? orderID})
      : _orderID = orderID,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    final orderModel = ordersProvider.getOrdersByOrderID(_orderID);
    final orderDetailsItems = orderDetailsProvider.getItemsByOrderID(_orderID);
    final double price = orderDetailsProvider.getTotalPriceByOrderID(_orderID);
    const double discount = discountPercentage;
    final totalAmount = price + deliveryPrice;

    return Container(
      // height: SizeConfig.screenHeight * 0.35,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(getProportionateScreenWidth(30)),
          topLeft: Radius.circular(getProportionateScreenWidth(30)),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          top: getProportionateScreenWidth(1),
          left: getProportionateScreenWidth(1),
          right: getProportionateScreenWidth(1),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10),
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(getProportionateScreenWidth(30)),
            topLeft: Radius.circular(getProportionateScreenWidth(30)),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BuildLabelWithValue(
              label: "Status",
              value:
                  orderDetailsItems[0].status == "0" ? "Pending" : "Completed",
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            // BuildLabelWithValue(
            //   label: "Quantity",
            //   value: "${orderDetailsItems.length}",
            // ),
            // SizedBox(height: getProportionateScreenHeight(5)),
            BuildLabelWithValue(
              label: "Price",
              value: "$price Rs",
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            const BuildLabelWithValue(
              label: "Discount",
              value: "$discount %",
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            const BuildLabelWithValue(
              label: "Delivery Charges",
              value: "$deliveryPrice Rs",
            ),
            // SizedBox(height: getProportionateScreenHeight(5)),
            // const BuildLabelWithValue(
            //   label: "Tax",
            //   value: "$tax Rs",
            // ),
            const Divider(color: Colors.black),
            BuildLabelWithValue(
              label: "Total Amount",
              value: "$totalAmount Rs",
            ),
            const Divider(color: Colors.black),
            SizedBox(height: getProportionateScreenHeight(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: kLightPrimaryColor,
                  size: getProportionateScreenWidth(20),
                ),
                SizedBox(width: getProportionateScreenWidth(5)),
                Flexible(
                  child: Text(
                    orderModel.address!,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      color: klightTextColor,
                      fontSize: getProportionateScreenWidth(12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/images/cash_on_delivery.svg",
                      color: kLightPrimaryColor,
                      fit: BoxFit.cover,
                      width: getProportionateScreenWidth(20),
                      height: getProportionateScreenHeight(20),
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    Text(
                      orderModel.paymentMethod == 0
                          ? "Cash on Delivery"
                          : "Online Payment",
                      style: TextStyle(
                        color: klightTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Order Date: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kLightPrimaryColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                    TextSpan(
                      text: DateFormat("d-M-y")
                          .add_jm()
                          .format(orderModel.orderDate!),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: klightTextColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Visibility(
              visible: orderDetailsItems[0].status == "0" ? true : false,
              child: BuildSmallButton(
                text: "Click to complete".toUpperCase(),
                backgroundcolor: Colors.green,
                width: SizeConfig.screenWidth,
                height: 50,
                onPressed: () async {
                  for (var item in orderDetailsItems) {
                    await FirebaseFirestore.instance
                        .collection("orders")
                        .doc("3I5gqAREx3MaA4C89QvT")
                        .collection("orderDetails")
                        .doc(item.orderDetailsID)
                        .update({"status": "1"});
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
