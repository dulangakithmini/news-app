import 'dart:convert';

class ItemModel {
  int id;
  bool deleted;
  String type;
  String by;
  int time;
  String text;
  bool dead;
  int parent;
  List<dynamic> kids;
  String url;
  int score;
  String title;
  int descendants;

  ItemModel(
    this.id,
    this.deleted,
    this.type,
    this.by,
    this.time,
    this.text,
    this.dead,
    this.parent,
    this.kids,
    this.url,
    this.score,
    this.title,
    this.descendants,
  );

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];

    /// When the item is not a story and is a comment, as this value is null, it gives an error in the ternary operators in toMapForDb function.
    /// Threfore, if the value is null, assign false.
    deleted = parsedJson['deleted'] ?? false;

    type = parsedJson['type'];

    /// When the item is deleted, this value is null.
    /// Threfore, if the value is null, assign ''.
    by = parsedJson['by'] ?? '';
    time = parsedJson['time'];

    /// When the item is not a story and is a comment, as this value is null, it gives an error in the ternary operators in toMapForDb function.
    /// Threfore, if the value is null, assign ''.
    text = parsedJson['text'] ?? '';

    /// When the item is not a story and is a comment, as this value is null, it gives an error in the ternary operators in toMapForDb function.
    /// Threfore, if the value is null, assign false.
    dead = parsedJson['dead'] ?? false;
    parent = parsedJson['parent'];

    /// When the item is not a story and is a comment, as this value is null, it gives an error in the ternary operators in toMapForDb function.
    /// Threfore, if the value is null, assign [].
    kids = parsedJson['kids'] ?? [];

    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];

    /// When the item is not a news and is a job advertisement, as this value is null, it shows null in the UI.
    /// Therefore, assign 0 when null
    descendants = parsedJson['descendants'] ?? 0;
  }

  ItemModel.fromDb(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];

    /// Convert the integer value from DB to boolean
    deleted = parsedJson['deleted'] == 1;
    type = parsedJson['type'];
    by = parsedJson['by'];
    time = parsedJson['time'];
    text = parsedJson['text'];

    /// Convert the integer value from DB to boolean
    dead = parsedJson['dead'] == 1;
    parent = parsedJson['parent'];

    /// Convert from json into actual list of integers.
    kids = jsonDecode(parsedJson['kids']);
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    descendants = parsedJson['descendants'];
  }

  ///  Convert ItemModel to a Map when adding data to the DB
  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,

      /// Change boolean to integer
      "deleted": deleted ? 1 : 0,
      "dead": dead ? 1 : 0,

      /// Convert the list of integers to a json
      "kids": jsonEncode(kids),
    };
  }
}
