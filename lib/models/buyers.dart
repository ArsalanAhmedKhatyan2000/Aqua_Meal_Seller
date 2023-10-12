import 'package:flutter/cupertino.dart';

class BuyerModel with ChangeNotifier {
  final String? name, email, phoneNumber;
  final String? id;

  BuyerModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
  });

  factory BuyerModel.fromMap(Map<String, dynamic> map, String productID) {
    return BuyerModel(
      id: productID,
      name: map["name"],
      email: map["email"],
      phoneNumber: map["phoneNumber"],
    );
  }
}
