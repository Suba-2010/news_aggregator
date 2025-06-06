class Article {
  final String title;
  final String description;
  final String url;
  final String image;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
