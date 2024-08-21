import 'package:flutter/material.dart';
import 'package:short_term_hospital_stay/ui/pages/patient_page_3.dart';

import 'after_discharged_page.dart';
import 'package:url_launcher/url_launcher.dart';

class GratitudePage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final bool isMorning;
  final bool alarmingSymptoms;
  GratitudePage({this.isMorning = false, this.alarmingSymptoms = false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/stars.png',
                height: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18, bottom: 20),
              child: Text(
                'Спасибо!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
                'Мы получили Вашу форму. Ваши ответы будут видны только врачу.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                child: ElevatedButton(
                  onPressed: () {
                    if (isMorning) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AfterDischargedPage(
                                    isMorning: true,
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientPage3()));
                    }
                  },
                  style: Theme.of(context).outlinedButtonTheme.style,
                  child: Text(
                    'Далее',
                  ),
                )),
            alarmingSymptoms
                ? OutlinedButton(
                    onPressed: () async {
                      if (await canLaunchUrl(Uri(scheme: 'tel', path: '112'))) {
                        await launchUrl(Uri(scheme: 'tel', path: '112'));
                      } else {
                        throw 'Не удалось запустить приложение телефона';
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text('Позвонить 112',
                        style: TextStyle(color: Colors.red)),
                  )
                : SizedBox()
          ],
        ),
      )),
    );
  }
}
