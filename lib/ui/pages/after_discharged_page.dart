import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/patient_model.dart';
import '../widgets/step_indicator.dart';
import 'quality_assessment.dart';

class AfterDischargedPage extends StatefulWidget {
  @override
  _AfterDischargedPageState createState() => _AfterDischargedPageState();

  final bool isMorning;
  AfterDischargedPage({this.isMorning = false});
}

class _AfterDischargedPageState extends State<AfterDischargedPage> {
  final formKey = GlobalKey<FormState>();
  int selectedButtonIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<bool> _isSelected = [false, true];
    return Scaffold(
      appBar: AppBar(
        title: Text('Статус: 24 часа после операции'),
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
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StepIndicator(currentStep: 5),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: Theme.of(context).outlinedButtonTheme.style,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QualityAssessmentPage()));
                      },
                      child: Text(
                        "Ваша оценка качества медицинской помощи",
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 18,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    "Пожалуйста, проидите форму обратной связи",
                    textAlign: TextAlign.center,
                  )
                ],
              ))),
    );
  }
}
