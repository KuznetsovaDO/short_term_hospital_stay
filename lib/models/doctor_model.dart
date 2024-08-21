import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String? id;
  final String? access_code;
  final String med_profile;
  final String lastname;
  final String name;
  final String imageUrl;

  DoctorModel({
    this.id,
    this.access_code,
    required this.med_profile,
    required this.lastname,
    required this.name,
    required this.imageUrl,
  });

  // Геттер для свойства id
  String? get getId => id;

  // Геттер для свойства access_code
  //String get getAccessCode => access_code;

  // Геттер для свойства med_profile
  String get getMedProfile => med_profile;

  // Геттер для свойства lastname
  String get getLastname => lastname;

  // Геттер для свойства name
  String get getName => name;
  String get getimageUrl => imageUrl;

  toJson() {
    return {
      "access_code": access_code,
      "med_profile": med_profile,
      "lastname": lastname,
      "name": name,
      "imageUrl": imageUrl,
    };
  }

  factory DoctorModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return DoctorModel(
        id: document.id,
        access_code: data!["access_code"],
        med_profile: data["med_profile"],
        lastname: data['lastname'],
        name: data["name"],
        imageUrl: data["imageUrl"]);
  }
}
