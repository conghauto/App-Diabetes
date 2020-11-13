
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
}