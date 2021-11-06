import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:themotorwash/theme_constants.dart';

class FcmHelper {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio().get(
      url,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }

  onMessageFCM() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('helllo fcm called');

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        BigPictureStyleInformation? bigPictureStyleInformation;
        if (message.notification!.android!.imageUrl != null) {
          final String bigPicturePath = await _downloadAndSaveFile(
              message.notification!.android!.imageUrl!, 'bigPicture');

          bigPictureStyleInformation = BigPictureStyleInformation(
              FilePathAndroidBitmap(bigPicturePath),
              hideExpandedLargeIcon: true,
              contentTitle: message.notification!.title,
              htmlFormatContentTitle: true,
              summaryText: message.notification!.body,
              htmlFormatSummaryText: true);
        }
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();

        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
                'default_channel',
                'AutoAve Foreground Channel',
                'Foreground channel for all the notifications',
                importance: Importance.max,
                priority: Priority.high,
                showWhen: false,
                sound: RawResourceAndroidNotificationSound('turbo'),
                playSound: true,
                icon: 'notification_icon',
                color: SizeConfig.kPrimaryColor,
                styleInformation: bigPictureStyleInformation);
        NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          1,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
        );
      }
    });
  }
}
