
class ActivityModel{
  final String id;
  final String nameActivity;
  final String indexMET;
  final String timeActivity;
  final String tags;
  final String note;
  final DateTime activityTime;
  final String calo;
  final String userID;
  final String idModel;

  ActivityModel({this.id, this.nameActivity, this.indexMET, this.timeActivity,this.tags,this.note,
    this.activityTime,this.calo,this.userID, this.idModel});

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      nameActivity: json['nameActivity'].toString(),
      indexMET: json['indexMET'].toString(),
      timeActivity: json['timeActivity'].toString(),
      tags: json['tags'].toString(),
      note: json['note'].toString(),
      activityTime: DateTime.parse(json['activityTime'].toString()),
      calo: json['calo'].toString(),
      userID: json['userID'].toString(),
      idModel: "5",
    );
  }
}