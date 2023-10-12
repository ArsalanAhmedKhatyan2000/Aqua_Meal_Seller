import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AboutModel with ChangeNotifier {
  final String? _id;
  final String? _title;
  final String? _description;

  AboutModel({
    String? id,
    String? title,
    String? description,
  })  : _id = id,
        _title = title,
        _description = description;

  factory AboutModel.fromMap(Map<String, dynamic> map, String? docID) {
    return AboutModel(
      id: docID,
      title: map['title'],
      description: map['description'],
    );
  }

  String? get getID => _id;
  String? get getTitle => _title;
  String? get getDescription => _description;
}

class AboutProvider with ChangeNotifier {
  List<AboutModel> _aboutList = [];

  List<AboutModel> get getAboutList => _aboutList;

  Future<void> fetchAboutData() async {
    await FirebaseFirestore.instance
        .collection('about')
        .orderBy('title', descending: true)
        .get()
        .then((QuerySnapshot snapshot) {
      _aboutList = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> dataMap = doc.data() as Map<String, dynamic>;
        _aboutList.insert(0, AboutModel.fromMap(dataMap, doc.id));
      }
    });
    notifyListeners();
  }
}
