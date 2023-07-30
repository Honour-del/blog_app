class AdminModel {
  int localId;
  final String id;
  final String username;
  final String bio;
  final String avatarUrl;
  final String? url;
  final List<dynamic> postsCount;
  final dynamic createdAt;

  AdminModel({
    this.localId =0,
    required this.id,
    required this.username,
    required this.bio,
    required this.avatarUrl,
    this.url,
    required this.postsCount,
    required this.createdAt,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'].toString(),
      username: json['authorName'],
      bio: json['bio'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
      postsCount: json['posts_count'],
      createdAt: json['created_at'],
    );
  }

}