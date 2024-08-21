import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:short_term_hospital_stay/routes.dart';
import 'package:short_term_hospital_stay/ui/pages/after_discharged_page.dart';
import 'package:short_term_hospital_stay/ui/pages/auth_page.dart';
import 'package:short_term_hospital_stay/ui/pages/patient_page_2.dart';
import 'package:short_term_hospital_stay/ui/pages/patient_page_1.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/shared_preferences_secvice.dart';
import 'ui/pages/patient_page_3.dart';
import 'ui/pages/patient_page_4.dart';

void main() async {
  final PrefService _prefService = PrefService();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _prefService.readCache("userID").then((value) {
    if (value != null) {
      userId = value;
      _prefService.readCache("lastscreen").then((value) {
        if (value != null) {
          lastScreen = value;
        }
      });
    }
  });

  runApp(const MyApp());
}

String? userId;
String? lastScreen;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // initialRoute: userId == ""
        //     ? AuthRoute
        //     : lastScreen == "BeforeOperation"
        //         ? BeforeOperationRoute
        //         : AuthRoute,
        // routes: routes,
        title: 'Стационар кратковременного пребываания',
        theme: ThemeData(
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  shadowColor: Colors.grey.shade600,
                  elevation: 10,
                  textStyle: GoogleFonts.ibmPlexSans(
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  backgroundColor: Color.fromARGB(255, 0, 60, 210),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  minimumSize: const Size.fromHeight(60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
          primaryColor: const Color(0x9C0042EB),
          textTheme: TextTheme(
              titleLarge: GoogleFonts.ibmPlexSans(
                  fontSize: 20,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              headlineLarge: GoogleFonts.ibmPlexSans(
                  fontSize: 30, fontWeight: FontWeight.w700, letterSpacing: 0),
              labelMedium: GoogleFonts.ibmPlexSans(
                  fontSize: 20, letterSpacing: 0, fontWeight: FontWeight.w500),
              bodyMedium: GoogleFonts.ibmPlexSans(
                  fontSize: 18,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800]),
              bodySmall: GoogleFonts.ibmPlexSans(
                  fontSize: 1,
                  letterSpacing: 0,
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600]),
              headlineSmall: GoogleFonts.ibmPlexSans(
                  fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0)),
          useMaterial3: true,
        ),
        home: userId == null
            ? AuthPage()
            : lastScreen == "До операции"
                ? PatientPage1()
                : lastScreen == "После операции"
                    ? PatientPage2()
                    : lastScreen == "Выписан"
                        ? PatientPage3()
                        : lastScreen == "12 часов после операции"
                            ? PatientPage4()
                            : lastScreen == "24 часа после операции"
                                ? AfterDischargedPage()
                                : AuthPage());
  }
}
