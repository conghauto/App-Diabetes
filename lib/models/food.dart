
class FoodModel{
  final String id;
  final String name;
  final String amount;
  final String unit;
  final String calo;
  final String protein;
  final String lipid;
  final String carb;
  final String cellulose;
  final String image;

  FoodModel({this.id, this.name, this.amount, this.unit, this.calo,this.protein,this.lipid, this.carb, this.cellulose, this.image});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
        id: json['id'],
        name: json['name'].toString(),
        amount: json['amount'].toString(),
        unit: json['unit'].toString(),
        calo: json['calo'].toString(),
        protein: json['protein'].toString(),
        lipid: json['lipid'].toString(),
        carb: json['carb'].toString(),
        cellulose: json['cellulose'].toString(),
        image: json['image'].toString()
    );
  }
}