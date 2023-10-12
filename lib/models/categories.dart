import 'package:flutter/material.dart';

class CategoryModel with ChangeNotifier {
  final String? id;
  final String? name;
  final String? image;

  CategoryModel({
    this.id,
    this.name,
    this.image,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map, String productID) {
    return CategoryModel(
      id: productID,
      name: map["name"],
      image: map["image"],
    );
  }
}
