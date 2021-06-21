import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/item_model.dart';

class NewsApiProvider {
  /// Create an instance of the Client class
  /// Can use this to issue get requests over to the API
  Client client = Client();

  /// To get list of top Ids
  fetchTopIds() async {
    final response = await client.get(
        Uri.parse('https://hacker-news.firebaseio.com/v0/topstories.json'));
    final ids = json.decode(response.body);

    return ids;
  }

  /// To get an item
  fetchItem(int id) async {
    final response = await client.get(Uri.parse(
        'https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty'));
    var itemModel = ItemModel.fromJson(json.decode(response.body));

    return itemModel;
  }
}
