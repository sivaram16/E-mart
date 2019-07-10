import 'package:pazhamuthir_emart/models/AddressModel.dart';
import 'package:pazhamuthir_emart/models/CartItemModel.dart';
import 'package:pazhamuthir_emart/models/StaffModel.dart';


class OrderModel {
  final String id;
  final String orderNo;
  final AddressModel address;
  final List<CartItemModel> cartItems;
  final String status;
  final DateTime datePlaced;
  final DateTime updatedDate;
  final StaffModel staff;

  OrderModel(
      {this.id,
      this.orderNo,
      this.address,
      this.cartItems,
      this.status,
      this.datePlaced,
      this.updatedDate,
      this.staff});

  factory OrderModel.fromJson(Map<dynamic, dynamic> json) {
    List cartItems = json['cartItems'];
    return OrderModel(
        id: json['id'],
        orderNo: json['orderNo'],
        address: AddressModel.fromJson(json['address']),
        cartItems:
            cartItems.map((item) => CartItemModel.fromJson(item)).toList(),
        status: json['status'],
        datePlaced: DateTime.parse(json['datePlaced']),
        updatedDate: DateTime.parse(json['updatedDate']),
        staff: StaffModel.fromJson(json['staff']));
  }
}
