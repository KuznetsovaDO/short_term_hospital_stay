import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:short_term_hospital_stay/models/doctor_model.dart';

class DoctorsRepository extends GetxController {
  static DoctorsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //получает данные конкретного врача по его access_code
  Future<DoctorModel> getDoctorsDetails(String accessCode) async {
    final snapshot = await _db
        .collection('doctors')
        .where('access_code', isEqualTo: accessCode)
        .get();
    final doctorData =
        snapshot.docs.map((e) => DoctorModel.fromSnapshot(e)).single;
    return doctorData;
  }

//получает список всех врачей
  Future<List<DoctorModel>> allDoctors() async {
    final snapshot = await _db.collection('doctors').get();
    final doctorsData =
        snapshot.docs.map((e) => DoctorModel.fromSnapshot(e)).toList();
    return doctorsData;
  }

  //получает список всех врачей определенного профиля
  Future<List<DoctorModel>> allProfileDoctors(String profile) async {
    final snapshot = await _db
        .collection('doctors')
        .where('med_profile', isEqualTo: profile)
        .get();
    final doctorsData =
        snapshot.docs.map((e) => DoctorModel.fromSnapshot(e)).toList();
    return doctorsData;
  }

  Future<String> getDoctorsId(String access_code) async {
    final snapshot = await _db
        .collection('doctors')
        .where('access_code', isEqualTo: access_code)
        .get();
    return snapshot.docs.first.id;
  }

  //проверяет наличие доктора с access_code
  Future<bool> checkEmployee(String access_code) async {
    try {
      final querySnapshot = await _db
          .collection('doctors')
          .where('access_code', isEqualTo: access_code)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> doctorListData(String profile) async {
    List<Map<String, dynamic>> dataList = [];
    try {
      List<DoctorModel> doctors =
          await allProfileDoctors(profile); // Ждем выполнения allDoctors()
      for (var doctor in doctors) {
        Map<String, dynamic> data = {
          'lastname': doctor.lastname,
          'name': doctor.name,
          'imageUrl': doctor.imageUrl,
        };
        dataList.add(data);
      }
      return dataList;
    } catch (e) {
      throw e;
    }
  }
}
