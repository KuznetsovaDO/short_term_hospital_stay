import 'package:short_term_hospital_stay/models/patient_model.dart';
import 'package:short_term_hospital_stay/ui/pages/auth_page.dart';
import 'package:short_term_hospital_stay/ui/pages/patient_after_operation_page.dart';
import 'package:short_term_hospital_stay/ui/pages/patient_before_operation_page.dart';

const String AuthRoute = "/auth";
//const String BeforeOperationRoute = "/beforeoperation";
const String LoginRoute = "/login";

final routes = {
  AuthRoute: (context) => AuthPage(),

  // HomeRoute: (context) => PatientBeforeOperationPage(patient: "12345678",),
  // LoginRoute: (context) => PatientAfterOperationPage(patient: "12345678",)
};
