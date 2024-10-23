import 'package:edupay/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:edupay/constants.dart';
import 'package:intl/intl.dart';

import '../../core/base/base_controller.dart'; // Assuming you have this constants file

class Message_Box extends StatefulWidget {
  @override
  _Message_Box createState() => _Message_Box();
}

class _Message_Box extends State<Message_Box> {
  // Sample message data
  var listMessage = [
    {'name':'Nguyen van A',
      'imageUrl': 'https://teddy.vn/wp-content/uploads/2017/08/minion-mat-bong-4.jpg',
      'header': 'Test Header',
      'detail': 'Test detail abcd1234',
      'date':DateTime.now().toString(),
      'notReadYet':false.toString()
    },
    {'name':'Nguyen van B',
      'imageUrl': 'https://teddy.vn/wp-content/uploads/2017/08/minion-mat-bong-4.jpg',
      'header': 'Another Header',
      'detail': 'More detailed message',
      'date':DateTime.now().toString(),
      'notReadYet':false.toString()
    },
    {'name':'Nguyen van C',
      'imageUrl': 'https://teddy.vn/wp-content/uploads/2017/08/minion-mat-bong-4.jpg',
      'header': 'Another Header',
      'detail': 'More detailed message',
      'date':DateTime.now().toString(),
      'notReadYet':true.toString()
    },
    {'name':'Nguyen van D',
      'imageUrl': 'https://teddy.vn/wp-content/uploads/2017/08/minion-mat-bong-4.jpg',
      'header': 'Another Header',
      'detail': 'More detailed message',
      'date':DateTime.now().toString(),
      'notReadYet':false.toString()
    },
    {'name':'Nguyen van E',
      //'imageUrl': 'https://teddy.vn/wp-content/uploads/2017/08/minion-mat-bong-4.jpg',
      'header': 'Another Header',
      'detail': 'More detailed message',
      'date':DateTime.now().toString(),
      'notReadYet':true.toString()
    },
    {'name':'Nguyen van F',
      'imageUrl': 'https://teddy.vn/wp-content/uploads/2017/08/minion-mat-bong-4.jpg',
      'header': 'Another Header',
      'detail': 'More detailed message fsefsef sdfsdf sdfsdfsd sdf',
      'date':DateTime.now().toString(),
      'notReadYet':true.toString()
    },
  ];
   getDayOfWeek(String date) {
    var dayOf_Week=['CN','T2','T3','T4','T5','T6','T7'];
    try {
      DateTime parsedDate = DateTime.parse(date);
      int dayOfWeek = parsedDate.weekday;
      if (dayOfWeek == DateTime.sunday) {
        return 0;
      } else {
        return dayOf_Week[dayOfWeek];
      }
    }
    catch (e) {}
    return '';
  }
  @override
  Widget build(BuildContext context) {

    onSearchPressed() async {
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        title: GestureDetector(
          onTap: () {
            onSearchPressed();
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: const Icon(
                  Icons.search,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              Text(
                "Tìm kiếm",
                style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body:
      Padding(padding: const EdgeInsets.only(top: 8,bottom: 8),child:
      ListView.builder(
        itemCount: listMessage.length,
        itemBuilder: (context, index) {
          var message = listMessage[index];
          return
            GestureDetector(onTap: ()
              {
                       Get.toNamed(Routes.MESSAGEDETAIL,arguments: message);

              },
            child:
            Container(padding: const EdgeInsets.only(left: 16),
          decoration:  const BoxDecoration(),
          child: Row(
              children: [


                ClipOval(
                  child: SizedBox(
                    width: 44, // Must be equal to height for a perfect circle
                    height: 44,
                    child: Image.network(
                      message['imageUrl'] ?? '', // The image URL
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'images/icon/FaceID.png', // Fallback error image path
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child:
                  SizedBox(
                      child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     // Container(height: 1,color: Colors.red),
                      const SizedBox(height: 12),
                      Text(
                        message['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //const SizedBox(height: 4),
                      Text(
                        message['detail']!,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(height: 1,color: Colors.grey.withOpacity(0.7))
                    ],
                  )),
                ),
                Padding(padding: const EdgeInsets.only(left: 16,right: 16),child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(getDayOfWeek(message['date'].toString())),
                    const SizedBox(height: 4),
                    (message['notReadYet']==null)||!bool.parse(message['notReadYet']!)
                    ?  Container(
                      padding: const EdgeInsets.only(left: 4,right: 4,top: 0,bottom: 0),
                      decoration:  BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child:const Text(
                        'N',
                        style: TextStyle(fontSize: 10,color: Colors.white),
                      ) // Show 'N' if notReadYet is true
                    ): const Text(''), // Else show an empty SizedBox,
                  ],
                ))
              ],
            ),
          ));
        },
      ),
    ));
  }
}
