class StaffModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String token;
  final bool isActive;
  final String status;
  final String accountType;

  StaffModel(
      {this.id,
      this.name,
      this.phoneNumber,
      this.token,
      this.accountType,
      this.status,
      this.isActive});

  factory StaffModel.fromJson(Map<dynamic, dynamic> json) {
    return StaffModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
      isActive: json['isActive'],
      status: json['status'],
      accountType: json['accountType']
    );
  }
}
