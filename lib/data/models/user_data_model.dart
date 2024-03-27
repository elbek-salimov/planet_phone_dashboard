class UserDataModel {
  final String userId;
  final String username;
  final String email;
  final String imageUrl;
  final String fcmToken;
  final String userDocId;

  UserDataModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.fcmToken,
    required this.userDocId,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json["user_id"] as String? ?? "",
      username: json["username"] as String? ?? "",
      email: json["email"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
      fcmToken: json["fcm_token"] as String? ?? "",
      userDocId: json["user_doc_id"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "username": username,
      "email": email,
      "image_url": imageUrl,
      "fcm_token": fcmToken,
      "user_doc_id": "",
    };
  }
}