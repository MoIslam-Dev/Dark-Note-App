// @dart=2.9
class Notes {
  int id;
  String title;
  String body;
  DateTime creation_date;
  Notes(
      { this.id,
       this.title,
       this.body,
       this.creation_date});
  // we need to create a function to convert items in map
  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "creation_date": creation_date.toString()
    });
  }
}
