import 'package:flutter/material.dart';

import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/views/widgets/article_item_widget.dart';

class RecommendedNewsWidget extends StatelessWidget {
  final List<Article> articles;
  const RecommendedNewsWidget({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleItemWidget(article: articles[index]);
      },
    );
  }
}
