import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String name;
  String? profilePicture;
  Timestamp? createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.profilePicture,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'profilePicture': profilePicture,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      profilePicture: map['profilePicture'],
      createdAt: map['createdAt'],
    );
  }
}
