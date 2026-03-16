import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String userType;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.userType,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.id,
      fullName: doc['fullName'] ?? '',
      email: doc['email'] ?? '',
      userType: doc['userType'] ?? 'Client',
    );
  }
}
