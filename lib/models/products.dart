import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String? sellerID;
  final String? productId;
  final String? name;
  final String? regularPrice;
  final String? discountedPrice;
  final String? description;
  final String? imageUrl;
  final String? status;
  final String? category;
  final String? unit;
  final String? createdDate;
  final String? updatedDate;
  final List? rating;

  ProductModel({
    this.productId,
    this.name,
    this.regularPrice,
    this.discountedPrice,
    this.description,
    this.imageUrl,
    this.status,
    this.createdDate,
    this.updatedDate,
    this.category,
    this.unit,
    this.rating,
    this.sellerID,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String productID) {
    return ProductModel(
      productId: productID,
      sellerID: map["sellerID"],
      name: map["name"],
      regularPrice: map["regularPrice"],
      discountedPrice: map["discountedPrice"],
      description: map["description"],
      imageUrl: map["imageURL"],
      status: map["status"],
      createdDate: map["createdDate"],
      updatedDate: map["updatedDate"],
      category: map["category"],
      unit: map["unit"],
      rating: map["rating"],
    );
  }
}
