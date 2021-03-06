import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/item_model.dart';
import 'repository.dart';

class NewsApiProvider implements Source {
  /// Create an instance of the Client class
  /// Can use this to issue get requests over to the API
  /// This is created(instead of directly writing a get request) for the purpose of testing
  Client client = Client();

  /// Take the common part of the url out
  final _root = 'https://hacker-news.firebaseio.com/v0';

  /// To get list of top Ids
  Future<List<int>> fetchTopIds() async {
    final response = await client.get(Uri.parse('$_root/topstories.json'));
    final ids = json.decode(response.body);

    /// Cast ids to specify that it returns a list of int
    return ids.cast<int>();
  }

  /// To get an item
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    var itemModel = ItemModel.fromJson(json.decode(response.body));

    return itemModel;
  }
}
