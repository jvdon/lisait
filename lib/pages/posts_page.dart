import 'package:flutter/material.dart';
import 'package:lisait/models/post.dart';
import 'package:lisait/models/user.dart';
import 'package:lisait/pages/login_page.dart';
import 'package:lisait/pages/post_page.dart';
import 'package:lisait/pages/profile_page.dart';
import 'package:lisait/repos/posts_repo.dart';
import 'package:lisait/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsPage extends StatefulWidget {
  final User user;
  const PostsPage({super.key, required this.user});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  ScrollController _scrollController = ScrollController();
  MenuController _menuController = MenuController();

  // Posts a serem exibidos
  List<Post> shownPosts = [];
  // Todos os posts
  List<Post> posts = [];

  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPosts();
    _scrollController.addListener(
      () {
        // Quando chegar ao fim da pagina, carregue mais posts
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          // print("Loading");
          loadPosts();
        }
      },
    );
  }

  void loadPosts() async {
    // Carrega os posts da API
    posts = await PostsRepo.getPosts();

    setState(() {
      loading = true;
    });
    //~ Espere 5 segundos para simular carregamento
    await Future.delayed(Duration(seconds: 5));
    //~ Gera a quantidade de items a serem carregados (Padrão: 10)

    int nextRangeEnd = (shownPosts.length + 10) > posts.length ? posts.length : shownPosts.length + 10;
    //^ Insere os posts na lista e recarrega a pagina
    setState(() {
      shownPosts.addAll(posts.getRange(shownPosts.length, nextRangeEnd));
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MenuAnchor(
          controller: _menuController,
          child: IconButton(
            color: Pallete.red,
            icon: CircleAvatar(
              foregroundImage: NetworkImage(widget.user.photo),
            ),
            onPressed: () {
              // Abre e fecha o menu
              if (_menuController.isOpen) {
                _menuController.close();
              } else {
                _menuController.open();
              }
            },
          ),
          menuChildren: [
            TextButton(
              child: Text("Profile"),
              onPressed: () {
                // Navigate to profile page
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)));
              },
            ),
            TextButton(
              child: Text("Logout"),
              onPressed: () async {
                //^ Remova o usuário do SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                //! Navegue para tela de login
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                loadPosts();
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            //^ Se a lista de posts está vazia comunique isso ao usuário
            if (posts.isEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off),
                  Text("No posts found"),
                ],
              )
            else
              //^ Exibe os posts em lista vertical
              ListView.builder(
                controller: _scrollController,
                itemCount: shownPosts.length,
                itemBuilder: (context, index) {
                  Post post = shownPosts[index];
                  String content = post.body.split('').getRange(0, 100).join();
                  bool seeAll = false;
                  return StatefulBuilder(
                    builder: (context, setState) => ListTile(
                      leading: CircleAvatar(
                        child: Text(post.postId.toString()),
                        radius: 16,
                      ),
                      contentPadding: EdgeInsets.all(10),
                      title: Text(
                        post.title,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(content, textAlign: TextAlign.justify),
                          // Se o post contem mais de 100 caracteres exiba o testo truncado e um botão de ver mais
                          if (post.body.length > 100 && seeAll == false)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  seeAll = true;
                                  content = post.body;
                                });
                              },
                              icon: Text("Ver mais"),
                            ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostPage(post: post),
                        ));
                      },
                    ),
                  );
                },
              ),
            if (loading)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              )
          ],
        ),
      ),
    );
  }
}
