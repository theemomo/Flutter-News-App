import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/features/bookmark/bookmark_cubit/bookmark_cubit.dart';
import 'package:news_app/features/home/home_cubit/home_cubit.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  final bool inBookmark;
  const ArticleItemWidget({super.key, required this.article, this.inBookmark = false});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final parsedDate = DateTime.parse(article.publishedAt ?? DateTime.now().toString());
    final formattedDate = DateFormat.yMMMd().format(parsedDate);
    // debugPrint(MediaQuery.of(context).size.width.toString());
    return InkWell(
      onTap: () {
        if (inBookmark) {
          Navigator.of(context).pushNamed(AppRoutes.articleRoute, arguments: article).then((value) {
            BlocProvider.of<BookmarkCubit>(context).getBookmarked();
          });
        } else {
          Navigator.of(context).pushNamed(AppRoutes.articleRoute, arguments: article).then((value) {
            BlocProvider.of<HomeCubit>(context).getTopHeadlines();
            BlocProvider.of<HomeCubit>(context).getRecommendationNews();
          });
        }
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
                width: MediaQuery.of(context).size.shortestSide > 600
                    ? orientation == Orientation.portrait // Tablet
                          ? MediaQuery.of(context).size.width * 0.38
                          : MediaQuery.of(context).size.width * 0.2
                    : orientation == Orientation.portrait // Smart Phone
                    ? MediaQuery.of(context).size.width * 0.38
                    : MediaQuery.of(context).size.width * 0.3,

                height: MediaQuery.of(context).size.shortestSide > 600
                    ? orientation == Orientation.portrait // Tablet
                          ? MediaQuery.of(context).size.height * 0.16
                          : MediaQuery.of(context).size.height * 0.27
                    : orientation == Orientation.portrait // Smart Phone
                    ? MediaQuery.of(context).size.height * 0.16
                    : MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: MediaQuery.of(context).size.height * 0.16,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) => CachedNetworkImage(
                  imageUrl:
                      "https://imgs.search.brave.com/4QxmcZ7tq_opuG5R8dwTzb3gYaIKYkDQC2iZRJ4a2Wk/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9kZXZl/bG9wZXJzLmVsZW1l/bnRvci5jb20vZG9j/cy9hc3NldHMvaW1n/L2VsZW1lbnRvci1w/bGFjZWhvbGRlci1p/bWFnZS5wbmc",
                  width: MediaQuery.of(context).size.shortestSide > 600
                      ? orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.width * 0.38
                            : MediaQuery.of(context).size.width * 0.3
                      : orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.width * 0.38
                      : MediaQuery.of(context).size.width * 0.3,

                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * 0.16
                      : MediaQuery.of(context).size.height * 0.4,
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
                    style: MediaQuery.of(context).size.shortestSide > 600
                        ? Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.gry)
                        : Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.gry),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.title ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: MediaQuery.of(context).size.shortestSide > 600
                        ? Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ) // Tablet
                        : Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500), // Phone
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${article.author ?? "no-author"} • $formattedDate",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MediaQuery.of(context).size.shortestSide > 600
                        ? Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.gry)
                        : Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.gry),
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
