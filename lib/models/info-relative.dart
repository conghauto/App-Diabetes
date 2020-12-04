class InfoRelativeModel {
  final String id;
  final String emailRelative;
  InfoRelativeModel({this.id, this.emailRelative});

  factory InfoRelativeModel.fromJson(Map<String, dynamic> json) {
    return InfoRelativeModel(
      id: json['id'],
      emailRelative: json['emailRelative'].toString(),
    );
  }
}