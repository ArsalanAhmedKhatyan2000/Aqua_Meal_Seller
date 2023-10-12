import 'package:aqua_meals_seller/models/units.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UnitsProvider with ChangeNotifier {
  List<UnitsModel> _unitsList = [];

  List<UnitsModel> get getUnitsList => _unitsList;

  Future<void> fetchUnits() async {
    await FirebaseFirestore.instance
        .collection('units')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _unitsList = [];
      for (var document in productSnapshot.docs) {
        Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        _unitsList.insert(
          0,
          UnitsModel.fromMap(dataMap, document.id),
        );
      }
    });
    notifyListeners();
  }
}
