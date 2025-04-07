import 'package:dio/dio.dart';
import 'package:lisait/models/post.dart';
import 'package:lisait/models/post_user.dart';

final POSTS_URL = "https://jsonplaceholder.typicode.com/posts";

abstract class PostsRepo {
  static Future<List<Post>> getPosts() async {
    final client = Dio();
    Response response = await client.get(POSTS_URL);
    if (response.statusCode != 200) {
      return [];
    }

    try {
      // Transforme a lista de objetos JSON em Posts e retorne a lista
      return (response.data as List).map((e) => Post.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<PostUser?> getUserById(int id) async {
    final client = Dio();
    // Carregue os users
    Response response = await client.get("https://jsonplaceholder.typicode.com/users");
    // Se o statusCode não for 200, retorne nulo
    if (response.statusCode != 200) {
      return null;
    }


    try {
      // Busque nos usuários o que tem id especificado
      Map<String, dynamic> userObj = (response.data as List).where((a) => a["id"] == id).first;
      return PostUser.fromMap(userObj);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
