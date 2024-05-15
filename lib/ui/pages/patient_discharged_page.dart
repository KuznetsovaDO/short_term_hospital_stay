import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:short_term_hospital_stay/models/patient_model.dart';
import 'package:short_term_hospital_stay/ui/pages/quality_assessment.dart';

import '../widgets/custom_richtext_widget.dart';
import '../widgets/step_indicator.dart';
import 'evening_and_morning_form_page.dart';
import 'state_change_form.dart';

class PatientDischargedPage extends StatefulWidget {
  final bool isMorning;
  final PatientModel patient;

  PatientDischargedPage({this.isMorning = false, required this.patient});
  @override
  _PatientDischargedPageState createState() => _PatientDischargedPageState();
}

class _PatientDischargedPageState extends State<PatientDischargedPage> {
  final formKey = GlobalKey<FormState>();
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<bool> _isSelected = [false, true];
    return Scaffold(
        appBar: AppBar(
          title: Text('Статус: выписан(-а)'),
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  size: 30,
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        StepIndicator(currentStep: 4),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                            child: OutlinedButton(
                                style:
                                    Theme.of(context).outlinedButtonTheme.style,
                                onPressed: () {
                                  if (widget.isMorning != true) {
                                    changeStatus(widget.patient.id,
                                        "форма вечер", context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EveningAndMorningFormPage(
                                                    patient: widget.patient)));
                                  } else {
                                    changeStatus(widget.patient.id,
                                        "форма утро", context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StateChangeForm(
                                                  patient: widget.patient,
                                                )));
                                  }
                                },
                                child: Text(
                                  widget.isMorning == false
                                      ? 'Пройти форму вечер'
                                      : 'Пройти форму утро',
                                ))),
                        Text(
                          widget.isMorning == false
                              ? 'Пожалуйста, нажмите эту кнопку после 20:00 в день выписки из больницы'
                              : 'Пожалуйста, нажмите эту кнопку после 08:00 на следующий день после выписки из больницы',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QualityAssessmentPage(
                                        patient: widget.patient,
                                      ),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                    elevation: 0,
                                    side: BorderSide(
                                        width: 1.5, color: Colors.black),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black),
                                child: Text(
                                  'Оценить качество обслуживания',
                                  style: GoogleFonts.ibmPlexSans(
                                      fontSize: 17,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500),
                                ))),
                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Пожалуйста, пройдите форму обратной связи, чтобы мы могли улучшить работу нашего стационара! Спасибо!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Рекомендации',
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'В течение 2-3 недель после операции исключить:',
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    " · Физические нагрузки",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " · Тепловые процедуры (баня, сауна)",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " · Употребление алкоголя",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " · Авиаперелеты",
                                    style: GoogleFonts.ibmPlexSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ])),
                      ],
                    )))));
  }

  Future<void> changeStatus(
      String patientId, String status, BuildContext context) async {
    try {
      // Получаем ссылку на документ по patientId
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(patientId);

      // Обновляем поля документа с помощью метода update
      await documentReference.update({'status': status});
    } catch (error) {
      print('Произошла ошибка при обновлении статуса: $error');
    }
  }
}
