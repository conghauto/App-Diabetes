
class SportModel{
  final String id;
  final String name;
  final String image;
  final String technique;
  final String benefit;
  final String note;

  SportModel({this.id, this.name, this.image, this.technique, this.benefit, this.note});

  factory SportModel.fromJson(Map<String, dynamic> json) {
    return SportModel(
        id: json['id'],
        name: json['name'].toString(),
        image: json['image'].toString(),
        technique: json['technique'].toString(),
        benefit: json['benefit'].toString(),
        note: json['note'].toString()
    );
  }
}