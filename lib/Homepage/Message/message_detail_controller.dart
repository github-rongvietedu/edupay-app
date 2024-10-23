import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../core/base/base_controller.dart';

class MessageDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageDetailPageController());
  }
}

class MessageDetailPageController extends BaseController {
  var conversation;
  var inputText=''.obs;
  var listMessage=[];
  var state = 'init';
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
    try {
      conversation= Get.arguments as Map<String, dynamic>?;
    } catch (e) {
      print(e);
    }
    getListMessage();
    super.onInit();
  }
  void _scrollToEnd() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  void _scrollToEndWithAnimation() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
    }
  }
 sendMessage() async
 {
   listMessage.add({'user':0,'message':inputText.value??'','date':DateTime.now(),'type':'text'});
   inputText.value='';
   if (listMessage != null) {
     listMessage.sort((a, b) => a['date'].compareTo(b['date']));
   }
   update();
   await Future.delayed(const Duration(milliseconds: 200));
   _scrollToEnd();
 }

  sendImageUrl(urls) async
  {
    if(urls.isNotEmpty)
    {
        listMessage.add({'user':0,'messag':'','date':DateTime.now(),'type':'image','imageUrls':urls??[]});
    }
    inputText.value='';
    if (listMessage != null) {
      listMessage.sort((a, b) => a['date'].compareTo(b['date']));
    }
    update();
    await Future.delayed(const Duration(milliseconds: 200));    _scrollToEnd();
  }
  getListMessage()async
  {
   listMessage=[
     // {'user':0,
     //   'message':'hi friend',
     //   'date':DateTime.now().toString(),
     //   'type':'text'
     // },
     // {'user':1,
     //   'message':'Hi,I am guset',
     //   'date':DateTime.now().toString(),
     //   'type':'text'
     // },
     // {'user':1,
     //   'date':DateTime.now().toString(),
     //   'type':'image',
     //   'imageUrl': 'https://teddy.vn/wp-content/uploads/2017/08/minion-mat-bong-4.jpg',
     // },
   ];
   state='ready';
   update();
}
  @override
  void dispose() {
    scrollController.dispose(); // Dispose of the controller when done
  }
}
