class AccountModel {
  final String id;
  final String fullname;
  final String username;
  final String email;
  final String phone;
  final String avatar;
  AccountModel({this.id, this.fullname, this.username, this.email,
    this.phone, this.avatar});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      fullname: json['fullname'].toString(),
      username: json['username'].toString(),
      email: json['email'].toString(),
      phone: json['phone'].toString(),
      avatar: json['avatar'].toString(),
    );
  }
}