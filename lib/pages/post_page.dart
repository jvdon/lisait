import 'package:flutter/material.dart';
import 'package:lisait/models/post.dart';
import 'package:lisait/models/post_user.dart';
import 'package:lisait/repos/posts_repo.dart';
import 'package:lisait/utils.dart';

class PostPage extends StatefulWidget {
  final Post post;
  const PostPage({super.key, required this.post});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Text(widget.post.title, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.w800)),
            Text(widget.post.body, textAlign: TextAlign.justify),
            // Carrega as informações do autor do post
            FutureBuilder(
              future: PostsRepo.getUserById(widget.post.userId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Loading user"),
                      ],
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Column(
                        children: [
                          Icon(Icons.person_off_outlined),
                          Text("Unable to load user"),
                        ],
                      );
                    } else {
                      PostUser? postUser = snapshot.data;
                      if (postUser == null) {
                        return Column(
                          children: [
                            Icon(Icons.person_off_outlined),
                            Text("Unable to load user"),
                          ],
                        );
                      } else {
                        return InputDecorator(
                          decoration: InputDecoration(
                            border: border,
                            enabledBorder: border,
                            label: Text("User info"),
                          ),
                          child: Container(
                            height: 500,
                            child: Column(
                              spacing: 20,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nome: ${postUser.name}"),
                                Text("Username: ${postUser.username}"),
                                Text("E-Mail: ${postUser.email}"),
                                Text("Phone: ${postUser.phone}"),
                                Text("Website: ${postUser.website}"),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  default:
                    return Column(
                      children: [
                        Icon(Icons.person_off_outlined),
                        Text("Unable to load user"),
                      ],
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
