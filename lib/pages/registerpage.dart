import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/pages/chat_page.dart';

import 'package:chatapp/widgets/custom_buttom.dart';
import 'package:chatapp/widgets/custom_const.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});
  static String id = "Registerpage";

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  String? email;

  String? password;

  bool islodaing = false;

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
                  const SizedBox(height: 25),
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  CustomformTextfield(
                    onChanged: (data) {
                      email = data;
                    },

                    label: "Email",
                    hint: "Email",
                  ),
                  const SizedBox(height: 15),
                  CustomformTextfield(
                    label: "password",
                    hint: "password",
                    onChanged: (data) {
                      password = data;
                    },
                  ),

                  SizedBox(height: 20),
                  CustomButtom(
                    namebotoom: "Register",

                    onTap: () async {
                      if (formke.currentState!.validate()) {
                        islodaing = true;
                        setState(() {});
                        try {
                          await creatuser();
                          Navigator.pushNamed(
                            context,
                            ChatPage.id,
                            arguments: email,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnacbar(context, 'weak-password');
                          } else if (e.code == 'email-already-in-use') {
                            showSnacbar(context, "email-already-in-use");
                          }
                        } catch (e) {
                          showSnacbar(context, "ther was an error");
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
                        'already have an account ?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          ' Login',
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

  Future<void> creatuser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
