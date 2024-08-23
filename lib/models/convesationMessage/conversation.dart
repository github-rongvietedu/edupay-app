import 'dart:convert';

import 'conversationmessage.dart';
import 'conversationuser.dart';

class Conversation {
  String? iD;
  String? companyCode;
  String? conversationTitle;
  String? conversationUrlAvatar;
  int? type;
  String? schoolYear;
  String? createdOn;
  String? createdBy;
  // Null? lastesMessage;
  Conversation? lastesMessageInfo;
  List<ConversationMessage>? conversationMessages;
  List<ConversationUser>? users;
  Conversation(
      {this.iD,
      this.companyCode,
      this.conversationTitle,
      this.conversationUrlAvatar,
      this.type,
      this.schoolYear,
      this.createdOn,
      this.createdBy,
      // this.createdByInfo,
      this.conversationMessages,
      this.users});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    Conversation conversation = Conversation();

    conversation.iD = json['ID'];
    conversation.companyCode = json['CompanyCode'];
    conversation.conversationTitle = json['ConversationTitle'] ?? "";
    conversation.conversationUrlAvatar = json['ConversationUrlAvatar'] ?? "";
    conversation.type = json['Type'];
    conversation.schoolYear = json['SchoolYear'] ?? "";
    conversation.createdOn = json['CreatedOn'];
    conversation.createdBy = json['CreatedBy'] ?? "";
    //  conversation.lastesMessage = json['LastesMessage'];
    // try {
    //   conversation.createdByInfo = AppUser.fromJson(json['SOC_User']);
    // } catch (ex) {}

    conversation.conversationMessages = [];
    try {
      for (var u in json['GTS_ConversationMessage']) {
        conversation.conversationMessages!.add(ConversationMessage.fromJson(u));
      }
    } catch (ex) {}

    //conversation.conversationMessages = json['SOC_ConversationMessage'];
    try {
      conversation.users = [];
      for (var conversionUser in json['GTS_ConversationUser']) {
        conversation.users!.add(ConversationUser.fromJson(conversionUser));
      }
    } catch (ex) {}

// try{
//   conversationMessages=[];
// conversationMessages = json['SOC_ConversationMessage'];
// }catch(ex){

// }

    return conversation;
  }

  Map<String, dynamic> toJson() => {
        "ID": iD,
        "ConversationTitle": conversationTitle,
        "ConversationUrlAvatar": conversationUrlAvatar,
        // "LastesMessage": lastesMessage,
        "Type": type,
        "CreatedBy": createdBy,
        "GTS_ConversationUser": users!.map((v) => json.encode(v)).toList()
      };
}
