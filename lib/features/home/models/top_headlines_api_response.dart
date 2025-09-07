class Source {
  final String? id;
  final String? name;

  Source({this.id, this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }


}

class Article {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source?.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      source: map['source'] != null ? Source.fromMap(map['source'] as Map<String,dynamic>) : null,
      author: map['author'] != null ? map['author'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      urlToImage: map['urlToImage'] != null ? map['urlToImage'] as String : null,
      publishedAt: map['publishedAt'] != null ? map['publishedAt'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
    );
  }
}

class TopHeadlinesApiResponse {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  TopHeadlinesApiResponse({required this.status, required this.totalResults, this.articles});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'totalResults': totalResults,
      'articles': articles?.map((x) => x.toMap()).toList(),
    };
  }

  factory TopHeadlinesApiResponse.fromMap(Map<String, dynamic> map) {
    return TopHeadlinesApiResponse(
      status: map['status'] != null ? map['status'] as String : null,
      totalResults: map['totalResults'] != null ? map['totalResults'] as int : null,
      articles: map['articles'] != null ? List<Article>.from((map['articles'] as List<dynamic>).map<Article?>((x) => Article.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }
}
