import 'package:flutter/cupertino.dart';

class Notification_ with ChangeNotifier {
  late String id;
  final String noti_message;
  DateTime noti_date;

  Notification_({required this.noti_message, required this.noti_date});
}

class ShowNotification with ChangeNotifier {
  List<Notification_> student_notification = [];
  List<Notification_> driver_notification = [];
  List<Notification_> both_notification = [];

  List<Notification_> get studentNotificationList {
    return [...student_notification];
  }

  List<Notification_> get driverNotificationList {
    return [...driver_notification];
  }

  List<Notification_> get bothNotificationList {
    return [...both_notification];
  }
}

//void removeNotification(String id) {}
