import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:short_term_hospital_stay/models/patient_model.dart';

class PatientRepository extends GetxController {
  static PatientRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  Future<PatientModel> getPatientDetails(String accessCode) async {
    final snapshot = await _db
        .collection('patients')
        .where('access_code', isEqualTo: accessCode)
        .get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).single;
    return patientData;
  }

  Future<PatientModel> getPatientDetailsFromId(String patientId) async {
    final snapshot = await _db.collection('patients').doc(patientId).get();
    final patientData = PatientModel.fromSnapshot(snapshot);
    return patientData;
  }

  Future<String> getId(String accessCode) async {
    final snapshot = await _db
        .collection('patients')
        .where('access_code', isEqualTo: accessCode)
        .get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).single;
    return patientData.getId;
  }

  Future<List<PatientModel>> allPatients() async {
    final snapshot = await _db.collection("patients").get();
    final patientData =
        snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return patientData;
  }

  Future<List<PatientModel>> allPatientsFromProfileBeforeDischarged(
      String profile) async {
    if (profile == "Регистрация") {
      final snapshot = await _db.collection("patients_in_hospital").get();
      final patientData =
          snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
      return patientData;
    } else {
      final snapshot = await _db
          .collection("patients_in_hospital")
          .where("med_profile", isEqualTo: profile)
          .get();
      final patientData =
          snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
      return patientData;
    }
  }

  Future<int> getCountBeforeDischargedPatient(String profile) async {
    if (profile == "Регистрация") {
      final snapshot = await _db.collection("patients_in_hospital").get();

      return snapshot.size;
    } else {
      final snapshot = await _db
          .collection("patients_in_hospital")
          .where("med_profile", isEqualTo: profile)
          .get();
      final patientData =
          snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
      return snapshot.size;
    }
  }

  Future<int> getCountAfterDischargedPatient(String profile) async {
    if (profile == "Регистрация") {
      final snapshot = await _db.collection("discharged_patients").get();

      return snapshot.size;
    } else {
      final snapshot = await _db
          .collection("discharged_patients")
          .where("med_profile", isEqualTo: profile)
          .get();
      final patientData =
          snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
      return snapshot.size;
    }
  }

  Future<List<PatientModel>> allPatientsFromProfileAfterDischarged(
      String profile) async {
    if (profile == "Регистрация") {
      final snapshot = await _db.collection("discharged_patients").get();
      final patientData =
          snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
      return patientData;
    } else {
      final snapshot = await _db
          .collection("discharged_patients")
          .where("med_profile", isEqualTo: profile)
          .get();
      final patientData =
          snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
      return patientData;
    }
  }

  Future<bool> checkPatient(String access_code) async {
    try {
      final querySnapshot = await _db
          .collection('patients')
          .where("access_code", isEqualTo: access_code)
          .get();
      if (querySnapshot.size != 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
