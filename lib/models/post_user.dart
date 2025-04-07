// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostUser {
  int id;
  String name;
  String username;
  String email;
  String website;
  String phone;
  
  PostUser({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.website,
    required this.phone,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'website': website,
      'phone': phone,
    };
  }

  factory PostUser.fromMap(Map<String, dynamic> map) {
    return PostUser(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      website: map['website'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostUser.fromJson(String source) => PostUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
