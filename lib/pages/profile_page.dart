import 'package:flutter/material.dart';
import 'package:lisait/models/user.dart';
import 'package:lisait/partials/text_display.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              foregroundImage: NetworkImage(widget.user.photo),
            ),
            title: Text(widget.user.nome, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
            subtitle: Text(widget.user.email, style: TextStyle(fontSize: 24)),
          ),
          Row(
            spacing: 20,
            children: [
              TextDisplay(text: "Dart"),
              TextDisplay(text: "Flutter"),
              TextDisplay(text: "Python"),
              TextDisplay(text: "Books"),
              TextDisplay(text: "SQLite"),
            ],
          ),
        ],
      ),
    );
  }
}
