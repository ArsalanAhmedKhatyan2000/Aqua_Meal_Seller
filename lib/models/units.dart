import 'package:flutter/cupertino.dart';

class UnitsModel with ChangeNotifier {
  final String? id;
  final String? name;

  UnitsModel({
    this.id,
    this.name,
  });

  factory UnitsModel.fromMap(Map<String, dynamic> map, String id) {
    return UnitsModel(id: id, name: map['name']);
  }
}
