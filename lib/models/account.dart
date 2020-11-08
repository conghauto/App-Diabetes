class AccountModel {
  final String id;
  final String fullname;
  final String username;
  final String email;
  final String phone;

  AccountModel({this.id, this.fullname, this.username, this.email, this.phone});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      fullname: json['fullname'].toString(),
      username: json['username'].toString(),
      email: json['email'].toString(),
      phone: json['phone'].toString(),
    );
  }
}