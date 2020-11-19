
class CarbModel{
  final String id;
  final String carb;
  final String fat;
  final String protein;
  final String calo;
  final String tags;
  final String note;
  final String userID;
  final DateTime measureTime;
  final String idModel;

  CarbModel({this.id, this.carb, this.fat, this.protein,this.calo,this.tags, this.note,
    this.userID,this.measureTime, this.idModel});

  factory CarbModel.fromJson(Map<String, dynamic> json) {
    return CarbModel(
      id: json['id'],
      carb: json['carb'].toString(),
      fat: json['fat'].toString(),
      protein: json['protein'].toString(),
      calo: json['calo'].toString(),
      tags: json['tags'].toString(),
      note: json['note'].toString(),
      userID: json['userID'].toString(),
      measureTime: DateTime.parse(json['measureTime'].toString()),
      idModel: "4",
    );
  }
}