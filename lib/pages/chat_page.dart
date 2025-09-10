import 'package:chatapp/models/message.dart';
import 'package:chatapp/widgets/chat_buble.dart';
import 'package:chatapp/widgets/custom_const.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  final _controller = ScrollController();

  CollectionReference messages = FirebaseFirestore.instance.collection(
    KeyMessagecollections,
  );

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kcreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> meassgelist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            meassgelist.add(Message.fromjson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 14, 95, 105),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset(kimage, width: 90), Text('  chat_app')],
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/axel-eres-qPdCFn2sEO4-unsplash.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: meassgelist.length,
                      itemBuilder: (context, index) {
                        return meassgelist[index].id == email
                            ? ChatBuble(message: meassgelist[index])
                            : ChatBubleForfriend(message: meassgelist[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          kmessage: data,
                          kcreatedAt: DateTime.now(),
                          'id': email,
                        });

                        controller.clear();
                        _controller.animateTo(
                          0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },

                      decoration: InputDecoration(
                        hint: Text(
                          'Send Message',
                          style: TextStyle(color: Colors.white),
                        ),
                        suffixIcon: Icon(Icons.send, color: Colors.cyan),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),

                          borderSide: BorderSide(color: KPrimaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: KPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text('loding...');
        }
      },
    );
  }
}
