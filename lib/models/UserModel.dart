import 'package:pazhamuthir_emart/models/AddressModel.dart';

class UserModel {
  final String id;
  final String name;
  final String phoneNumber;

  UserModel({this.id, this.name, this.phoneNumber});

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
        id: json['id'], name: json['name'], phoneNumber: json['phoneNumber']);
  }
}
