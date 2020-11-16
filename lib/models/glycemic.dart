
class GlycemicModel{
  final String id;
  final String indexG;
  final String tags;
  final String note;
  final DateTime measureTime;
  final String userID;

  GlycemicModel({this.id, this.indexG, this.tags, this.note,this.measureTime,this.userID});

  factory GlycemicModel.fromJson(Map<String, dynamic> json) {
    return GlycemicModel(
      id: json['id'],
      indexG: json['indexG'].toString(),
      tags: json['tags'].toString(),
      note: json['note'].toString(),
      measureTime: DateTime.parse(json['measureTime'].toString()),
      userID: json['userID'].toString(),
    );
  }
}