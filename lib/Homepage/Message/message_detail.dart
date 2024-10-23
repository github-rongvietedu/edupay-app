

import 'dart:io';
import 'dart:math';

import 'package:edupay/Homepage/Message/camera_picker.dart';
import 'package:edupay/Homepage/Message/imagegridview.dart';
import 'package:edupay/Homepage/Message/message_detail_controller.dart';
import 'package:edupay/Homepage/Widget/edupay_appbar.dart';
import 'package:edupay/Homepage/tuition/card_student_info.dart';
import 'package:edupay/config/DataService.dart';
import 'package:edupay/constants.dart';
import 'package:edupay/core/base/base_view_view_model.dart';
import 'package:edupay/leave_application/calendar_shift.dart';
import 'package:edupay/leave_application/create_application_absence_controller.dart';
import 'package:edupay/leave_application/create_application_absence_veiw.dart';
import 'package:edupay/leave_application/leace_application_controller.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/reason.dart';
import 'package:edupay/models/SchoolLeaveOfAbsence/student_leave_of_absence.dart';
import 'package:edupay/models/profile.dart';
import 'package:edupay/models/secure_store.dart';
import 'package:edupay/widget/gradientBitton.dart';
import 'package:edupay/widget/input.dart';
import 'package:edupay/widget/rounded_button.dart';
import 'package:edupay/widget/rve_popup_choose_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/student.dart';

class MessageDetailPage extends BaseView<MessageDetailPageController> {

  refresh() async
  {print('refreshing .................');
    controller.update();
  }
  share() async
  {

  }

  avatar(message)
  {
    return
      Padding(
          padding: const EdgeInsets.only(left: 16,top: 8),
          child: ClipOval(
            child: SizedBox(
              width: 28, // Circle size
              height: 28,
              child: Image.network(
                message['avatarImageUrl'] ?? '', // The image URL
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'images/icon/FaceID.png', // Fallback error image path
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ));
  }
  message_text(message,date)
  {
    return
      Container(
          decoration: BoxDecoration(
            color:((message['user']??'').toString()=='1')?Colors.white:const Color.fromRGBO(213,241,255,1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
          child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    message['message'] ?? '', // Display message
                    style: const TextStyle(fontSize: 14, color: Colors.black)),
                const SizedBox(height: 2),
                Text(
                    date??'', // Display message
                    style:  TextStyle(fontSize: 10, color: Colors.black.withOpacity(0.5)))
              ]));
  }
message_image(imageUrls,context)
{
  return
  Container(
      padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 8),
  child:
  ImageGridView(imageUrls: imageUrls));

  //
  // return Container(
  //   height: MediaQuery.of(context).size.width/2,
  //   padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 8),
  //   margin: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 8),
  //   decoration: BoxDecoration(
  //   borderRadius: BorderRadius.circular(8),
  //   image: DecorationImage(
  //     image: FileImage(File(imageUrl??'')),
  //     fit: BoxFit.cover,
  //   ),
  // ));



  //
  //
  // return
  //   Container(
  //     padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 8),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(12), // This applies to the container background
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(12), // Apply the same border radius to the image
  //       child: Image.network(
  //         imageUrl ?? '', // The image URL
  //         fit: BoxFit.fitWidth,
  //         errorBuilder: (context, error, stackTrace) {
  //           return GestureDetector(
  //             onTap: () {
  //               refresh();
  //             },
  //             child: const Row(
  //               children: [
  //                 SizedBox(width: 16),
  //                 Text('Tải lại ảnh', style: TextStyle(fontSize: 10, color: Colors.grey)),
  //                 SizedBox(width: 4),
  //                 Icon(Icons.error, color: Colors.red, size: 14),
  //               ],
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
}
message_date(date)
{
  return
    Container(padding: const EdgeInsets.only(left: 16),
        child:
        Row(children: [
          Container(
            padding: const EdgeInsets.only(left: 4,right: 4,top: 0,bottom:0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child:Center(child:
            Text(date,
                style: const TextStyle(
                  fontSize: 10,
                  color:Colors.white,
                ))),
          )
        ],)
    );
}
  Widget messageWidget(message,context) {
    var date='';
    try {date=message['date']==null?'':
    DateFormat('HH:mm').format(
        DateTime.parse((message['date'] ??'').toString()));} catch (e) {}
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (message['user']??'').toString()=='0'?const SizedBox():
        Container(
          padding: const EdgeInsets.only(left: 16, top: 8), // Add padding if necessary
          alignment: Alignment.topLeft, // Align avatar to the top left
          child: avatar(message),
        ),
        (message['user']??'').toString()=='0'?
         const SizedBox(width: 50):const SizedBox(),
        Expanded(
          child:
          Column(
            crossAxisAlignment:
            (message['user']??'').toString()=='1'?
            CrossAxisAlignment.start:
            CrossAxisAlignment.end,
            children: [
              (message['type']??'')=='text'?message_text(message,date):message_image(message['imageUrls'],context),
              (message['type']??'')=='text'?const SizedBox():message_date(date)
           ],)
        ),
        (message['user']??'').toString()=='1'?
        const SizedBox(width: 50):const SizedBox(),
      ],
    );
  }
 onSendMessagePressed()async
 {
   controller.sendMessage();
 }
  onImagePressed(BuildContext context) async{
    await onImageButtonPressed(
      controller,
      finishedPickImage,  // Pass the callback function
      ImageSource.gallery, // Source is the gallery
      context: context,
      isMultiImage: true, // Allow multiple images
    );
  }

  void finishedPickImage(dynamic url)async {
   await controller.sendImageUrl(url);
  }
  @override
  Widget baseBuilder(BuildContext context) {
      return GestureDetector(onTap: () {
        FocusScope.of(context)
            .unfocus(); // Dismiss the keyboard when tapping outside
      },child:
      Scaffold(
          resizeToAvoidBottomInset: true, // This makes the Scaffold resize when the keyboard is shown
          appBar:
      AppBar(
      foregroundColor: const Color.fromRGBO(225,233,241,1),
      backgroundColor: kPrimaryColor,
          title:
          GestureDetector(
         onTap: () { },
         child:
         Text(
           controller.conversation != null && controller.conversation!['name'] != null
               ? controller.conversation!['name']
               : '',
           style: const TextStyle(fontSize: 16, color: Colors.white),
         )
          ),
       ),
      body:
      controller.listMessage==null?const SizedBox():
      Container(
          color: Colors.grey.withOpacity(0.4),
          padding:  EdgeInsets.only(top: 8,bottom:MediaQuery.of(context).padding.bottom),child:
      Column(children: [
      Expanded(child:
      ListView.builder(
          controller: controller.scrollController, // Attach the ScrollController
          itemCount: controller.listMessage.length,
        itemBuilder: (context, index) {
          var message = controller.listMessage[index];
          return
            messageWidget(message,context);})),
        SizedBox(//height: 50,
            child:
        InputMessage(
          hintText:
          'Tin nhắn',
          onRightIconPressed:() {onSendMessagePressed();},
          onImagePressed:()async {await onImagePressed(context);},
          valueController: controller.inputText,
        )),
      ]))
    ));
  }
}
