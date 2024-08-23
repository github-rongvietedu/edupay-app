import 'package:intl/intl.dart';

// message  {
//    Conversation :{
//      conversationUser :
//    }
// }

class ConversationUser {
  String? id;
  String? conversation;
  String? user;
  // AppUser userInfo;
  DateTime? createdOn;
  String? firebaseToken;

  ConversationUser(
      {this.id, this.conversation, this.createdOn, this.firebaseToken});

  factory ConversationUser.fromJson(Map<String, dynamic> json) {
    ConversationUser message = ConversationUser();

    message.id = json['ID'];
    message.conversation = json['Conversation'];
    message.user = json['User'];
    // try {
    //   message.userInfo = AppUser.fromJson(json['SOC_User']);
    // } catch (ex) {}
    message.firebaseToken = json['FirebaseToken'] ?? "";
    message.createdOn =
        json['CreatedOn'] == null ? null : DateTime.parse(json['CreatedOn']);

    return message;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['Conversation'] = this.conversation;
    data['User'] = this.user;
    // data['SOC_User'] = this.userInfo;
    data['FirebaseToken'] = this.firebaseToken;
    data['CreatedOn'] = createdOn != null
        ? DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(createdOn!).toString()
        : null;

    return data;
  }
}
