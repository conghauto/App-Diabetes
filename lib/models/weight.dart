
class WeightModel{
  final String id;
  final String userID;
  final String tags;
  final String note;
  final String weight;
  final DateTime measureTime;
  final String idModel;

  WeightModel({this.id, this.userID, this.tags, this.note,
    this.weight,this.measureTime, this.idModel});

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
      id: json['id'],
      userID: json['userID'].toString(),
      tags: json['tags'].toString(),
      note: json['note'].toString(),
      weight: json['weight'].toString(),
      measureTime: DateTime.parse(json['measureTime'].toString()),
      idModel: "3",
    );
  }
}