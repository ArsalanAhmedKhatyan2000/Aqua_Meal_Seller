import 'package:aqua_meals_seller/models/orders.dart';
import 'package:aqua_meals_seller/models/users.dart';
import 'package:aqua_meals_seller/providers/order_details_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OrdersProvider with ChangeNotifier {
  List<OrdersModel> _ordersList = [];

  List<OrdersModel> get getOrdersList => _ordersList;

  Future<void> fetchOrders() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc("3I5gqAREx3MaA4C89QvT")
        .collection("orders")
        .where("sellerIDs", arrayContains: Users.getUserId)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _ordersList = [];
      for (var document in ordersSnapshot.docs) {
        Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        _ordersList.insert(
          0,
          OrdersModel.fromMap(dataMap),
        );
      }
    });
    notifyListeners();
  }

  List<OrdersModel> getPendingOrders(BuildContext context) {
    // final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final orderDetailsProvider =
        Provider.of<OrderDetailsProvider>(context, listen: false);
    List<OrdersModel> pendingOrders = [];
    for (var items in _ordersList) {
      final orderItems = orderDetailsProvider.getItemsByOrderID(items.orderID);
      int status = 0;
      for (var i in orderItems) {
        if (i.status == "1") {
          status = 1;
        }
      }
      // if (orderItems[0].status == "1") {
      //   status = 1;
      // }
      if (status == 0) {
        pendingOrders.insert(0, items);
      }
    }
    pendingOrders.sort((b, a) => a.orderDate!.compareTo(b.orderDate!));
    return pendingOrders;
    // List<OrdersModel> list = _ordersList
    //     .where((element) => element.status == 0)
    //     .toList(); //0 indicates confirmed orders
    // list.sort((b, a) => a.orderDate!.compareTo(b.orderDate!));
    // return list;
  }

  List<OrdersModel> getConfirmedOrders(context) {
    // final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final orderDetailsProvider =
        Provider.of<OrderDetailsProvider>(context, listen: false);
    List<OrdersModel> pendingOrders = [];
    for (var items in _ordersList) {
      final orderItems = orderDetailsProvider.getItemsByOrderID(items.orderID);
      int status = 1;
      for (var i in orderItems) {
        if (i.status == "0") {
          status = 0;
        }
      }
      // if (orderItems[0].status == "0") {
      //   status = 0;
      // }
      if (status == 1) {
        pendingOrders.insert(0, items);
      }
    }
    pendingOrders.sort((b, a) => a.orderDate!.compareTo(b.orderDate!));
    return pendingOrders;
    // List<OrdersModel> list = _ordersList
    //     .where((element) => element.status == 1)
    //     .toList(); //1 indicates confirmed orders
    // list.sort((b, a) => a.orderDate!.compareTo(b.orderDate!));
    // return list;
  }

  OrdersModel getOrdersByOrderID(String? orderID) {
    return _ordersList.firstWhere((element) => element.orderID == orderID);
  }

  void clearLocalOrders() {
    _ordersList.clear();
    notifyListeners();
  }
}
