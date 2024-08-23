import 'package:bts_app/models/StudentClassRoom/StudentClassInfo.dart';
import 'package:intl/intl.dart';

import 'conversation.dart';

import 'package:equatable/equatable.dart';

// class ConversationMessage extends Equatable {
//   const ConversationMessage({ this.id,  this.title,  this.body});

//   final int id;
//   final String title;
//   final String body;

//   @override
//   List<Object> get props => [id, title, body];
// }

class ConversationMessage {
  String? id;
  String? conversation;
  String? sender;

  /// id người gửi
  // AppUser ? senderInfo;
  String? content;
  String? replyMessage;
  DateTime? createdOn;
  ConversationMessage? replyMessageInfo;

  Conversation? conversationInfo;
  StudentClassInfo? receiver;
  ConversationMessage(
      {this.id,
      this.conversation,
      this.sender,
      // this.senderInfo
      this.receiver,
      this.content,
      this.replyMessage,
      this.createdOn,
      this.replyMessageInfo,
      this.conversationInfo});

  factory ConversationMessage.fromJson(Map<String, dynamic> json) {
    ConversationMessage message = ConversationMessage();

    message.id = json['ID'];
    message.conversation = json['Conversation'];
    try {
      message.conversationInfo =
          Conversation.fromJson(json['GTS_Conversation']);
    } catch (ex) {}

    message.sender = json['Sender'];
    // try {
    //   message.senderInfo = AppUser.fromJson(json['SOC_User']);
    // } catch (ex) {}

    message.content = json['Content'];
    message.replyMessage = json['ReplyMessage'];
    message.createdOn =
        json['CreatedOn'] == null ? null : DateTime.parse(json['CreatedOn']);
    try {
      message.replyMessageInfo =
          ConversationMessage.fromJson(json['ReplyMessageInfo']);
    } catch (ex) {}

    return message;
  }

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Conversation": conversation,
        "Sender": sender,
        // "SOC_User": senderInfo,
        "Content": content,
        "ReplyMessage": replyMessage,
        "CreatedOn": createdOn != null
            ? DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
                .format(createdOn as DateTime)
                .toString()
            : null,
        // "ReplyMessageInfo": replyMessageInfo,
        'GTS_Conversation': conversationInfo!.toJson()
      };
}
