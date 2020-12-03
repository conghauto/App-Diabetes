class InfoUserModel {
  final String id;
  final String fullname;
  final String phoneRelative;
  InfoUserModel({this.id, this.fullname, this.phoneRelative});

  factory InfoUserModel.fromJson(Map<String, dynamic> json) {
    return InfoUserModel(
      id: json['id'],
      fullname: json['fullname'].toString(),
      phoneRelative: json['phoneRelative'].toString(),
    );
  }
}