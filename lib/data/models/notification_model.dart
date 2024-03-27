class NotificationModel {
  final String to;
  final NotificationSet notification;
  final Data data;

  NotificationModel({
    required this.to,
    required this.notification,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      to: json["to"] as String? ?? "",
      notification: NotificationSet.fromJson(json["notification"]),
      data: Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "to": to,
      "notification": notification.toJson(),
      "data": data.toJson(),
    };
  }

}

class NotificationSet {
  final String title;
  final String body;
  final String? sound;
  final String? priority;

  NotificationSet({
    required this.title,
    required this.body,
    this.sound,
    this.priority,
  });

  factory NotificationSet.fromJson(Map<String, dynamic> json) {
    return NotificationSet(
      title: json["title"] as String? ?? "",
      body: json["body"] as String? ?? "",
      sound: json["sound"] as String? ?? "",
      priority: json["priority"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "sound": sound,
      "priority": priority
    };
  }
}

class Data {
  final String newsTitle;
  final String newsText;
  final String newsImage;

  Data({
    required this.newsTitle,
    required this.newsText,
    required this.newsImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      newsTitle: json["news_title"] as String? ?? "",
      newsText: json["news_text"] as String? ?? "",
      newsImage: json["news_image"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "news_title": newsTitle,
      "news_text": newsText,
      "news_image": newsImage,
    };
  }
}