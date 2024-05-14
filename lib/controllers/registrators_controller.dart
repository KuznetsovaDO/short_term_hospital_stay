import 'package:get/get.dart';

import 'package:short_term_hospital_stay/repository/registrators_repository.dart';

class RegistratorsController extends GetxController {
  static RegistratorsController get instance => Get.find();
  final _registratorsRepo = Get.put(RegistratorsRepository());

  Future<bool> checkRegistrator(String accessCode) async {
    return await _registratorsRepo.checkRegistrator(accessCode);
  }

  Future<String> getRegistratorsId(String accessCode) async {
    return await _registratorsRepo.getRegistratorsId(accessCode);
  }
}
