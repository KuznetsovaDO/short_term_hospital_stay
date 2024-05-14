import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:short_term_hospital_stay/routes.dart';
import 'package:short_term_hospital_stay/ui/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:short_term_hospital_stay/ui/pages/auth_stuff_page.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:short_term_hospital_stay/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? userId;
  String? status;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: AuthRoute,
        routes: routes,
        title: 'Flutter Demo',
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
                  foregroundColor: Colors.white,
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
                  fontSize: 16,
                  letterSpacing: 0,
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600]),
              headlineSmall: GoogleFonts.ibmPlexSans(
                  fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0)),
          useMaterial3: true,
        ),
        home: AuthPage());
  }
}
