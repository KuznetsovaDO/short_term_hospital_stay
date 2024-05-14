import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

class PatientModel {
  final String id; // электронная медицинская карта
  String accessCode; // код доступа
  String medProfile; // медицинский профиль
  String diagnosis; // диагноз
  //final DateTime dateOfRegistration; // дата поступления пациента
  final int age; // возраст
  late String conditionAfterSurgery; // состояние после операции
  late Map<String, String>? eveningForm; // форма "Вечер"
  late Map<String, String>? morningForm; // форма "Утро"
  late List<bool> checklist; // чек-лист до операции
  String status; // статус пациента
  String lastCondition;
  bool survey;
  Timestamp date;

  // геттеры
  String get getId => id;
  String get getProfile => medProfile;

  // сеттеры
  set setAccessCode(String value) {
    accessCode = value;
  }

  set setMedProfile(String value) {
    medProfile = value;
  }

  set setDiagnosis(String value) {
    diagnosis = value;
  }

  set setStatus(String value) {
    status = value;
  }

  set setSurvey(bool value) {
    survey = value;
  }

  // Конструктор класса
  PatientModel(
      {required this.id,
      required this.accessCode,
      required this.medProfile,
      required this.diagnosis,
      // required this.dateOfRegistration,
      required this.age,
      required this.status,
      required this.date,
      this.conditionAfterSurgery = "",
      this.eveningForm,
      this.morningForm,
      this.lastCondition = "1",
      this.survey = false});

  // Метод для сериализации объекта в формат JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "access_code": accessCode,
      "med_profile": medProfile,
      "diagnosis": diagnosis,
      "status": status,
      "age": age,
      "eveningForm": eveningForm,
      "morningForm": morningForm,
      "lastCondition": lastCondition,
      "survey": survey,
      "registration_date": date
    };
  }

  // метод для создания объекта из снимка документа Firestore
  factory PatientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    return PatientModel(
        id: document.id,
        accessCode: data?["access_code"] ?? "",
        medProfile: data?["med_profile"] ?? "",
        diagnosis: data?["diagnosis"] ?? "",
        status: data?['status'] ?? "",
        date: data?['registration_date'],
        //dateOfRegistration: data?['registration_date'].toDate(),
        age: data?['age'] ?? 18,
        survey: data?['survey'] ?? false,
        lastCondition: data?['lastCondition'] ?? "1");
  }

  // Метод для генерации случайного accessCode

  String generateAccessCode(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
