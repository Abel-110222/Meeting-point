// ignore_for_file: file_names


class UserModel {
  String? id;
  String? userId;
  String? createdAt;
  String? updatedAt;
  String? role;
  String? username;
  String? avatarUrl;
  String? email;
  String? gender;



  UserModel(
      {
      this.id,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.role,
      this.username,
      this.avatarUrl,
      this.email,
      this.gender
     
      });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? '',
        userId: json["userId"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        role: json["role"] ?? '',
        username: json["username"] ?? '',
        avatarUrl: json["avatarUrl"] ?? '',
        email: json["email"] ?? '',
        gender: json["gender"] ?? '',
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "role": role,
        "username": username,
        "avatarUrl": avatarUrl,
        "email": email,
        "gender": gender

      };
}