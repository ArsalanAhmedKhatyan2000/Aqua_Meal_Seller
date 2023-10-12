import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/models/orders.dart';
import 'package:aqua_meals_seller/providers/buyer.dart';
import 'package:aqua_meals_seller/providers/order_details_provider.dart';
import 'package:aqua_meals_seller/screens/orders_details/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersTile extends StatelessWidget {
  final bool? _isHistoryOrder;
  const OrdersTile({Key? key, bool? isHistoryOrder = false})
      : _isHistoryOrder = isHistoryOrder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrdersModel>(context);
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    final buyerProvider = Provider.of<BuyerProvider>(context);
    final orderDetailsItems =
        orderDetailsProvider.getItemsByOrderID(ordersModel.orderID!);
    double totalPrice =
        orderDetailsProvider.getTotalPriceByOrderID(ordersModel.orderID!);
    final buyerModel = buyerProvider.getBuyerByID(ordersModel.buyerID!);
    double grossTotal = totalPrice + deliveryPrice;
    Color textColor = context.isLightMode
        ? Theme.of(context).textTheme.bodyText1!.color!
        : whiteColor.withOpacity(0.7);
    Color greenColor =
        context.isLightMode ? Colors.green : Colors.green.withOpacity(0.7);

    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
            OrdersDetails.routeName,
            arguments: ordersModel.orderID,
          );
        },
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
        child: Container(
          // height: getProportionateScreenHeight(80),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(getProportionateScreenWidth(20))),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      "$grossTotal Rs",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color:
                            _isHistoryOrder == false ? Colors.red : greenColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(3)),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Order By: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                    TextSpan(
                      text: buyerModel.name,
                      style: TextStyle(
                        color: textColor,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: getProportionateScreenHeight(3)),
                Row(
                  children: [
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
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              _isHistoryOrder == false
                                  ? Icons.access_time_outlined
                                  : Icons.check_circle_rounded,
                              color: _isHistoryOrder == false
                                  ? Colors.red
                                  : greenColor,
                              size: getProportionateScreenWidth(15),
                            ),
                            SizedBox(width: getProportionateScreenWidth(5)),
                            Text(
                              DateFormat("d-M-y")
                                  .add_jm()
                                  .format(ordersModel.orderDate!),
                              style: TextStyle(
                                color: textColor,
                                fontSize: getProportionateScreenWidth(12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// class OrdersTile extends StatefulWidget {
//   final bool? _isHistoryOrder;
//   const OrdersTile({Key? key, bool? isHistoryOrder = false})
//       : _isHistoryOrder = isHistoryOrder,
//         super(key: key);

//   @override
//   State<OrdersTile> createState() => _OrdersTileState();
// }

// class _OrdersTileState extends State<OrdersTile> {
//   bool isTileOpen = false;
//   @override
//   Widget build(BuildContext context) {
//     final ordersModel = Provider.of<OrdersModel>(context);
//     final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
//     final orderDetailsItems =
//         orderDetailsProvider.getItemsByOrderID(ordersModel.orderID!);
//     double totalPrice =
//         orderDetailsProvider.getTotalPriceByOrderID(ordersModel.orderID!);
//     double grossTotal =
//         totalPrice + (ordersModel.sellerIDs!.length * deliveryPrice) + orderTax;
//     Color textColor = context.isLightMode
//         ? Theme.of(context).textTheme.bodyText1!.color!
//         : whiteColor.withOpacity(0.7);
//     Color greenColor =
//         context.isLightMode ? Colors.green : Colors.green.withOpacity(0.7);

//     return Card(
//       color: Theme.of(context).cardColor,
//       margin: const EdgeInsets.all(0),
//       shape: RoundedRectangleBorder(
//         borderRadius:
//             BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
//       ),
//       child: InkWell(
//         onTap: () {
//           // Navigator.of(context, rootNavigator: true).pushNamed(
//           //   OrdersDetails.routeName,
//           //   arguments: ordersModel.orderID,
//           // );
//           setState(() {
//             isTileOpen = !isTileOpen;
//           });
//         },
//         borderRadius:
//             BorderRadius.all(Radius.circular(getProportionateScreenWidth(20))),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           height: isTileOpen
//               ? getProportionateScreenHeight(300)
//               : getProportionateScreenHeight(81),
//           child: Column(
//             children: [
//               Container(
//                 height: getProportionateScreenHeight(80),
//                 width: SizeConfig.screenWidth,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                       Radius.circular(getProportionateScreenWidth(20))),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenWidth(10),
//                     vertical: getProportionateScreenHeight(5),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           RichText(
//                             text: TextSpan(children: [
//                               TextSpan(
//                                 text: "Order ID: ",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: textColor,
//                                   fontSize: getProportionateScreenWidth(12),
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: ordersModel.orderID,
//                                 style: TextStyle(
//                                   color: textColor,
//                                   fontSize: getProportionateScreenWidth(12),
//                                 ),
//                               ),
//                             ]),
//                           ),
//                           Text(
//                             "$grossTotal Rs",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               color: widget._isHistoryOrder == false
//                                   ? Colors.red
//                                   : greenColor,
//                               fontSize: getProportionateScreenWidth(12),
//                             ),
//                           ),
//                         ],
//                       ),
//                       RichText(
//                         text: TextSpan(children: [
//                           TextSpan(
//                             text: "No. of Products: ",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               color: textColor,
//                               fontSize: getProportionateScreenWidth(12),
//                             ),
//                           ),
//                           TextSpan(
//                             text: orderDetailsItems.length.toString(),
//                             style: TextStyle(
//                               color: textColor,
//                               fontSize: getProportionateScreenWidth(12),
//                             ),
//                           ),
//                         ]),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SvgPicture.asset(
//                                     "assets/images/cash_on_delivery.svg",
//                                     color: greenColor,
//                                     fit: BoxFit.cover,
//                                     width: getProportionateScreenWidth(15),
//                                     height: getProportionateScreenHeight(15),
//                                   ),
//                                   SizedBox(
//                                       width: getProportionateScreenWidth(5)),
//                                   Text(
//                                     ordersModel.paymentMethod == 0
//                                         ? "Cash on Delivery"
//                                         : "Online Payment",
//                                     style: TextStyle(
//                                       color: greenColor,
//                                       fontSize: getProportionateScreenWidth(12),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Icon(
//                                     widget._isHistoryOrder == false
//                                         ? Icons.access_time_outlined
//                                         : Icons.check_circle_rounded,
//                                     color: widget._isHistoryOrder == false
//                                         ? Colors.red
//                                         : greenColor,
//                                     size: getProportionateScreenWidth(15),
//                                   ),
//                                   SizedBox(
//                                       width: getProportionateScreenWidth(5)),
//                                   Text(
//                                     DateFormat("d-M-y")
//                                         .add_jm()
//                                         .format(ordersModel.orderDate!),
//                                     style: TextStyle(
//                                       color: textColor,
//                                       fontSize: getProportionateScreenWidth(12),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: true,
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 500),
//                   width: isTileOpen ? SizeConfig.screenWidth : 0,
//                   decoration: BoxDecoration(
//                     // color: Theme.of(context).textTheme.bodyText1!.color,
//                     border: Border(
//                       top: BorderSide(
//                         width: getProportionateScreenHeight(0.5),
//                         color: Theme.of(context).textTheme.bodyText1!.color!,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: isTileOpen,
//                 child: Container(
//                   color: Colors.amber,
//                   // height: getProportionateScreenHeight(105),
//                   child: ListView.separated(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: orderDetailsItems.length,
//                     shrinkWrap: true,
//                     separatorBuilder: (context, index) =>
//                         SizedBox(height: getProportionateScreenHeight(10)),
//                     padding: EdgeInsets.symmetric(
//                       vertical: getProportionateScreenHeight(10),
//                     ),
//                     itemBuilder: (context, index) =>
//                         ChangeNotifierProvider.value(
//                       value: orderDetailsItems[index],
//                       child: const OrderDetailsTile(),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DetailedTile extends StatelessWidget {
//   const DetailedTile({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children: [
//           Text("data"),
//         ],
//       ),
//     );
//   }
// }
