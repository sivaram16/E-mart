import 'package:pazhamuthir_emart/models/AddressModel.dart';

class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final List<AddressModel> addresses;

  UserModel({this.id, this.name, this.phoneNumber, this.addresses});

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    List addresses = json['address'];
    return UserModel(
        addresses: addresses.map((item) => AddressModel.fromJson(item)),
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber']);
  }
}
