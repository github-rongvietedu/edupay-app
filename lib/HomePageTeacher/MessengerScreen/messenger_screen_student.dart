import 'dart:convert';

import 'package:edupay/HomePageTeacher/MessengerScreen/widget/message_list_item.dart';
import 'package:edupay/constants.dart';
import 'package:edupay/models/classRoom/class_info.dart';
import 'package:edupay/models/convesationMessage/conversation.dart';
import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../config/DataService.dart';
import '../../models/StudentClassRoom/StudentClassInfo.dart';
import 'package:socket_io_client/socket_io_client.dart' as realtime;

import '../../models/convesationMessage/conversationmessage.dart';
import '../../models/convesationMessage/conversationuser.dart';
import '../../models/data_response.dart';
import '../../widget/text_typing.dart';
import 'bloc/message_bloc.dart';

class MessengerScreenStudent extends StatefulWidget {
  final ClassInfo info;
  final String schoolYearID;
  const MessengerScreenStudent(
      {Key? key, required this.info, required this.schoolYearID})
      : super(key: key);

  @override
  State<MessengerScreenStudent> createState() => _MessgenrScreenState();
}

class _MessgenrScreenState extends State<MessengerScreenStudent> {
  var uuid = Uuid();
  TextEditingController _messageControler = TextEditingController();
  late realtime.Socket socket;
  FocusNode focusNode = FocusNode();
  late ClassInfo info;
  String baseSocket = 'http://192.168.1.244:3000';
  String user = Profile.parentID;
  String projectID = 'com.hdg.edupay';
  // String companyCode = 'NTP';
  String conversationID = "";

  List<Conversation> listConvertion = [];
  final MessageBloc _messageBloc = MessageBloc();
  String schoolYearID = "";
  bool autoScroll = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schoolYearID = widget.schoolYearID;
    info = widget.info;

    // socketConnect();
    _messageBloc.scrollController.addListener(_onScroll);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _messageBloc.scrollList());
    focusNode.addListener(() {
      Future.delayed(const Duration(milliseconds: 100))
          .then((value) => _messageBloc.scrollList());
    });
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => _messageBloc.scrollList());
  }

  Future<void> refreshData() async {
    // screenState.value = 'Loading';
    // print(screenState.value);
    // page = 1;
    // listStudent = [];
    DataService dataService = DataService();
    final DataResponse dataResponse = await dataService.getConvertion(
        schoolYearID,
        Profile.parentID, ///////
        Profile.companyCode,
        info.teacherID); ////// Sender = teacher ID vì dựa vô teacher ID để tạo cuộc trò truyện
    List<Conversation> tempList = [];
    if (dataResponse.data != null) {
      for (var info in dataResponse.data) {
        tempList.add(Conversation.fromJson(info));
      }
    }
    listConvertion = tempList;

    if (listConvertion.isNotEmpty) {
      _messageBloc.add(MessageFetched(conversation: listConvertion[0]));
    }
  }

  Future<void> socketConnect() async {
    await refreshData();
    if (listConvertion.isNotEmpty) {
      conversationID = listConvertion[0].iD ?? "";
    }

    socket = realtime.io(
        baseSocket,
        realtime.OptionBuilder()
            .enableAutoConnect()
            .setTransports(['websocket']).build());

    socket.onConnect((data) {
      debugPrint('connected');
      final userLogin = {
        'Sender': Profile.parentID,
        'CompanyCode': Profile.companyCode,
        'id': socket.id,
        'ProjectID': projectID,
        'Conversation': conversationID,
      };
      socket.emit('addUserLogin', jsonEncode(userLogin));
      print(userLogin);
    });

    socket.on('event', (data) {
      debugPrint('eventsss: ${data.toString()}');
    });
    socket.on('message', (data) {
      debugPrint('message: ${data.toString()}');
    });
    socket.onDisconnect((data) {
      debugPrint('disconnect');
    });

    socket.on('receiveMessage', (data) async {
      _messageBloc.add(MessageFetched(conversation: listConvertion[0]));
      _messageBloc.scrollList();
      // debugPrint(
      //     '===============================receiveMessage:: ' + data.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => _messageBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: kPrimaryColor, // <-- SEE HERE
          ),
          backgroundColor: Colors.white,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  // padding: const EdgeInsets.all(5),
                  width: 40,
                  height: 40,
                  //color: Colors.red,
                  // child: Image.network(
                  //   info.faceImageURL ?? "",
                  //   fit: BoxFit.cover,
                  // )
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${info.mainTeacherName}",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
        body: BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
          // if (state.status == MessageStatus.success) {
          return Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                    // flex: 80,
                    // child: Container(
                    //   color: Colors.white,
                    // )
                    child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  controller: _messageBloc.scrollController,
                  itemBuilder: (context, index) {
                    return MessageListItem(
                      imageReceiver: "",
                      message: state.messages[index],
                    );
                  },
                  // separatorBuilder: (context, index) {
                  //   // return _buildSeparated(state.messages, index);
                  // },
                  itemCount: state.messages.length,
                )),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: kPrimaryColor,
                      width: 0.5,
                    )),
                    // height: 50,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 9,
                            child: TextFormField(
                              onTap: () {
                                Future.delayed(
                                        const Duration(milliseconds: 100))
                                    .then((value) => _messageBloc.scrollList());
                              },
                              minLines: 1,
                              maxLines: 4,
                              focusNode: focusNode,
                              controller: _messageControler,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "Nhập tin nhắn"),
                              onChanged: (value) {
                                //_messageBloc.scrollList();
                              },
                            )),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () async {
                                if (_messageControler.text.isEmpty) {
                                  return;
                                }
                                // var message = {
                                //   'conversation': conversationID,
                                //   'sender': user,
                                //   'companyCode': Profile.companyCode,
                                //   'content': _messageControler.text,
                                //   'receiverInfo': jsonEncode(info)
                                //   // 'replyMessage': projectID,
                                // };
                                // print(message);
                                // socket.emit('message', jsonEncode(message));

                                Conversation conversationInfo =
                                    listConvertion[0];
                                ConversationMessage newConversationMessage =
                                    ConversationMessage();

                                newConversationMessage.id =
                                    uuid.v4().toString();
                                // if (widget.conversation != null) {
                                //   newConversationMessage.conversation =
                                //       widget.conversation.id;
                                // }
                                newConversationMessage.conversation =
                                    conversationID;
                                newConversationMessage.conversationInfo =
                                    conversationInfo;
                                newConversationMessage.content =
                                    _messageControler.text;
                                // newConversationMessage.receiver!.studentCode =
                                // info.teacherID;

                                newConversationMessage.sender =
                                    Profile.parentID;
                                _messageControler.text = "";

                                final DataResponse response =
                                    await DataService()
                                        .newMessage(newConversationMessage);

                                if (response.status == 2) {
                                  print('Gui tin nhan thanh cong');
                                  ConversationMessage newConversationMessage =
                                      ConversationMessage();
                                  _messageBloc.add(MessageFetched(
                                      conversation: listConvertion[0]));
                                  newConversationMessage =
                                      ConversationMessage.fromJson(
                                          response.data[0]);
                                  print(newConversationMessage);
                                  if (socket.connected) {
                                    socket.emit(
                                        'message',
                                        jsonEncode(
                                            newConversationMessage.toJson()));
                                  }
                                } else {
                                  print('Gui tin nhan khong thanh cong');
                                }

                                // _messageControler.text = '';

                                // _messageBloc
                                //     .addMessage(newConversationMessage)
                                //     .then((value) {
                                //   if (socket != null) {
                                //     if (socket.connected) {
                                //       socket.emit(
                                //           'message', json.encode(value));
                                //     }
                                //   }

                                //   _messageBloc.add(MessageFetched());
                                // });

                                //     .then((value) async {
                                //   scrollList();
                                //   // scrollList();
                                // });
                              },
                              icon: Icon(Icons.send, color: kPrimaryColor)),
                        )
                      ],
                    )),
              ],
            ),
          );
          // }
          // return CircularProgressIndicator();
        }),
      ),
    );
  }

  @override
  void dispose() {
    //scrollController.dispose();
    _messageBloc.scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    //if (_isBottom) context.read<MessageBloc>().add(MessageFetched());
  }

  bool get _isBottom {
    if (!_messageBloc.scrollController.hasClients) return false;
    final maxScroll = _messageBloc.scrollController.position.maxScrollExtent;
    final currentScroll = _messageBloc.scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
