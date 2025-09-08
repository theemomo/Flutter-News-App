import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  const ArticleItemWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.parse(article.publishedAt ?? DateTime.now().toString());
    final formattedDate = DateFormat.yMMMd().format(parsedDate);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.articleRoute, arguments: article);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: CachedNetworkImage(
                imageUrl:
                    article.urlToImage ??
                    "https://imgs.search.brave.com/4QxmcZ7tq_opuG5R8dwTzb3gYaIKYkDQC2iZRJ4a2Wk/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9kZXZl/bG9wZXJzLmVsZW1l/bnRvci5jb20vZG9j/cy9hc3NldHMvaW1n/L2VsZW1lbnRvci1w/bGFjZWhvbGRlci1p/bWFnZS5wbmc",
                width: MediaQuery.of(context).size.width * 0.38,
                height: MediaQuery.of(context).size.height * 0.16,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: MediaQuery.of(context).size.height * 0.16,
                    color: Colors.grey.shade300,
                    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                },
                errorWidget: (context, url, error) => CachedNetworkImage(
                  imageUrl:
                      "https://imgs.search.brave.com/4QxmcZ7tq_opuG5R8dwTzb3gYaIKYkDQC2iZRJ4a2Wk/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9kZXZl/bG9wZXJzLmVsZW1l/bnRvci5jb20vZG9j/cy9hc3NldHMvaW1n/L2VsZW1lbnRvci1w/bGFjZWhvbGRlci1p/bWFnZS5wbmc",
                  width: MediaQuery.of(context).size.width * 0.38,
                  height: MediaQuery.of(context).size.height * 0.16,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.source!.name ?? "no-source",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.gry),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.title ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${article.author ?? "no-author"} • $formattedDate",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.gry),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
