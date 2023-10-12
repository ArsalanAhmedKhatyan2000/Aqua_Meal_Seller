import 'package:aqua_meals_seller/models/categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  static List<CategoryModel> _categoryList = [];

  List<CategoryModel> get getCategories => _categoryList;

  Future<void> fetchCategories() async {
    await FirebaseFirestore.instance
        .collection('category')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _categoryList = [];
      for (var document in productSnapshot.docs) {
        Map<String, dynamic> dataMap = document.data() as Map<String, dynamic>;
        _categoryList.insert(
          0,
          CategoryModel.fromMap(
            dataMap,
            document.id,
          ),
        );
      }
    });
    notifyListeners();
  }

  CategoryModel findCategoryById(String categoryId) {
    return _categoryList.firstWhere((element) => element.id == categoryId);
  }

  List<CategoryModel> searchQuery(
      String searchText, List<CategoryModel> catList) {
    return catList.where((element) {
      return element.name!.toLowerCase().contains(
            searchText.toLowerCase(),
          );
    }).toList();
  }
}
