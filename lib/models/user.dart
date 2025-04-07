import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String nome;
  String email;
  String photo;
  
  User({
    required this.nome,
    required this.email,
    required this.photo,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'email': email,
      'photo': photo,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nome: map['nome'] as String,
      email: map['email'] as String,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
