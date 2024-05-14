import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/patient_model.dart';
import 'evening_and_morning_form_page.dart';
import 'gratitude_page.dart';

class StateChangeForm extends StatelessWidget {
  final PatientModel patient;
  StateChangeForm({required this.patient});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Форма "Утро"'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Изменилось ли ваше состояние?',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
                color: Colors.grey[800],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: OutlinedButton(
                      onPressed: () async {
                        await _updateMorningFormFromEveningForm();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EveningAndMorningFormPage(
                              isMorning: true,
                              patient: patient,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Стало хуже",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                          color: Colors.black,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(2),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          width: 1,
                          color: Colors.grey.shade500,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: OutlinedButton(
                        onPressed: () async {
                          await _updateMorningFormFromEveningForm();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GratitudePage(
                                patient: patient,
                                isMorning: true,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Не изменилось",
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            color: Colors.black,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(2),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(
                            width: 1,
                            color: Colors.grey.shade500,
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: OutlinedButton(
                      onPressed: () async {
                        await _updateMorningFormFromEveningForm();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EveningAndMorningFormPage(
                              isMorning: true,
                              patient: patient,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Стало лучше",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                          color: Colors.black,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(2),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          width: 1,
                          color: Colors.grey.shade500,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateMorningFormFromEveningForm() async {
    try {
      // Получаем документ пациента из Firestore по его ID
      DocumentSnapshot patientDoc =
          await _firestore.collection('patients').doc(patient.id).get();

      // Получаем значение поля "eveningForm"
      dynamic eveningForm = patientDoc['eveningForm'];

      // Создаем или обновляем поле "morningForm" со значением из "eveningForm"
      await _firestore
          .collection('patients')
          .doc(patient.id)
          .update({'morningForm': eveningForm});
    } catch (e) {
      print('Error updating morning form: $e');
    }
  }
}
