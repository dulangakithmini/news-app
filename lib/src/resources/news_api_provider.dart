import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/item_model.dart';

class NewsApiProvider {
  /// Create an instance of the Client class
  /// Can use this to issue get requests over to the API
  /// This is created(instead of directly writing a get request) for the purpose of testing
  Client client = Client();

  /// Take the common part of the url out
  final _root = 'https://hacker-news.firebaseio.com/v0';

  /// To get list of top Ids
  Future fetchTopIds() async {
    final response = await client.get(Uri.parse('$_root/topstories.json'));
    final ids = json.decode(response.body);

    return ids;
  }

  /// To get an item
  fetchItem(int id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    var itemModel = ItemModel.fromJson(json.decode(response.body));

    return itemModel;
  }
}
