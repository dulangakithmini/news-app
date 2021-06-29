import 'package:news/src/models/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

/// Govern access to either the NewsApiProvider or NewsDbProvider
class Repository {
  /// Create a list of sources
  List<Source> sources = <Source>[
    /// NewsDbProvider instance created in NewsDbProvider class
    newsDbProvider,
    NewsApiProvider(),
  ];

  /// Create a list of caches
  List<Cache> caches = <Cache>[
    /// NewsDbProvider instance created in NewsDbProvider class
    newsDbProvider,
  ];

  /// Create instances of NewsApiProvider and NewsDbProvider
  // NewsApiProvider apiProvider = NewsApiProvider();
  // NewsDbProvider dbProvider = NewsDbProvider();

  Future<List<int>> fetchTopIds() {
    /// Fetch top ids from the NewsApiProvider.
    /// Return from the NewsApiProvider since I haven't implemented fetchTopIds function in NewsDbProvider class
    return sources[1].fetchTopIds();

    /// We don't have access to top ids in NewsDbProvider
    // return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);

      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      /// Only add to the db, if the cache is not the same as the source
      // if(cache != source) {
      cache.addItem(item);
      // }
    }

    return item;

    /// Fetch item by the given id
    // var item = await dbProvider.fetchItem(id);

    /// If an item is in the DB with the given id, return the item
    // if (item != null) {
    //   return item;
    // }

    /// Fetch item from the API when the item is not in the DB
    // item = await apiProvider.fetchItem(id);

    /// Add the fetched item to the DB
    // dbProvider.addItem(item);
    // return item;
  }

  /// Call the clear method in NewsDbProvider to clear the DB table records.
  clearCache() async {
    for (var cache in caches) {
      /// use await since we have to wait until all the caches are cleared.
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);

  Future<int> clear();
}
