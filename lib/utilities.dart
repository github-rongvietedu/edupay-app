import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:edupay/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final LoadingDialog loadingDialog = LoadingDialog._internal();

int maximumSize = 2000000;

class LoadingDialog {
  LoadingDialog._internal();

  Future<T> showLoadingPopup<T>(
    BuildContext context,
    Future<T> future, {
    String? loadingText,
    Widget? dialogState,
  }) async {
    late BuildContext popupContext = context;
    final dialog = dialogState ??
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: const CircularProgressIndicator(
                  color: kPrimaryColor,
                ))
              ]),
        ); // _buildLoadingDialog(context, loadingText);
    if (Platform.isIOS) {
      showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          popupContext = context;
          return dialog;
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          popupContext = context;
          return dialog;
        },
      );
    }
    try {
      return await future;
    } catch (e) {
      rethrow;
    } finally {
      Navigator.of(popupContext, rootNavigator: true).pop();
    }
  }

  void showToast(String message) {
    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 3,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }

  void showToastLong(String message) {
    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 3,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }

  String getVideoThumbnail(String? link) {
    if (link?.isNotEmpty == true) {
      final regex = RegExp(
          r'^.*(youtu.be\/|v\/|embed\/|watch\?|youtube.com\/user\/[^#]*#([^\/]*?\/)*)\??v?=?([^#\&\?]*).*',
          caseSensitive: false,
          multiLine: false);
      if (regex.hasMatch(link!)) {
        final videoId = regex.firstMatch(link)?.group(3);
        return 'https://img.youtube.com/vi/$videoId/0.jpg';
      }
    }
    return '';
  }
}

showConfirmDialog({
  required BuildContext context,
  required String message,
  required String submitTitle,
  required String cancelTitle,
  required Function onSubmit,
  required Function onCancel,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: const EdgeInsets.all(20),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            height: 400,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                'res/image/ic_question.svg',
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: textInter22.blackColor,
                  ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () => onSubmit(),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(submitTitle,
                                textAlign: TextAlign.center,
                                style:
                                    textInter22.copyWith(color: Colors.white)),
                          ))),
                  const SizedBox(width: 15),
                  Expanded(
                      child: InkWell(
                          onTap: () => onCancel(),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(width: 0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(cancelTitle,
                                textAlign: TextAlign.center,
                                style:
                                    textInter22.copyWith(color: Colors.white)),
                          ))),
                ],
              )
            ]),
          ),
        );
      });
}

showTrySyncFaceDialog({
  required BuildContext context,
  required String message,
  required String submitTitle,
  required String cancelTitle,
  required Function onSubmit,
  required Function onCancel,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: const EdgeInsets.all(20),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            height: 450,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                'res/image/ic_question.svg',
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: textInter22.blackColor,
                  ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () => onSubmit(),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(submitTitle,
                                textAlign: TextAlign.center,
                                style:
                                    textInter22.copyWith(color: Colors.white)),
                          ))),
                  const SizedBox(width: 15),
                  Expanded(
                      child: InkWell(
                          onTap: () => onCancel(),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(width: 0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(cancelTitle,
                                textAlign: TextAlign.center,
                                style:
                                    textInter22.copyWith(color: Colors.white)),
                          ))),
                ],
              )
            ]),
          ),
        );
      });
}

class Logger {
  // Sample of abstract logging function
  static void write(String text, {bool isError = false}) {
    Future.microtask(() => print('** $text. isError: [$isError]'));
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension FileUtils on String {
  String get fileName => substring(lastIndexOf('/') + 1);

  bool get isImageFileFromMime => startsWith('image');
}

closeKeyboard(BuildContext? context) {
  if (context != null) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.requestFocus(FocusNode());
  }
}

//
showConfirmDialogWidget(
    {required context,
    Widget? imageWidget,
    String caption = '',
    String content = '',
    TextStyle? contentStyle,
    TextStyle? captionStyle,
    double height = 350,
    double width = 300,
    Widget? buttonPrint = const SizedBox(),
    Widget? firstButton,
    Widget? secondButton,
    void Function()? onSubmit,
    void Function()? onCancel}) {
  if (context.mounted) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              contentPadding: const EdgeInsets.all(20),
              content: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                height: height,
                width: width,
                child: Column(children: [
                  Expanded(
                      flex: 40,
                      child: imageWidget ??
                          SvgPicture.asset(
                              'res/images/Payment-successfully-backed-up.svg')),
                  Expanded(
                    flex: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          caption,
                          textAlign: TextAlign.center,
                          style: captionStyle ?? textInter16.bold.blackColor,
                        ),
                        SizedBox(height: 10),
                        Text(
                          content,
                          textAlign: TextAlign.center,
                          style: captionStyle ?? textInter16.blackColor,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  buttonPrint ?? SizedBox(),
                  Expanded(
                    flex: 15,
                    child: Row(
                      children: [
                        Visibility(
                            visible: firstButton != null,
                            child: Expanded(
                              child: firstButton ?? SizedBox(),
                            )),
                        // Visibility(
                        //     // visible: (cancelTitle ?? '').isNotEmpty,
                        //     child: const SizedBox(width: 15)),
                        Visibility(
                            visible: secondButton != null,
                            child: Expanded(
                              child: secondButton ?? SizedBox(),
                            )),
                      ],
                    ),
                  )
                ]),
              ),
              // actions: <Widget>[

              // ],
            ),
          );
        });
  }
}

// showResultDialog(context, String message =, String image,
//     {void Function()? onSubmit}) {
//   return showConfirmDialog1(
//         context: context,
//         height: 150,
//         // icon: RiveAnimation.asset("images/icon/DK_Now.riv"),
//         icon: Image.asset(image,

//             // controllers: [_controller],
//             fit: BoxFit.contain),

//         message: message,
//         messageStyle: textInter16.blackColor,
//         submitTitle: 'Quay lại',
//         onSubmit: onSubmit,
//       ) ??
//       false;
// }
// MyGenerator _generator = new MyGenerator(_paperSize, _profile);
Future<Uint8List> createImage(int paperWidth, int lineHeight) async {
  // Tạo một đối tượng PictureRecorder để ghi lại quá trình vẽ.
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(
      recorder,
      Rect.fromPoints(
          Offset(0, 0), Offset(paperWidth.toDouble(), lineHeight.toDouble())));

  // Các tham số padding.
  int paddingLeft = 7;
  int paddingTop = 7;
  double xPos = paddingLeft.toDouble();
  double yPos = paddingTop.toDouble();

  // Clear với màu trắng.
  Paint paint = Paint()..color = Colors.white;
  canvas.drawRect(
      Rect.fromLTWH(0, 0, paperWidth.toDouble(), lineHeight.toDouble()), paint);

  // Vẽ chữ với font Tahoma, kích thước 20, màu đen.
  TextSpan span = TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Tahoma'),
      text: 'xxxxxx');
  TextPainter tp = TextPainter(
      text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
  tp.layout();
  tp.paint(canvas, Offset(xPos, yPos));

  // Kết thúc vẽ và tạo Image.
  final picture = recorder.endRecording();
  final img = await picture.toImage(paperWidth, lineHeight);

  // Chuyển đổi hình ảnh thành ByteData và sau đó là Uint8List
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

List<int> emptyLines(int n) {
  List<int> bytes = [];
  if (n > 0) {
    bytes += List.filled(n, '\n').join().codeUnits;
  }

  //printStocket.add(bytes);
  return bytes;
}

List<int> feed(int n) {
  const esc = '\x1B';
  const cFeedN = '${esc}d'; // Print and feed n lines [N]

  List<int> bytes = [];
  if (n >= 0 && n <= 255) {
    bytes += Uint8List.fromList(
      List.from(cFeedN.codeUnits)..add(n),
    );
  }
  return bytes;
}

buildDialogConfirm(
  BuildContext context, {
  String? caption,
  String? content,
  String? image,
  Function? onPressedFirst,
  Function? onPressedSecond,
  String? textButtonFirst,
  String? textButtonSecond,
}) {
  Size size = MediaQuery.of(context).size;
  showConfirmDialogWidget(
    context: context,
    height: size.height * 0.35,
    caption: caption ?? "",
    content: content ?? "",
    imageWidget: SvgPicture.asset(
      image ?? 'images/svg/icon-warning-2.svg',
      height: 64,
      width: 64,
    ),
    firstButton: InkWell(
      onTap: () {
        onPressedFirst!();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: kPrimaryColor, width: 1.5),
        ),
        child: Center(
          child: Text(textButtonFirst ?? 'Quay lại',
              style: textInter12.blackColor.copyWith(
                fontWeight: FontWeight.w900,
              )),
        ),
      ),
    ),
    secondButton: InkWell(
      onTap: () {
        onPressedSecond!();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Text(textButtonSecond ?? 'Xác nhận',
              style: textInter12.whiteColor.copyWith(
                fontWeight: FontWeight.w900,
              )),
        ),
      ),
    ),
  );
}
