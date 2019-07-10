class AddressModel {
  final String name;
  final String addressLine;
  final String landmark;
  final String phoneNumber;

  AddressModel({this.name, this.addressLine, this.landmark, this.phoneNumber});

  factory AddressModel.fromJson(Map<dynamic, dynamic> json) {
    return AddressModel(
        name: json['name'],
        addressLine: json['addressLine'],
        landmark: json['landmark'],
        phoneNumber: json['phoneNumber']);
  }
}
