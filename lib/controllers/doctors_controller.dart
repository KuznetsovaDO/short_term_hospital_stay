import 'package:get/get.dart';
import 'package:short_term_hospital_stay/models/doctor_model.dart';
import 'package:short_term_hospital_stay/repository/doctors_repository.dart';

class DoctorsController extends GetxController {
  static DoctorsController get instance => Get.find();
  final _doctorsRepo = Get.put(DoctorsRepository());

  getPatientData(String accessCode) {
    return _doctorsRepo.getDoctorsDetails(accessCode);
  }

  Future<List<DoctorModel>> getAllPatient() async {
    return await _doctorsRepo.allDoctors();
  }

  Future<List<DoctorModel>> getProfileDoctors(String profile) async {
    return await _doctorsRepo.allProfileDoctors(profile);
  }

  Future<bool> checkDoctor(String accessCode) async {
    return await _doctorsRepo.checkEmployee(accessCode);
  }

  Future<String> getDoctorsId(String accessCode) async {
    return await _doctorsRepo.getDoctorsId(accessCode);
  }

  Future<List<Map<String, dynamic>>> doctorListData(String profile) async {
    return await _doctorsRepo.doctorListData(profile);
  }
}
