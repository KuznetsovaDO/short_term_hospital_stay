import 'package:get/get.dart';
import 'package:short_term_hospital_stay/models/patient_model.dart';

import 'package:short_term_hospital_stay/repository/patient_repository.dart';

class PatientController extends GetxController {
  static PatientController get instance => Get.find();
  final _patientRepo = Get.put(PatientRepository());

  getPatientData({required String access_code}) {
    return _patientRepo.getPatientDetails(access_code);
  }

  Future<List<PatientModel>> getAllPatient() async {
    return await _patientRepo.allPatients();
  }

  Future<String> getId(String accessCode) async {
    return await _patientRepo.getId(accessCode);
  }

  Future<PatientModel> getPatientDetailsFromId(String patientId) async {
    return await _patientRepo.getPatientDetailsFromId(patientId);
  }

  Future<bool> checkPatient(String docID) async {
    return await _patientRepo.checkPatient(docID);
  }

  Future<List<PatientModel>> getPatientsFromProfileBeforeDischarged(
      String profile) async {
    return _patientRepo.allPatientsFromProfileBeforeDischarged(profile);
  }

  Future<int> getCountAfterDischargedPatient(String profile) async {
    return _patientRepo.getCountAfterDischargedPatient(profile);
  }

  Future<int> getCountBeforeDischargedPatient(String profile) async {
    return _patientRepo.getCountBeforeDischargedPatient(profile);
  }

  Future<List<PatientModel>> getPatientsFromProfileAfterDischarged(
      String profile) async {
    return _patientRepo.allPatientsFromProfileAfterDischarged(profile);
  }
}
