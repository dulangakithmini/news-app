import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  /// Create instances of NewsApiProvider and NewsDbProvider
  NewsApiProvider apiProvider = NewsApiProvider();
  NewsDbProvider dbProvider = NewsDbProvider();
}
