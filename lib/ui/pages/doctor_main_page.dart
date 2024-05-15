import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:short_term_hospital_stay/ui/pages/auth_page.dart';
import 'package:short_term_hospital_stay/ui/pages/list_patients_page.dart';

import '../../controllers/patient_controller.dart';
import '../../models/patient_model.dart';
import 'patient_page.dart';

class DoctorMainPage extends StatefulWidget {
  final String? doctorId;
  const DoctorMainPage({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<DoctorMainPage> createState() => _DoctorMainPageState();
}

class _DoctorMainPageState extends State<DoctorMainPage> {
  late String medProfile = '';
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  final formKey = GlobalKey<FormState>();

  PatientController controller = PatientController();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    fetchMedProfile();
  }

  Future<void> fetchMedProfile() async {
    try {
      // Получаем документ с заданным doctorId
      final doctorDoc = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(widget.doctorId)
          .get();

      // Извлекаем значение med_profile из документа
      final medProfileValue = doctorDoc.get('med_profile');

      // Устанавливаем значение medProfile в состоянии
      setState(() {
        medProfile = medProfileValue ?? '';
      });
    } catch (e) {
      print('Error fetching med profile: $e');
    }
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          shadowColor: Colors.white,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthPage(),
                    ),
                  );
                },
                child: Text(
                  'Выйти из профиля',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                      color: Colors.grey),
                )),
            Icon(Icons.notifications)
          ])),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Профиль: ${medProfile} ",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Обработка нажатия на карточку

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPatientsPage(
                        isDischargedPatients: false,
                        medProfile: medProfile,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListPatientsPage(
                            isDischargedPatients: false,
                            medProfile: medProfile,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 7),
                      elevation: 10,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text("Пациенты в отделении"),
                            // Text("Количество: "),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Обработка нажатия на карточку

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPatientsPage(
                        isDischargedPatients: true,
                        medProfile: medProfile,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {
                      // Обработка нажатия на карточку

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListPatientsPage(
                            isDischargedPatients: false,
                            medProfile: medProfile,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 7),
                      elevation: 10,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text("Выписанные пациенты"),
                            // Text("Количество: "),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
