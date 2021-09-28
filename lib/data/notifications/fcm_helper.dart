import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

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
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      final String bigPicturePath = await _downloadAndSaveFile(
          message.notification!.android!.imageUrl!, 'bigPicture');
      final BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
              hideExpandedLargeIcon: true,
              contentTitle: 'overridden <b>big</b> content title',
              htmlFormatContentTitle: true,
              summaryText: 'summary <i>text</i>',
              htmlFormatSummaryText: true);
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
              'channel_id_1', 'your channel name', 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false,
              sound: RawResourceAndroidNotificationSound('turbo'),
              playSound: true,
              icon: 'logo',
              styleInformation: bigPictureStyleInformation);
      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(1, message.notification!.title,
          message.notification!.body, platformChannelSpecifics,
          payload: 'item x');
    });
  }
}
