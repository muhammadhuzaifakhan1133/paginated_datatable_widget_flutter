class HolidayModel {
  String date;
  String description;

  HolidayModel(this.date, this.description);

  HolidayModel.fromJson(Map<String, dynamic> json):
    date = json["date"].toString(),
    description = json["description"];

  HolidayModel.jsonplaceholderApi(Map<String, dynamic> json):
    date = json["id"].toString(),
    description = json["title"];
  
}