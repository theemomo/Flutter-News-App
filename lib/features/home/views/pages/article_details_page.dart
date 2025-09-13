import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'dart:ui';
import 'package:news_app/features/home/article_cubit/article_cubit.dart';

class ArticleDetailsPage extends StatelessWidget {
  final Article article;
  const ArticleDetailsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final parsedDate = DateTime.parse(article.publishedAt ?? DateTime.now().toIso8601String());
    final formattedDate = DateFormat.yMMMd().format(parsedDate);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 40),
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(CupertinoIcons.back, color: AppColors.white),
              ),
            ),
          ),
        ),
        actions: [
          BlocBuilder<ArticleCubit, ArticleState>(
            buildWhen: (previous, current) =>
                (current is BookmarkAdded && current.article.title == article.title) ||
                (current is BookmarkRemoved && current.article.title == article.title) ||
                current is BookmarkLoading ||
                current is BookmarkError,
            builder: (context, state) {
              // bool isBookmarked = article.isBookmarked;
              if (state is BookmarkLoading) {
                return IconButton(
                  onPressed: () {},
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 40),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.bookmark, color: AppColors.grey),
                      ),
                    ),
                  ),
                );
              } else if (state is BookmarkError) {
                return IconButton(
                  onPressed: () {},
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 40),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(Icons.error, color: AppColors.white),
                      ),
                    ),
                  ),
                );
              } else if (state is BookmarkAdded) {
                return IconButton(
                  onPressed: () async {
                    await BlocProvider.of<ArticleCubit>(context).setBookmark(state.article);
                    debugPrint(article.isBookmarked.toString());
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 40),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(CupertinoIcons.bookmark_fill, color: AppColors.white),
                      ),
                    ),
                  ),
                );
              } else if (state is BookmarkRemoved) {
                return IconButton(
                  onPressed: () async {
                    await BlocProvider.of<ArticleCubit>(context).setBookmark(state.article);
                    debugPrint(article.isBookmarked.toString());
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 40),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(CupertinoIcons.bookmark, color: AppColors.white),
                      ),
                    ),
                  ),
                );
              }
              return IconButton(
                onPressed: () async {
                  await BlocProvider.of<ArticleCubit>(context).setBookmark(article);
                  debugPrint(article.isBookmarked.toString());
                },
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 40),
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                      padding: const EdgeInsets.all(8.0),
                      child: article.isBookmarked
                          ? const Icon(CupertinoIcons.bookmark_fill, color: AppColors.white)
                          : const Icon(CupertinoIcons.bookmark, color: AppColors.white),
                    ),
                  ),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {
              // Navigator.of(context).pop();
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 40),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.share, color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                article.urlToImage ??
                "https://imgs.search.brave.com/4QxmcZ7tq_opuG5R8dwTzb3gYaIKYkDQC2iZRJ4a2Wk/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9kZXZl/bG9wZXJzLmVsZW1l/bnRvci5jb20vZG9j/cy9hc3NldHMvaW1n/L2VsZW1lbnRvci1w/bGFjZWhvbGRlci1p/bWFnZS5wbmc",
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.59,
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.59,
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
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.59,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.59,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black.withValues(alpha: 0.7), Colors.black.withValues(alpha: 0.1)],
              ),
            ),
          ),
          Padding(
            padding: orientation == Orientation.portrait
                ? EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.39)
                : EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: orientation == Orientation.portrait
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                child: Text(
                                  "General",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        article.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MediaQuery.of(context).size.shortestSide > 600
                            ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              )
                            : Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        "${article.author ?? ''} • $formattedDate",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MediaQuery.of(context).size.shortestSide > 600
                            ? Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(color: AppColors.white)
                            : Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20, top: 20),
                      child: SafeArea(
                        top: false,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 20,
                                    backgroundImage: CachedNetworkImageProvider(
                                      "https://imgs.search.brave.com/PmqhpA5wiPdB5Za6zgkS29ZVbtL8Z1jhlenKJQ_HmWQ/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly90aHVt/YnMuZHJlYW1zdGlt/ZS5jb20vYi9wcm9m/aWxlLXBsYWNlaG9s/ZGVyLWltYWdlLWdy/YXktc2lsaG91ZXR0/ZS1uby1waG90by1w/ZXJzb24tYXZhdGFy/LWRlZmF1bHQtcGlj/LXVzZWQtd2ViLWRl/c2lnbi0xMjM0Nzgz/OTcuanBn",
                                    ),
                                    backgroundColor: AppColors.white,
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                  Text(
                                    article.source!.name ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                              Text(
                                "${article.description ?? ""} ${article.description ?? ""} ${article.description ?? ""} ${article.description ?? ""} ${article.content ?? ""}",
                                style: MediaQuery.of(context).size.shortestSide > 600
                                    ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
