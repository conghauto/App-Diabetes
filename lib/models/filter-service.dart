class FilterService {
  String allDate;
  String customDate;
  DateTime startDate;
  DateTime endDate;
  int allType;
  int glycemicType;
  int foodType;
  int medicineType;
  int weightType;
  int activityType;

  FilterService(this.allDate, this.customDate, this.startDate, this.endDate,
      this.allType, this.glycemicType, this.foodType, this.medicineType,
      this.weightType, this.activityType);

//  factory FilterService.fromJson(Map<String, dynamic> json) {
//    return FilterService(
//      allDate: json['allDate'] ?? "",
//      customDate: json['customDate'] ?? "",
//      startDate: DateTime.parse(json['eventStartDate'].toString()),
//      startDate: DateTime.parse(json['eventStartDate'].toString()),
//      allType: parsedJson['allType'] ?? "",
//      glycemicType: parsedJson['glycemicType'] ?? "",
//      foodType: parsedJson['foodType'] ?? "",
//      medicineType: parsedJson['medicineType'] ?? "",
//      weightType: parsedJson['weightType'] ?? "",
//      activityType: parsedJson['activityType'] ?? "",
//    );
//  }


//
//  Map<String, dynamic> toJson() {
//    return {
//      "name": this.name,
//      "age": this.age
//    };
//  }

}

//
//class WeightModel{
//  String allDate;
//  String customDate;
//  DateTime startDate;
//  DateTime endDate;
//  int allType;
//  int glycemicType;
//  int foodType;
//  int medicineType;
//  int weightType;
//  int activityType;
//
//  WeightModel({this.allDate, this.customDate, this.startDate, this.endDate,
//    this.allType,this.glycemicType, this.foodType,this.medicineType,this.weightType, this.activityType,});
//
//  factory WeightModel.fromJson(Map<String, dynamic> json) {
//    return WeightModel(
//      id: json['id'],
//      userID: json['userID'],
//      tags: json['tags'],
//      note: json['note'],
//      weight: json['weight'].toString(),
//      measureTime: DateTime.parse(json['measureTime'].toString()),
//      idModel: "3",
//    );
//  }
//}