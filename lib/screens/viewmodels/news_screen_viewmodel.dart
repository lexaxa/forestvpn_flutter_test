import 'package:forestvpn_test/repositories/news/mock_news_repository.dart';
import 'package:forestvpn_test/repositories/news/models/models.dart';
import 'package:get/get.dart';

class NewsScreenViewModel extends GetxController {
  final mockNewsRepository = MockNewsRepository();
  final featuredNews = <Article>[].obs;
  final latestNews = <Article>[].obs;

  NewsScreenViewModel() {
    loadNews();
  }

  Future<void> loadNews() async {
    await _loadFeaturedNews();
    await _loadLatestNews();
  }

  Future<void> _loadFeaturedNews() async {
    final result = await mockNewsRepository.getFeaturedArticles();
    if (result.isNotEmpty) {
      featuredNews.value = result;
    }
  }

  Future<void> _loadLatestNews() async {
    final result = await mockNewsRepository.getLatestArticles();
    if (result.isBlank ?? true) {
      latestNews.value = [];
    } else {
      latestNews.value = result;
    }
  }

  void markAllRead() {
    for (var element in latestNews) {
      if (!element.readed) {
        element.readed = true;
      }
    }
    latestNews.refresh();
  }
}
