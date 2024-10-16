import 'package:edupay/Login/splash_screen.dart';
import 'package:edupay/constants.dart';
import 'package:edupay/utilities.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'ChangePassword/bloc/change_password_bloc.dart';
import 'HomePageTeacher/homepage_tearcher.dart';
import 'Login/SplashScreen/splash_screen.dart';
import 'Login/bloc/login_bloc.dart';
import 'Register/bloc/register_bloc.dart';

// import 'package:package_info_plus/package_info_plus.dart';
import 'Login/login.dart';
import 'bloc_observer.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  // await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   if (message.notification != null) {
  //     print('Notification Title: ${message.data}');
  //     // print('Notification Body: ${message}');
  //   }
  // });
  // Set the background messaging handler early on, as a named top-level function
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission(
      announcement: true, carPlay: true, criticalAlert: true);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  runApp(
    MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('vi', ''), // Vietnamese, no country code
        ],
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double hdPlusDpiThreshold = 2.0; // Example threshold for HD+

    // Get the device pixel ratio
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    // Determine the textScaleFactor based on the DPI
    double textScaleFactor;
    if (devicePixelRatio <= hdPlusDpiThreshold) {
      textScaleFactor = 0.8;
    } else {
      textScaleFactor = 1.0;
    }
    return OverlaySupport.global(
      child: GetMaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi', ''), // Vietnamese, no country code
          ],
          //theme: appThemeData[AppTheme.LIGHT],
          debugShowCheckedModeBanner: false,
          enableLog: true,
          logWriterCallback: Logger.write,
          // initialRoute: AppPages.INITIAL,
          home: const SplashScreen(),
          getPages: AppPages.routes,
          theme: ThemeData(
            fontFamily: GoogleFonts.inter().fontFamily,
            primarySwatch:
                Colors.blue, // Replace with your desired MaterialColor
          ),
          builder: (context, child) {
            return ScreenUtilInit(
              child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(1.0),
                  ),
                  child: child!),
            );
          }),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<LoginBloc>(
//           create: (BuildContext context) => LoginBloc(context),
//         ),
//         BlocProvider<ChangePasswordBloc>(
//           create: (BuildContext context) => ChangePasswordBloc(context),
//         ),
//         BlocProvider<RegisterBloc>(
//           create: (BuildContext context) => RegisterBloc(context),
//         ),
//       ],
//       child: MaterialApp(
//           localizationsDelegates: const [
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//           supportedLocales: const [
//             Locale('vi', ''), // Vietnamese, no country code
//           ],
//           debugShowCheckedModeBanner: false,
//           title: 'Edupay',
//           theme: ThemeData(
//             primarySwatch: Colors.orange,
//           ),
//           home: const SplashScreen()),
//     );
//   }
// }
