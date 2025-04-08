import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lisait/pages/posts_page.dart';
import 'package:lisait/partials/custom_input.dart';
import 'package:lisait/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lisait/models/user.dart' as model;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _key = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome!\nPlease login to continue",
                  style: TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                Custominput(label: "e-mail", controller: email),
                Custominput(label: "password", controller: password, isPassword: true),
                IconButton(
                  icon: Text("LOGIN"),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      try {
                        final pref = await SharedPreferences.getInstance();
                        
                        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        String emailS = userCredential.user!.email!;

                        // Crie um username baseado no email
                        String username = emailS.split("@")[0];
                        // Crie o objeto usuário
                        model.User user = model.User(
                          nome: username,
                          email: emailS,
                          // Carregue uma imagem de perfil mock
                          photo: "https://ui-avatars.com/api/?name=${username.split('').getRange(0, 2).join().toUpperCase()}&format=png",
                        );
                        // Carregue o user no sharedPreferences
                        pref.saveUser(user);

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostsPage(
                            user: user,
                          ),
                        ));
                      } on FirebaseAuthException {
                        // Mensagem de erro
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid username or password")),
                        );
                        // print('Erro no login: ${e.message}');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
