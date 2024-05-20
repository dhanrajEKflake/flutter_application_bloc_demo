import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_bloc_demo/home/home.dart';
import 'package:flutter_application_bloc_demo/login/bloc/login_bloc.dart';
import 'package:flutter_application_bloc_demo/login/login_screen.dart';
import 'package:flutter_application_bloc_demo/login/new_login_screen.dart';
import 'package:flutter_application_bloc_demo/services/auth.dart';
import 'package:flutter_application_bloc_demo/services/config/server_config.dart';
import 'package:flutter_application_bloc_demo/services/repo/repos.dart';
import 'package:flutter_application_bloc_demo/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';

Future<String?> getToken(fcm) async {
  String? token = await fcm.getToken();
  debugPrint('Token: $token');
  return token;
}

final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  showLocalNotification(message.notification!.title.toString(),
      message.notification!.body.toString());
}

void showLocalNotification(String title, String body) {
  // const androidNotificationDetail = AndroidNotificationDetails(
  //     '0', // channel Id
  //     'general' // channel Name
  //     );
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const iosNotificatonDetail = DarwinNotificationDetails();

  const notificationDetails = NotificationDetails(
    iOS: iosNotificatonDetail,
    android: androidNotificationDetails,
  );
  _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging fcm = FirebaseMessaging.instance;
  await getToken(fcm);
  initService();
  initRepo();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print(
          'Message also contained a notification: ${message.notification!.title}');
      showLocalNotification(message.notification!.title.toString(),
          message.notification!.body.toString());
    }
  });

  const androidInitializationSetting =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInitializationSetting = DarwinInitializationSettings(
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      showLocalNotification(title!, body!);
    },
  );
  //  DarwinInitializationSettings iosInitializationSetting = DarwinInitializationSettings(
  //   requestAlertPermission: false,
  //   requestBadgePermission: false,
  //   requestSoundPermission: false,
  //   onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {

  //   },
  // );

  var initSettings = InitializationSettings(
      android: androidInitializationSetting, iOS: iosInitializationSetting);
  await _flutterLocalNotificationsPlugin.initialize(initSettings);

  NotificationSettings settings = await fcm.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  fcm.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // _notificationService.initialize();

  apiService.init(baseUrl: ServerConfig.baseUrl);
  Bloc.observer = TalkerBlocObserver();
  runApp(const MyApp());
  // },
  // (error, stack) {
  //   debugPrint("Error: $error");
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [DismissKeyboardNavigationObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: StreamBuilder(
            stream: Auth().authStateChanges,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return LoginPage();
                return const Home();
              } else {
                return const LoginScreen();
              }
            }),
      ),
    );
  }
}

class DismissKeyboardNavigationObserver extends NavigatorObserver {
  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    // TODO: implement didStartUserGesture
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.didStartUserGesture(route, previousRoute);
  }
}
