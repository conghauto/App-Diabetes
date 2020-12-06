class InfoUserModel {
  final String id;
  final String fullname;
  InfoUserModel({this.id, this.fullname});

  factory InfoUserModel.fromJson(Map<String, dynamic> json) {
    return InfoUserModel(
      id: json['id'],
      fullname: json['fullname'].toString(),
    );
  }
}