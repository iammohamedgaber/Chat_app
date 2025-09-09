import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/pages/chat_page.dart';

import 'package:chatapp/pages/registerpage.dart';
import 'package:chatapp/widgets/custom_buttom.dart';
import 'package:chatapp/widgets/custom_const.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool islodaing = false;
  String? email, password;

  GlobalKey<FormState> formke = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: islodaing,

      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back_ground.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formke,
              child: ListView(
                children: [
                  const SizedBox(height: 150),
                  Center(
                    child: Text(
                      'Scholar Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        fontSize: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomformTextfield(
                    label: "Email",
                    hint: "Email",
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomformTextfield(
                    obscureText: true,
                    label: "password",
                    hint: "password",
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButtom(
                    namebotoom: 'Login',

                    onTap: () async {
                      if (formke.currentState!.validate()) {
                        islodaing = true;
                        setState(() {});
                        try {
                          await loginuser();
                          Navigator.pushNamed(
                            context,
                            ChatPage.id,
                            arguments: email,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnacbar(
                              context,
                              'No user found for that email.',
                            );
                          } else if (e.code == 'wrong-password' ||
                              e.code == 'invalid-credential') {
                            showSnacbar(
                              context,
                              'Wrong password provided for that user.',
                            );
                          } else {
                            showSnacbar(context, 'Error: ${e.code}');
                          }
                        }
                        islodaing = false;
                        setState(() {});
                      } else {}
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account ?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Registerpage.id);
                        },
                        child: Text(
                          ' register',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginuser() async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
