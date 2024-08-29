import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../models/convesationMessage/conversationmessage.dart';

class MessageListItem extends StatelessWidget {
  MessageListItem(
      {Key? key, required this.message, required this.imageReceiver})
      : super(key: key);
  final String imageReceiver;
  final ConversationMessage message;
  late String sender = Profile.parentID;

  // Future<void> socketConnect(IO.Socket socket) async {
  //   //var deviceID = await getDeviceID();
  //   // Get.log('getToken:' + _chatRepo.getToken());
  //   // Get.log('deviceID:' + deviceID);
  //   // Get.log('BaseAPI.DEV:' + NetworkConfig.baseAPI);
  //   socket = IO.io(
  //       'http://192.168.0.199:3000',
  //       IO.OptionBuilder()
  //           .enableAutoConnect()
  //           .setTransports(['websocket']).build());

  //   socket.onConnect((data) {
  //     debugPrint('connected');
  //     //  Get.log('connect');
  //   });
  //   socket.on('event', (data) {
  //     // debugPrint('eventsss: ${data.toString()}');
  //   });
  //   socket.on('message', (data) {
  //     //logger.i('message: ${data.toString()}');
  //     // debugPrint('message: ${data.toString()}');
  //     // if (data[1] == 'Robin') {
  //     //   debugPrint('message: ${data.toString()}');
  //     // }
  //   });
  //   socket.onDisconnect((data) {
  //     debugPrint('disconnect');
  //   });

  //   // socket.on('friendHasRead', (data) async {
  //   //   log(data);
  //   //   // await getListMessage();
  //   // });
  //   socket.on('receiveMessage', (data) async {
  //     debugPrint('receiveMessage:: ' + data.toString());
  //     // if (data is MessageEntity) {
  //     // //  Get.log(data.toString());
  //     // }
  //     // if (!listChat$.any((element) => element.id == data.id)) {
  //     //  // await getListMessage();
  //     //   //Get.log('receiveMessage:: ' + data.toString());
  //     // }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    bool isSender = message.sender == sender;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: !isSender,
              child: ClipOval(
                child: Container(
                    width: 45,
                    height: 45,
                    color: Colors.red,
                    child: imageReceiver != ""
                        ? Image.network(
                            imageReceiver,
                            fit: BoxFit.cover,
                          )
                        : SizedBox()),
              )),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              padding:
                  EdgeInsets.only(top: 7.5, right: 7.5, left: 7.5, bottom: 7.5),
              decoration: BoxDecoration(
                  color: isSender ? Colors.blue[50] : Colors.green[50],
                  borderRadius: BorderRadius.only(
                    topLeft:
                        isSender ? Radius.circular(10) : Radius.circular(0),
                    topRight:
                        isSender ? Radius.circular(0) : Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSender ? Colors.blue : Colors.green,
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      // spreadRadius: 0.2
                    ),
                  ]),
              child: Stack(children: [
                Container(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: isSender
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Visibility(
                        visible: !isSender,
                        child: Text(
                          "test",
                          // message.senderInfo.fullName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Text(message.content ?? ""),
                    Text(
                        DateFormat("yyyy-MM-dd HH:mm")
                            .format(message.createdOn as DateTime)
                            .toString(),
                        textAlign: TextAlign.end,
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[400])),
                  ],
                )),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
