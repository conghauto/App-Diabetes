class InfoUserModel {
  final String id;
  final DateTime birthday;
  final String gender;
  final String height;
  final String weight;
  final String typeDiabete;
  final String emailRelative;
  InfoUserModel({this.id, this.birthday, this.gender, this.height, this.weight, this.typeDiabete, this.emailRelative});

  factory InfoUserModel.fromJson(Map<String, dynamic> json) {
    return InfoUserModel(
      id: json['id'].toString(),
      birthday: DateTime.parse(json['birthday'].toString()),
      gender: json['gender'].toString(),
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      typeDiabete: json['typeDiabete'].toString(),
      emailRelative: json['emailRelative'].toString(),
    );
  }
}