import 'package:short_term_hospital_stay/models/patient_model.dart';
import 'package:short_term_hospital_stay/ui/pages/auth_page.dart';
import 'package:short_term_hospital_stay/ui/pages/patient_page_2.dart';
import 'package:short_term_hospital_stay/ui/pages/patient_page_1.dart';

const String AuthRoute = "/auth";
//const String BeforeOperationRoute = "/beforeoperation";
const String BeforeOperationRoute = "/beforeoperation";

final routes = {
  AuthRoute: (context) => AuthPage(),
  BeforeOperationRoute: (context) => PatientPage1(),

  // HomeRoute: (context) => PatientBeforeOperationPage(patient: "12345678",),
  // LoginRoute: (context) => PatientAfterOperationPage(patient: "12345678",)
};
