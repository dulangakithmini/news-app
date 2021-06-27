import 'package:news/src/models/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

/// Govern access to either the NewsApiProvider or NewsDbProvider
class Repository {
  /// Create instances of NewsApiProvider and NewsDbProvider
  NewsApiProvider apiProvider = NewsApiProvider();
  NewsDbProvider dbProvider = NewsDbProvider();

  Future<List<int>> fetchTopIds() {
    /// Fetch top ids from the NewsApiProvider.
    /// We don't have access to top ids in NewsDbProvider
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    /// Fetch item by the given id
    var item = await dbProvider.fetchItem(id);

    /// If an item is in the DB with the given id, return the item
    if (item != null) {
      return item;
    }

    /// Fetch item from the API when the item is not in the DB
    item = await apiProvider.fetchItem(id);

    /// Add the fetched item to the DB
    dbProvider.addItem(item);
    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
