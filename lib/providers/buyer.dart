import 'package:aqua_meals_seller/models/buyers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyerProvider with ChangeNotifier {
  List<BuyerModel> _buyersList = [];

  List<BuyerModel> get getBuyersList => _buyersList;

  Future<void> fetchBuyers() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc("WvamEGwHsbNkF3KImk2V")
        .collection("buyer")
        .get()
        .then((QuerySnapshot productSnapshot) {
      _buyersList = [];
      for (var document in productSnapshot.docs) {
        Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        _buyersList.insert(
          0,
          BuyerModel.fromMap(dataMap, document.id),
        );
      }
    });
    notifyListeners();
  }

  BuyerModel getBuyerByID(String buyerID) {
    return _buyersList.firstWhere((element) => element.id == buyerID);
  }
}
