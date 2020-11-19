
class MedicineModel{
  final String id;
  final String name;
  final String typeInsulin;
  final String amount;
  final String userID;
  final DateTime measureTime;
  final String unit;
  final String note;
  final String idModel;

  MedicineModel({this.id, this.name, this.typeInsulin, this.amount,this.userID,this.measureTime,
    this.unit, this.note, this.idModel});

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'],
      name: json['name'].toString(),
      typeInsulin: json['typeInsulin'].toString(),
      amount: json['amount'].toString(),
      userID: json['userID'].toString(),
      measureTime: DateTime.parse(json['measureTime'].toString()),
      unit: json['unit'].toString(),
      note: json['note'].toString(),
      idModel: "2",
    );
  }
}