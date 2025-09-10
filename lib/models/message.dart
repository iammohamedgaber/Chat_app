import 'package:chatapp/widgets/custom_const.dart';

class Message {
  final String message;
  final String ?id;

  Message(this.message, this.id);
  factory Message.fromjson(jsonData) {
    return Message(jsonData[kmessage], jsonData['id']);
  }
}
