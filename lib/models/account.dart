class AccountModel {
  final String id;
  final String fullname;
  final String email;
  final String phone;
  final String avatar;
  AccountModel({this.id, this.fullname, this.email,
    this.phone, this.avatar});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      fullname: json['fullname'].toString(),
      email: json['email'].toString(),
      phone: json['phone'].toString(),
      avatar: json['avatar'].toString(),
    );
  }
}