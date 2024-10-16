class SocialModel {
  final int id;
  final String author;
  final List<String> imageUrls;
  final String content;
  final DateTime createdAt;

  SocialModel({
    required this.id,
    required this.author,
    required this.imageUrls,
    required this.content,
    required this.createdAt,
  });
}
