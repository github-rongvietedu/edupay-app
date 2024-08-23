class News {
  late String title;
  late String content;
  late DateTime dateOfPosting;
  late bool ativated;

  News(
      {this.title = "",
      this.content = "",
      DateTime? dateOfPosting,
      this.ativated = false})
      : dateOfPosting = dateOfPosting ?? DateTime.now();

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        title: json['Title'],
        content: json['Content'],
        dateOfPosting: DateTime.parse(json['DateOfPosting']),
        ativated: json['Ativated'] ?? false);
  }
}
