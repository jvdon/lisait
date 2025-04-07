import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Post {
  int userId;
  int postId;
  String title;
  String body;

  Post({
    required this.userId,
    required this.postId,
    required this.title,
    required this.body,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'postId': postId,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'] as int,
      postId: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
