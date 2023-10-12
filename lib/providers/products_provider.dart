import 'dart:io';
import 'package:path/path.dart';
import 'package:aqua_meals_seller/models/products.dart';
import 'package:aqua_meals_seller/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _productsList = [];
  List<ProductModel> get getProductsList => _productsList;
  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection("products")
        .where('sellerID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      _productsList = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> dataMap = doc.data() as Map<String, dynamic>;
        _productsList.insert(
          0,
          ProductModel.fromMap(dataMap, doc.id),
        );
      }
    });
    notifyListeners();
  }

  Future<void> removeProduct(
      {required String? imageURL, required String? productID}) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productID)
        .delete();

    deleteProductImageFromStorage(imageURL: imageURL);
    _productsList.removeWhere((element) => element.productId == productID);
    notifyListeners();
  }

  Future<void> addProduct({
    required String? productName,
    required String? regularPrice,
    required String? discountedPrice,
    required String? description,
    required String? imageURL,
    required String? status,
    required String? category,
    required String? unit,
    required String? createdDate,
  }) async {
    DocumentReference<Map<String, dynamic>> docRef =
        await FirebaseFirestore.instance.collection("products").add({
      "sellerID": Users.getUserId,
      "name": productName,
      "regularPrice": regularPrice,
      "discountedPrice": discountedPrice,
      "description": description,
      "imageURL": imageURL,
      "status": status,
      "category": category,
      "unit": unit,
      "createdDate": createdDate,
      "updatedDate": "",
      "rating": [],
    });
    _productsList.insert(
      0,
      ProductModel(
        productId: docRef.id,
        sellerID: Users.getUserId,
        name: productName,
        regularPrice: regularPrice,
        discountedPrice: discountedPrice,
        description: description,
        category: category,
        createdDate: createdDate,
        imageUrl: imageURL,
        rating: [],
        status: status,
        updatedDate: "",
        unit: unit,
      ),
    );
    // await fetchProducts();
    notifyListeners();
  }

  Future<String?> uploadProductImageToStorage(
      {required String? imagePath}) async {
    File imageFile = File(imagePath!);
    String _imageBaseName = basename(imageFile.path);
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child("images")
        .child("productImages")
        .child(_imageBaseName);
    await imageReference.putFile(imageFile);
    String getImageUrl = await imageReference.getDownloadURL();
    notifyListeners();
    return getImageUrl;
  }

  Future<void> deleteProductImageFromStorage(
      {required String? imageURL}) async {
    String? imageName = imageURL!.split('2F')[2].split('?alt')[0];
    await FirebaseStorage.instance
        .ref()
        .child("images")
        .child("productImages")
        .child(imageName)
        .delete();
    notifyListeners();
  }

  Future<void> updateProduct({
    required String? productID,
    required String? productName,
    required String? regularPrice,
    required String? discountedPrice,
    required String? description,
    required String? imageURL,
    required String? status,
    required String? category,
    required String? unit,
    required String? updatedDate,
  }) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productID)
        .update({
      "name": productName,
      "regularPrice": regularPrice,
      "discountedPrice": discountedPrice,
      "description": description,
      "imageURL": imageURL,
      "status": status,
      "category": category,
      "unit": unit,
      "updatedDate": updatedDate,
    });
    await fetchProducts();
    notifyListeners();
  }

  ProductModel findProdById(String productId) {
    return _productsList
        .firstWhere((element) => element.productId == productId);
  }
}
