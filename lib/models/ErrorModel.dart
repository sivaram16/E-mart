class ErrorModel {
  final String path;
  final String message;

  ErrorModel({this.path, this.message}) {
    if (path.isEmpty && message.isEmpty) return;
    print("**** SERVER RETURNED ERROR $path ****");
    throw Exception('$path - $message');
  }

  factory ErrorModel.fromJson(Map<dynamic, dynamic> json) {
    return ErrorModel(
      path: json['path'],
      message: json['message'],
    );
  }
}
