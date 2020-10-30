
class EventModel{
  final String id;
  final String title;
  final String description;
  final DateTime eventStartDate;
  final DateTime eventEndDate;

  EventModel({this.id, this.title, this.description, this.eventStartDate,this.eventEndDate});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'].toString(),
      description: json['description'].toString(),
      eventStartDate: DateTime.parse(json['eventStartDate'].toString()),
      eventEndDate: DateTime.parse(json['eventEndDate'].toString()),
    );
  }
//  factory EventModel.fromMap(Map data) {
//    return EventModel(
//      title: data['title'],
//      description: data['description'],
//      eventStartDate: data['event_srart_date'],
//      eventEndDate: data['event_end_date'],
//    );
//  }
//
//  factory EventModel.fromDS(Map<String,dynamic> data) {
//    return EventModel(
//      title: data['title'],
//      description: data['description'],
//      eventStartDate: data['event_srart_date'],
//      eventEndDate: data['event_end_date'],
//    );
//  }
//
//  Map<String,dynamic> toMap() {
//    return {
//      "title":title,
//      "description": description,
//      "event_start_date":eventStartDate,
//      "event_end_date":eventEndDate,
//    };
//  }
}