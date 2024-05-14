import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistratorsRepository extends GetxController {
  static RegistratorsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  Future<String> getRegistratorsId(String access_code) async {
    final snapshot = await _db
        .collection('registrators')
        .where('access_code', isEqualTo: access_code)
        .get();
    return snapshot.docs.first.id;
  }

  Future<bool> checkRegistrator(String access_code) async {
    try {
      final docSnapshot =
          await _db.collection('registrators').doc("access_code").get();
      // Получаем данные из документа
      final data = docSnapshot.data();
      if (data != null) {
        // Сравниваем полученные данные с access_code
        String code = data['code']; // Получаем значение поля 'access_code'
        if (code == access_code) {
          return true; // Если значения совпадают, возвращаем true
        }
      }
      return false; // Если не найдено совпадений или данные равны null, возвращаем false
    } catch (e) {
      // Если произошла ошибка
      return false;
    }
  }
}
