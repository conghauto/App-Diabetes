
import 'package:diabetesapp/components/sign_in_google.dart';
import 'package:diabetesapp/routes.dart';
import 'package:diabetesapp/screens/home/home_screen.dart';
import 'package:diabetesapp/screens/plan/plan_screen.dart';
import 'package:diabetesapp/screens/sign_in/sign_in_screen.dart';
import 'package:diabetesapp/screens/splash/splash_screen.dart';
import 'package:diabetesapp/size_config.dart';
import 'package:diabetesapp/theme.dart';
import 'package:diabetesapp/user_current.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userID = prefs.getString('userID');
  print(userID);


  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.init(appDocumentDirectory.path);
  await Hive.openBox<int>('steps');
  initializeDateFormatting('vi_VN', null)
      .then((_) => runApp(MyApp(userID: userID)));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({
    Key key,
    this.userID,
  }) : super(key: key);
  final String userID;

  @override
  Widget build(BuildContext context) {
    if (userID!=null){
      UserCurrent().init(context);
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Roboto'),
//      initialRoute: SplashScreen.routeName,
      initialRoute: (userID==null)? SplashScreen.routeName:HomeScreen.routeName,
//      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}

//import 'dart:async';
//import 'dart:io';
//import 'dart:typed_data';
//import 'dart:ui';
//
//import 'package:device_info/device_info.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:http/http.dart' as http;
//import 'package:path_provider/path_provider.dart';
//import 'package:rxdart/subjects.dart';
//
//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//FlutterLocalNotificationsPlugin();
//
///// Streams are created so that app can respond to notification-related events
///// since the plugin is initialised in the `main` function
//final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
//BehaviorSubject<ReceivedNotification>();
//
//final BehaviorSubject<String> selectNotificationSubject =
//BehaviorSubject<String>();
//
//const MethodChannel platform =
//MethodChannel('dexterx.dev/flutter_local_notifications_example');
//
//class ReceivedNotification {
//  ReceivedNotification({
//    @required this.id,
//    @required this.title,
//    @required this.body,
//    @required this.payload,
//  });
//
//  final int id;
//  final String title;
//  final String body;
//  final String payload;
//}
//
///// IMPORTANT: running the following code on its own won't work as there is
///// setup required for each platform head project.
/////
///// Please download the complete example app from the GitHub repository where
///// all the setup has been done
//Future<void> main() async {
//  // needed if you intend to initialize in the `main` function
//  WidgetsFlutterBinding.ensureInitialized();
//
//
//  final NotificationAppLaunchDetails notificationAppLaunchDetails =
//  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//
//  const AndroidInitializationSettings initializationSettingsAndroid =
//  AndroidInitializationSettings('alarm');
//
//  /// Note: permissions aren't requested here just to demonstrate that can be
//  /// done later
//  final IOSInitializationSettings initializationSettingsIOS =
//  IOSInitializationSettings(
//      requestAlertPermission: false,
//      requestBadgePermission: false,
//      requestSoundPermission: false,
//      onDidReceiveLocalNotification:
//          (int id, String title, String body, String payload) async {
//        didReceiveLocalNotificationSubject.add(ReceivedNotification(
//            id: id, title: title, body: body, payload: payload));
//      });
//  const MacOSInitializationSettings initializationSettingsMacOS =
//  MacOSInitializationSettings(
//      requestAlertPermission: false,
//      requestBadgePermission: false,
//      requestSoundPermission: false);
//  final InitializationSettings initializationSettings = InitializationSettings(
//      android: initializationSettingsAndroid,
//      iOS: initializationSettingsIOS,
//      macOS: initializationSettingsMacOS);
//  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//      onSelectNotification: (String payload) async {
//        if (payload != null) {
//          debugPrint('notification payload: $payload');
//        }
//        selectNotificationSubject.add(payload);
//      });
//  runApp(
//    MaterialApp(
//      home: HomePage(
//        notificationAppLaunchDetails,
//      ),
//    ),
//  );
//}
//
//
//class PaddedRaisedButton extends StatelessWidget {
//  const PaddedRaisedButton({
//    @required this.buttonText,
//    @required this.onPressed,
//    Key key,
//  }) : super(key: key);
//
//  final String buttonText;
//  final VoidCallback onPressed;
//
//  @override
//  Widget build(BuildContext context) => Padding(
//    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
//    child: RaisedButton(
//      onPressed: onPressed,
//      child: Text(buttonText),
//    ),
//  );
//}
//
//class HomePage extends StatefulWidget {
//  const HomePage(
//      this.notificationAppLaunchDetails, {
//        Key key,
//      }) : super(key: key);
//
//  final NotificationAppLaunchDetails notificationAppLaunchDetails;
//  bool get didNotificationLaunchApp =>
//      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
//
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  @override
//  void initState() {
//    super.initState();
//    _requestPermissions();
//    _configureDidReceiveLocalNotificationSubject();
//    _configureSelectNotificationSubject();
//  }
//
//  void _requestPermissions() {
//    flutterLocalNotificationsPlugin
//        .resolvePlatformSpecificImplementation<
//        IOSFlutterLocalNotificationsPlugin>()
//        ?.requestPermissions(
//      alert: true,
//      badge: true,
//      sound: true,
//    );
//    flutterLocalNotificationsPlugin
//        .resolvePlatformSpecificImplementation<
//        MacOSFlutterLocalNotificationsPlugin>()
//        ?.requestPermissions(
//      alert: true,
//      badge: true,
//      sound: true,
//    );
//  }
//
//  void _configureDidReceiveLocalNotificationSubject() {
//    didReceiveLocalNotificationSubject.stream
//        .listen((ReceivedNotification receivedNotification) async {
//      await showDialog(
//        context: context,
//        builder: (BuildContext context) => CupertinoAlertDialog(
//          title: receivedNotification.title != null
//              ? Text(receivedNotification.title)
//              : null,
//          content: receivedNotification.body != null
//              ? Text(receivedNotification.body)
//              : null,
//          actions: <Widget>[
//            CupertinoDialogAction(
//              isDefaultAction: true,
//              onPressed: () async {
//                Navigator.of(context, rootNavigator: true).pop();
//                await Navigator.push(
//                  context,
//                  MaterialPageRoute<void>(
//                    builder: (BuildContext context) =>
//                        SecondScreen(receivedNotification.payload),
//                  ),
//                );
//              },
//              child: const Text('Ok'),
//            )
//          ],
//        ),
//      );
//    });
//  }
//
//  void _configureSelectNotificationSubject() {
//    selectNotificationSubject.stream.listen((String payload) async {
//      await Navigator.push(
//        context,
//        MaterialPageRoute<void>(
//            builder: (BuildContext context) => SecondScreen(payload)),
//      );
//    });
//  }
//
//  @override
//  void dispose() {
//    didReceiveLocalNotificationSubject.close();
//    selectNotificationSubject.close();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) => MaterialApp(
//    home: Scaffold(
//      appBar: AppBar(
//        title: const Text('Plugin example app'),
//      ),
//      body: SingleChildScrollView(
//        child: Padding(
//          padding: const EdgeInsets.all(8),
//          child: Center(
//            child: Column(
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
//                  child: Text.rich(
//                    TextSpan(
//                      children: <InlineSpan>[
//                        const TextSpan(
//                          text: 'Did notification launch app? ',
//                          style: TextStyle(fontWeight: FontWeight.bold),
//                        ),
//                        TextSpan(
//                          text: '${widget.didNotificationLaunchApp}',
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//                if (widget.didNotificationLaunchApp)
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
//                    child: Text.rich(
//                      TextSpan(
//                        children: <InlineSpan>[
//                          const TextSpan(
//                            text: 'Launch notification payload: ',
//                            style: TextStyle(fontWeight: FontWeight.bold),
//                          ),
//                          TextSpan(
//                            text:
//                            widget.notificationAppLaunchDetails.payload,
//                          )
//                        ],
//                      ),
//                    ),
//                  ),
//                PaddedRaisedButton(
//                  buttonText: 'Show plain notification with payload',
//                  onPressed: () async {
//                    await _showNotification();
//                  },
//                ),
//                PaddedRaisedButton(
//                  buttonText: 'Show notification with custom sound',
//                  onPressed: () async {
//                    await _showNotificationCustomSound();
//                  },
//                ),
//                PaddedRaisedButton(
//                  buttonText:
//                  'Schedule notification to appear in 5 seconds based '
//                      'on local time zone',
//                  onPressed: () async {
//                    await _zonedScheduleNotification();
//                  },
//                ),
//                PaddedRaisedButton(
//                  buttonText:
//                  'Schedule daily 10:00:00 am notification in your '
//                      'local time zone',
//                  onPressed: () async {
//                    await _scheduleDailyTenAMNotification();
//                  },
//                ),
//                PaddedRaisedButton(
//                  buttonText:
//                  'Schedule weekly 10:00:00 am notification in your '
//                      'local time zone',
//                  onPressed: () async {
//                    await _scheduleWeeklyTenAMNotification();
//                  },
//                ),
//                PaddedRaisedButton(
//                  buttonText:
//                  'Schedule weekly Monday 10:00:00 am notification in '
//                      'your local time zone',
//                  onPressed: () async {
//                    await _scheduleWeeklyMondayTenAMNotification();
//                  },
//                ),
//                PaddedRaisedButton(
//                  buttonText: 'Cancel notification',
//                  onPressed: () async {
//                    await _cancelNotification();
//                  },
//                ),
//                PaddedRaisedButton(
//                  buttonText: 'Cancel all notifications',
//                  onPressed: () async {
//                    await _cancelAllNotifications();
//                  },
//                ),
//                if (Platform.isAndroid) ...<Widget>[
//                  const Text(
//                    'Android-specific examples',
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                  PaddedRaisedButton(
//                    buttonText:
//                    'Show plain notification with payload and update '
//                        'channel description',
//                    onPressed: () async {
//                      await _showNotificationUpdateChannelDescription();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText:
//                    'Show plain notification as public on every '
//                        'lockscreen',
//                    onPressed: () async {
//                      await _showPublicNotification();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText:
//                    'Show notification with custom vibration pattern, '
//                        'red LED and red icon',
//                    onPressed: () async {
//                      await _showNotificationCustomVibrationIconLed();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show notification using Android Uri sound',
//                    onPressed: () async {
//                      await _showSoundUriNotification();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText:
//                    'Show notification that times out after 3 seconds',
//                    onPressed: () async {
//                      await _showTimeoutNotification();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show insistent notification',
//                    onPressed: () async {
//                      await _showInsistentNotification();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText:
//                    'Show big picture notification, hide large icon '
//                        'on expand',
//                    onPressed: () async {
//                      await _showBigPictureNotificationHiddenLargeIcon();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show big text notification',
//                    onPressed: () async {
//                      await _showBigTextNotification();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show inbox notification',
//                    onPressed: () async {
//                      await _showInboxNotification();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show grouped notifications',
//                    onPressed: () async {
//                      await _showGroupedNotifications();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show ongoing notification',
//                    onPressed: () async {
//                      await _showOngoingNotification();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show indeterminate progress notification',
//                    onPressed: () async {
//                      await _showIndeterminateProgressNotification();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show notification with custom timestamp',
//                    onPressed: () async {
//                      await _showNotificationWithCustomTimestamp();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Delete notification channel group',
//                    onPressed: () async {
//                      await _deleteNotificationChannelGroup();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Create notification channel',
//                    onPressed: () async {
//                      await _createNotificationChannel();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Delete notification channel',
//                    onPressed: () async {
//                      await _deleteNotificationChannel();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Get active notifications',
//                    onPressed: () async {
//                      await _getActiveNotifications();
//                    },
//                  ),
//                ],
//                if (Platform.isIOS || Platform.isMacOS) ...<Widget>[
//                  const Text(
//                    'iOS and macOS-specific examples',
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show notification with subtitle',
//                    onPressed: () async {
//                      await _showNotificationWithSubtitle();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show notification with icon badge',
//                    onPressed: () async {
//                      await _showNotificationWithIconBadge();
//                    },
//                  ),
//                  PaddedRaisedButton(
//                    buttonText: 'Show notification with attachment',
//                    onPressed: () async {
//                      await _showNotificationWithAttachment();
//                    },
//                  ),
//                ],
//              ],
//            ),
//          ),
//        ),
//      ),
//    ),
//  );
//
//  Future<void> _showNotification() async {
//    const AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.max,
//        priority: Priority.high,
//        ticker: 'ticker');
//    const NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _cancelNotification() async {
//    await flutterLocalNotificationsPlugin.cancel(0);
//  }
//
//  Future<void> _showNotificationCustomSound() async {
//    const AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails(
//      'your other channel id',
//      'your other channel name',
//      'your other channel description',
//      importance: Importance.high,
//      priority: Priority.high,
//      ticker: 'ticker',
//      playSound: true,
//      sound: RawResourceAndroidNotificationSound('tt'),
//    );
//    const IOSNotificationDetails iOSPlatformChannelSpecifics =
//    IOSNotificationDetails(sound: 'xiaomi');
//    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
//    MacOSNotificationDetails(sound: 'xiaomi');
//    const NotificationDetails platformChannelSpecifics = NotificationDetails(
//        android: androidPlatformChannelSpecifics,
//        iOS: iOSPlatformChannelSpecifics,
//        macOS: macOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0,
//        'custom sound notification title',
//        'custom sound notification body',
//        platformChannelSpecifics);
////    await flutterLocalNotificationsPlugin.show(
////        0, 'plain title', 'plain body', platformChannelSpecifics,
////        payload: 'item x');
//  }
//
//  Future<void> _showNotificationCustomVibrationIconLed() async {
//    final Int64List vibrationPattern = Int64List(4);
//    vibrationPattern[0] = 0;
//    vibrationPattern[1] = 1000;
//    vibrationPattern[2] = 5000;
//    vibrationPattern[3] = 2000;
//
//    final AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails('other custom channel id',
//        'other custom channel name', 'other custom channel description',
//        icon: 'secondary_icon',
//        largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
//        vibrationPattern: vibrationPattern,
//        enableLights: true,
//        color: const Color.fromARGB(255, 255, 0, 0),
//        ledColor: const Color.fromARGB(255, 255, 0, 0),
//        ledOnMs: 1000,
//        ledOffMs: 500);
//
//    final NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0,
//        'title of notification with custom vibration pattern, LED and icon',
//        'body of notification with custom vibration pattern, LED and icon',
//        platformChannelSpecifics);
//  }
//
//  Future<void> _zonedScheduleNotification() async {
//    await flutterLocalNotificationsPlugin.zonedSchedule(
//        0,
//        'scheduled title',
//        'scheduled body',
//        DateTime.now().add(const Duration(seconds: 5)),
//        const NotificationDetails(
//            android: AndroidNotificationDetails('your channel id',
//                'your channel name', 'your channel description')),
//        androidAllowWhileIdle: true,
//        uiLocalNotificationDateInterpretation:
//        UILocalNotificationDateInterpretation.absoluteTime);
//  }
//
//
//  Future<void> _showSoundUriNotification() async {
//    /// this calls a method over a platform channel implemented within the
//    /// example app to return the Uri for the default alarm sound and uses
//    /// as the notification sound
//    final String alarmUri = await platform.invokeMethod('getAlarmUri');
//    final UriAndroidNotificationSound uriSound =
//    UriAndroidNotificationSound(alarmUri);
//    final AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails(
//        'uri channel id', 'uri channel name', 'uri channel description',
//        sound: uriSound,
//        styleInformation: const DefaultStyleInformation(true, true));
//    final NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'uri sound title', 'uri sound body', platformChannelSpecifics);
//  }
//
//  Future<void> _showTimeoutNotification() async {
//    const AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails('silent channel id', 'silent channel name',
//        'silent channel description',
//        timeoutAfter: 3000,
//        styleInformation: DefaultStyleInformation(true, true));
//    const NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(0, 'timeout notification',
//        'Times out after 3 seconds', platformChannelSpecifics);
//  }
//
//  Future<void> _showInsistentNotification() async {
//    // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
//    const int insistentFlag = 4;
//    final AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.max,
//        priority: Priority.high,
//        ticker: 'ticker',
//        additionalFlags: Int32List.fromList(<int>[insistentFlag]));
//    final NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'insistent title', 'insistent body', platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<String> _downloadAndSaveFile(String url, String fileName) async {
//    final Directory directory = await getApplicationDocumentsDirectory();
//    final String filePath = '${directory.path}/$fileName';
//    final http.Response response = await http.get(url);
//    final File file = File(filePath);
//    await file.writeAsBytes(response.bodyBytes);
//    return filePath;
//  }
//
//  Future<void> _showBigPictureNotificationHiddenLargeIcon() async {
//    final String largeIconPath = await _downloadAndSaveFile(
//        'http://via.placeholder.com/48x48', 'largeIcon');
//    final String bigPicturePath = await _downloadAndSaveFile(
//        'http://via.placeholder.com/400x800', 'bigPicture');
//    final BigPictureStyleInformation bigPictureStyleInformation =
//    BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
//        hideExpandedLargeIcon: true,
//        contentTitle: 'overridden <b>big</b> content title',
//        htmlFormatContentTitle: true,
//        summaryText: 'summary <i>text</i>',
//        htmlFormatSummaryText: true);
//    final AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails('big text channel id',
//        'big text channel name', 'big text channel description',
//        largeIcon: FilePathAndroidBitmap(largeIconPath),
//        styleInformation: bigPictureStyleInformation);
//    final NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'big text title', 'silent body', platformChannelSpecifics);
//  }
//
//  Future<void> _showBigTextNotification() async {
//    const BigTextStyleInformation bigTextStyleInformation =
//    BigTextStyleInformation(
//      'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
//      htmlFormatBigText: true,
//      contentTitle: 'overridden <b>big</b> content title',
//      htmlFormatContentTitle: true,
//      summaryText: 'summary <i>text</i>',
//      htmlFormatSummaryText: true,
//    );
//    const AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails('big text channel id',
//        'big text channel name', 'big text channel description',
//        styleInformation: bigTextStyleInformation);
//    const NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'big text title', 'silent body', platformChannelSpecifics);
//  }
//
//  Future<void> _showInboxNotification() async {
//    final List<String> lines = <String>['line <b>1</b>', 'line <i>2</i>'];
//    final InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
//        lines,
//        htmlFormatLines: true,
//        contentTitle: 'overridden <b>inbox</b> context title',
//        htmlFormatContentTitle: true,
//        summaryText: 'summary <i>text</i>',
//        htmlFormatSummaryText: true);
//    final AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails('inbox channel id', 'inboxchannel name',
//        'inbox channel description',
//        styleInformation: inboxStyleInformation);
//    final NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'inbox title', 'inbox body', platformChannelSpecifics);
//  }
//
//  Future<void> _showGroupedNotifications() async {
//    const String groupKey = 'com.android.example.WORK_EMAIL';
//    const String groupChannelId = 'grouped channel id';
//    const String groupChannelName = 'grouped channel name';
//    const String groupChannelDescription = 'grouped channel description';
//    // example based on https://developer.android.com/training/notify-user/group.html
//    const AndroidNotificationDetails firstNotificationAndroidSpecifics =
//    AndroidNotificationDetails(
//        groupChannelId, groupChannelName, groupChannelDescription,
//        importance: Importance.max,
//        priority: Priority.high,
//        groupKey: groupKey);
//    const NotificationDetails firstNotificationPlatformSpecifics =
//    NotificationDetails(android: firstNotificationAndroidSpecifics);
//    await flutterLocalNotificationsPlugin.show(1, 'Alex Faarborg',
//        'You will not believe...', firstNotificationPlatformSpecifics);
//    const AndroidNotificationDetails secondNotificationAndroidSpecifics =
//    AndroidNotificationDetails(
//        groupChannelId, groupChannelName, groupChannelDescription,
//        importance: Importance.max,
//        priority: Priority.high,
//        groupKey: groupKey);
//    const NotificationDetails secondNotificationPlatformSpecifics =
//    NotificationDetails(android: secondNotificationAndroidSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        2,
//        'Jeff Chang',
//        'Please join us to celebrate the...',
//        secondNotificationPlatformSpecifics);
//
//    // Create the summary notification to support older devices that pre-date
//    /// Android 7.0 (API level 24).
//    ///
//    /// Recommended to create this regardless as the behaviour may vary as
//    /// mentioned in https://developer.android.com/training/notify-user/group
//    const List<String> lines = <String>[
//      'Alex Faarborg  Check this out',
//      'Jeff Chang    Launch Party'
//    ];
//    const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
//        lines,
//        contentTitle: '2 messages',
//        summaryText: 'janedoe@example.com');
//    const AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails(
//        groupChannelId, groupChannelName, groupChannelDescription,
//        styleInformation: inboxStyleInformation,
//        groupKey: groupKey,
//        setAsGroupSummary: true);
//    const NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        3, 'Attention', 'Two messages', platformChannelSpecifics);
//  }
//
//  Future<void> _cancelAllNotifications() async {
//    await flutterLocalNotificationsPlugin.cancelAll();
//  }
//
//  Future<void> _showOngoingNotification() async {
//    const AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.max,
//        priority: Priority.high,
//        ongoing: true,
//        autoCancel: false);
//    const NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(0, 'ongoing notification title',
//        'ongoing notification body', platformChannelSpecifics);
//  }
//
//  Future<void> _scheduleDailyTenAMNotification() async {
//    await flutterLocalNotificationsPlugin.zonedSchedule(
//        0,
//        'daily scheduled notification title',
//        'daily scheduled notification body',
//        _nextInstanceOfTenAM(),
//        const NotificationDetails(
//          android: AndroidNotificationDetails(
//              'daily notification channel id',
//              'daily notification channel name',
//              'daily notification description'),
//        ),
//        androidAllowWhileIdle: true,
//        uiLocalNotificationDateInterpretation:
//        UILocalNotificationDateInterpretation.absoluteTime,
//        matchDateTimeComponents: DateTimeComponents.time);
//  }
//
//  Future<void> _scheduleWeeklyTenAMNotification() async {
//    await flutterLocalNotificationsPlugin.zonedSchedule(
//        0,
//        'weekly scheduled notification title',
//        'weekly scheduled notification body',
//        _nextInstanceOfTenAM(),
//        const NotificationDetails(
//          android: AndroidNotificationDetails(
//              'weekly notification channel id',
//              'weekly notification channel name',
//              'weekly notificationdescription'),
//        ),
//        androidAllowWhileIdle: true,
//        uiLocalNotificationDateInterpretation:
//        UILocalNotificationDateInterpretation.absoluteTime,
//        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
//  }
//
//  Future<void> _scheduleWeeklyMondayTenAMNotification() async {
//    await flutterLocalNotificationsPlugin.zonedSchedule(
//        0,
//        'weekly scheduled notification title',
//        'weekly scheduled notification body',
//        _nextInstanceOfMondayTenAM(),
//        const NotificationDetails(
//          android: AndroidNotificationDetails(
//              'weekly notification channel id',
//              'weekly notification channel name',
//              'weekly notificationdescription'),
//        ),
//        androidAllowWhileIdle: true,
//        uiLocalNotificationDateInterpretation:
//        UILocalNotificationDateInterpretation.absoluteTime,
//        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
//  }
//
//  DateTime _nextInstanceOfTenAM() {
//    final DateTime now = DateTime.now();
//    DateTime scheduledDate =
//    DateTime(now.year, now.month, now.day, 10);
//    if (scheduledDate.isBefore(now)) {
//      scheduledDate = scheduledDate.add(const Duration(days: 1));
//    }
//    return scheduledDate;
//  }
//
//  DateTime _nextInstanceOfMondayTenAM() {
//    DateTime scheduledDate = _nextInstanceOfTenAM();
//    while (scheduledDate.weekday != DateTime.monday) {
//      scheduledDate = scheduledDate.add(const Duration(days: 1));
//    }
//    return scheduledDate;
//  }
//
//  Future<void> _showIndeterminateProgressNotification() async {
//    const AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails(
//        'indeterminate progress channel',
//        'indeterminate progress channel',
//        'indeterminate progress channel description',
//        channelShowBadge: false,
//        importance: Importance.max,
//        priority: Priority.high,
//        onlyAlertOnce: true,
//        showProgress: true,
//        indeterminate: true);
//    const NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0,
//        'indeterminate progress notification title',
//        'indeterminate progress notification body',
//        platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _showNotificationUpdateChannelDescription() async {
//    const AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails('your channel id', 'your channel name',
//        'your updated channel description',
//        importance: Importance.max,
//        priority: Priority.high,
//        channelAction: AndroidNotificationChannelAction.update);
//    const NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0,
//        'updated notification channel',
//        'check settings to see updated channel description',
//        platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _showPublicNotification() async {
//    const AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.max,
//        priority: Priority.high,
//        ticker: 'ticker',
//        visibility: NotificationVisibility.public);
//    const NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(0, 'public notification title',
//        'public notification body', platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _showNotificationWithSubtitle() async {
//    const IOSNotificationDetails iOSPlatformChannelSpecifics =
//    IOSNotificationDetails(subtitle: 'the subtitle');
//    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
//    MacOSNotificationDetails(subtitle: 'the subtitle');
//    const NotificationDetails platformChannelSpecifics = NotificationDetails(
//        iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0,
//        'title of notification with a subtitle',
//        'body of notification with a subtitle',
//        platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _showNotificationWithIconBadge() async {
//    const IOSNotificationDetails iOSPlatformChannelSpecifics =
//    IOSNotificationDetails(badgeNumber: 1);
//    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
//    MacOSNotificationDetails(badgeNumber: 1);
//    const NotificationDetails platformChannelSpecifics = NotificationDetails(
//        iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'icon badge title', 'icon badge body', platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _showNotificationWithCustomTimestamp() async {
//    final AndroidNotificationDetails androidPlatformChannelSpecifics =
//    AndroidNotificationDetails(
//      'your channel id',
//      'your channel name',
//      'your channel description',
//      importance: Importance.max,
//      priority: Priority.high,
//      when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
//    );
//    final NotificationDetails platformChannelSpecifics =
//    NotificationDetails(android: androidPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
//  }
//
//  Future<void> _showNotificationWithAttachment() async {
//    final String bigPicturePath = await _downloadAndSaveFile(
//        'http://via.placeholder.com/600x200', 'bigPicture.jpg');
//    final IOSNotificationDetails iOSPlatformChannelSpecifics =
//    IOSNotificationDetails(attachments: <IOSNotificationAttachment>[
//      IOSNotificationAttachment(bigPicturePath)
//    ]);
//    final MacOSNotificationDetails macOSPlatformChannelSpecifics =
//    MacOSNotificationDetails(attachments: <MacOSNotificationAttachment>[
//      MacOSNotificationAttachment(bigPicturePath)
//    ]);
//    final NotificationDetails notificationDetails = NotificationDetails(
//        iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
//    await flutterLocalNotificationsPlugin.show(
//        0,
//        'notification with attachment title',
//        'notification with attachment body',
//        notificationDetails);
//  }
//
//
//  Future<void> _deleteNotificationChannelGroup() async {
//    const String channelGroupId = 'your channel group id';
//    await flutterLocalNotificationsPlugin
//        .resolvePlatformSpecificImplementation<
//        AndroidFlutterLocalNotificationsPlugin>()
//        ?.deleteNotificationChannelGroup(channelGroupId);
//
//    await showDialog<void>(
//      context: context,
//      builder: (BuildContext context) => AlertDialog(
//        content: const Text('Channel group with id $channelGroupId deleted'),
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//            child: const Text('OK'),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Future<void> _createNotificationChannel() async {
//    const AndroidNotificationChannel androidNotificationChannel =
//    AndroidNotificationChannel(
//      'your channel id 2',
//      'your channel name 2',
//      'your channel description 2',
//    );
//    await flutterLocalNotificationsPlugin
//        .resolvePlatformSpecificImplementation<
//        AndroidFlutterLocalNotificationsPlugin>()
//        ?.createNotificationChannel(androidNotificationChannel);
//
//    await showDialog<void>(
//        context: context,
//        builder: (BuildContext context) => AlertDialog(
//          content:
//          Text('Channel with name ${androidNotificationChannel.name} '
//              'created'),
//          actions: <Widget>[
//            FlatButton(
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//              child: const Text('OK'),
//            ),
//          ],
//        ));
//  }
//
//  Future<void> _deleteNotificationChannel() async {
//    const String channelId = 'your channel id 2';
//    await flutterLocalNotificationsPlugin
//        .resolvePlatformSpecificImplementation<
//        AndroidFlutterLocalNotificationsPlugin>()
//        ?.deleteNotificationChannel(channelId);
//
//    await showDialog<void>(
//      context: context,
//      builder: (BuildContext context) => AlertDialog(
//        content: const Text('Channel with id $channelId deleted'),
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//            child: const Text('OK'),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Future<void> _getActiveNotifications() async {
//    final Widget activeNotificationsDialogContent =
//    await _getActiveNotificationsDialogContent();
//    await showDialog<void>(
//      context: context,
//      builder: (BuildContext context) => AlertDialog(
//        content: activeNotificationsDialogContent,
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//            child: const Text('OK'),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Future<Widget> _getActiveNotificationsDialogContent() async {
//    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//    if (!(androidInfo.version.sdkInt >= 23)) {
//      return const Text(
//        '"getActiveNotifications" is available only for Android 6.0 or newer',
//      );
//    }
//
//    try {
//      final List<ActiveNotification> activeNotifications =
//      await flutterLocalNotificationsPlugin
//          .resolvePlatformSpecificImplementation<
//          AndroidFlutterLocalNotificationsPlugin>()
//          ?.getActiveNotifications();
//
//      return Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          const Text(
//            'Active Notifications',
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
//          const Divider(color: Colors.black),
//          if (activeNotifications.isEmpty)
//            const Text('No active notifications'),
//          if (activeNotifications.isNotEmpty)
//            for (ActiveNotification activeNotification in activeNotifications)
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(
//                    'id: ${activeNotification.id}\n'
//                        'channelId: ${activeNotification.channelId}\n'
//                        'title: ${activeNotification.title}\n'
//                        'body: ${activeNotification.body}',
//                  ),
//                  const Divider(color: Colors.black),
//                ],
//              ),
//        ],
//      );
//    } on PlatformException catch (error) {
//      return Text(
//        'Error calling "getActiveNotifications"\n'
//            'code: ${error.code}\n'
//            'message: ${error.message}',
//      );
//    }
//  }
//}
//
//class SecondScreen extends StatefulWidget {
//  const SecondScreen(
//      this.payload, {
//        Key key,
//      }) : super(key: key);
//
//  final String payload;
//
//  @override
//  State<StatefulWidget> createState() => SecondScreenState();
//}
//
//class SecondScreenState extends State<SecondScreen> {
//  String _payload;
//  @override
//  void initState() {
//    super.initState();
//    _payload = widget.payload;
//  }
//
//  @override
//  Widget build(BuildContext context) => Scaffold(
//    appBar: AppBar(
//      title: Text('Second Screen with payload: ${_payload ?? ''}'),
//    ),
//    body: Center(
//      child: RaisedButton(
//        onPressed: () {
//          Navigator.pop(context);
//        },
//        child: const Text('Go back!'),
//      ),
//    ),
//  );
//}