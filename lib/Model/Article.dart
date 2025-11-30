class Article {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? author;

  Article({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      author: json['author'],
    );
  }
  Map<String ,dynamic> tojson(){
    return {
      "title":title,
      "description":description,
      "url":url,
      "urlToImage":urlToImage,
      "publishedAt":publishedAt,
      "author":author,
      
    };
  }
}
