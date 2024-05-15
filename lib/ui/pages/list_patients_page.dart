import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../controllers/patient_controller.dart';
import '../../models/patient_model.dart';
import 'patient_page.dart';

class ListPatientsPage extends StatefulWidget {
  final String medProfile;
  final bool isDischargedPatients;
  const ListPatientsPage(
      {super.key, required this.medProfile, this.isDischargedPatients = false});

  @override
  State<ListPatientsPage> createState() => _ListPatientsPageState();
}

class _ListPatientsPageState extends State<ListPatientsPage> {
  late String medProfile = widget.medProfile;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  final formKey = GlobalKey<FormState>();

  PatientController controller = PatientController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<PatientModel>> patients;
    if (widget.isDischargedPatients) {
      patients =
          controller.getPatientsFromProfileAfterDischarged(widget.medProfile);
    } else {
      patients =
          controller.getPatientsFromProfileBeforeDischarged(widget.medProfile);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: TextButton(
            onPressed: () {},
            child: Text(
              'Выйти из профиля',
              textAlign: TextAlign.center,
              style: GoogleFonts.ibmPlexSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: Colors.grey),
            )),
      ),
      body: FutureBuilder<List<PatientModel>>(
        future: patients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет данных'));
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var patient = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PatientProfile(patientId: patient.id),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 1),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width / 10,
                              height: MediaQuery.of(context).size.width / 10,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 120),
                              child: Image.asset(
                                  'assets/images/smile${patient.lastCondition}.png'),
                              decoration: BoxDecoration(
                                color:
                                    getColorByCondition(patient.lastCondition),
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("#${patient.id}"),
                                Text("Профиль: ${patient.medProfile}",
                                    style: TextStyle(fontSize: 11)),
                                Text("Статус: ${patient.status}",
                                    style: TextStyle(fontSize: 11)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                height: 40,
                                child: OutlinedButton(
                                  style: TextButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: BorderSide(
                                        width: 1.5, color: Colors.black),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    changeStatus(patient.id, context);
                                  },
                                  child: Text("Выписать"),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> changeStatus(String patientId, BuildContext context) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(patientId);
      await documentReference.update({'status': 'Выписан(-а)'});
      setState(() {});
    } catch (error) {
      print('Произошла ошибка при обновлении статуса: $error');
    }
  }

  Color getColorByCondition(String condition) {
    switch (condition) {
      case "1":
        return Colors.green.shade300;
      case "2":
        return Colors.green.shade200;
      case "3":
        return Colors.yellow.shade200;
      case "4":
        return Colors.orange.shade300;
      case "5":
        return Colors.red.shade300;
      default:
        return Colors.white;
    }
  }
}
