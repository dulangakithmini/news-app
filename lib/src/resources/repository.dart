import 'news_api_provider.dart';
import 'news_db_provider.dart';

/// Govern access to either the NewsApiProvider or NewsDbProvider
class Repository {
  /// Create instances of NewsApiProvider and NewsDbProvider
  NewsApiProvider apiProvider = NewsApiProvider();
  NewsDbProvider dbProvider = NewsDbProvider();

  fetchTopIds() {
    /// Fetch top ids from the NewsApiProvider.
    /// We don't have access to top ids in NewsDbProvider
    return apiProvider.fetchTopIds();
  }

  fetchItem(int id) {
    /// Fetch item by the given id
    var item = dbProvider.fetchItem(id);

    /// If an item is in the DB with the given id, return the item
    if (item != null) {
      return item;
    }
  }
}
