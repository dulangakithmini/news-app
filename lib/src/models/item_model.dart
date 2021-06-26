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
    deleted = parsedJson['deleted'];
    type = parsedJson['type'];
    by = parsedJson['by'];
    time = parsedJson['time'];
    text = parsedJson['text'];
    dead = parsedJson['dead'];
    parent = parsedJson['parent'];
    kids = parsedJson['kids'];
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    descendants = parsedJson['descendants'];
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

    /// Take list of integers as a String and turn it into actual list of integers.
    kids = jsonDecode(parsedJson['kids']);
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    descendants = parsedJson['descendants'];
  }
}
