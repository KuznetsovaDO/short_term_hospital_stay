import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:short_term_hospital_stay/services/shared_preferences_secvice.dart';
import 'package:short_term_hospital_stay/ui/pages/auth_page.dart';

import '../widgets/patient_condition_widget.dart';
import '../widgets/step_indicator.dart';
import 'patient_page_3.dart';

class PatientPage2 extends StatefulWidget {
  @override
  _PatientAfterOperationPageState createState() =>
      _PatientAfterOperationPageState();
}

class _PatientAfterOperationPageState extends State<PatientPage2> {
  final PrefService _prefService = PrefService();
  final formKey = GlobalKey<FormState>();
  int selectedButtonIndex = 0;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    List<bool> _isSelected = [false, true];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Статус: после операции"),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                bool? result = await showExitProfileDialog(context);
                if (result != null && result) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthPage(),
                      ));
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StepIndicator(currentStep: 2),
                  Padding(
                      padding: EdgeInsets.fromLTRB(5, 25, 0, 10),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Как вы себя чувствуете?',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium,
                          ))),
                  CustomToggleButtons(
                    initialSelectedIndex: selectedButtonIndex,
                    onSelectedIndexChangedSmiles:
                        handleToggleButtonsIndexChanged,
                    onSelectedIndexChangedNumbers:
                        handleToggleButtonsIndexChanged,
                    isSmiles: true,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Жалоб\nнет',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            'Очень\nплохо',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      )),
                  OutlinedButton(
                    onPressed: () {
                      _prefService.readCache("userID").then((value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            changeStatus(value, context);
                          });
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(width: 1, color: Colors.black),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'Сохранить',
                          style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            child: const Icon(
                              Icons.done,
                              size: 25,
                            ))
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            _prefService.setCache("lastscreen", "Выписан");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientPage3()));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Я дома',
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Icon(
                                      Icons.home,
                                      size: 30,
                                    ))
                              ]),
                          style: Theme.of(context).outlinedButtonTheme.style)),
                  Text('Пожалуйста, нажмите эту кнопку после прибытия домой',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 10),
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
                            'Важная информация',
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
                            'Сейчас вы находитесь в палате под наблюдением медицинского персонала',
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            " · В случае необходимости Вы можете обратиться на пост медсестры или нажать на кнопку экстренного вызова рядом с вами",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            " · Перед выпиской вам будет выдан выписной эпикриз с рекомендациями на реабилитационный период.",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            " · После получения выписки вы сможете отправиться домой.\n",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                              'После операции\n',
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '1. Пожалуйста, не садись за руль. Это может создать опасную ситуацию на дороге!\n',
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              '2. Ваши родственники смогут вас забрать вас сразу после выписки\n',
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              '3. Мы рекомендуем планировать дорогу домой заранее:\n',
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              " · Попросите родственников встретить вас",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              " · И/или рассмотрите возможность вызова такси",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                          ])),
                ],
              ))),
    );
  }

  Future<void> changeStatus(String patientId, BuildContext context) async {
    try {
      // Получаем ссылку на документ с заданным documentId
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(patientId);

      // Обновляем поля документа с помощью метода update
      await documentReference.update({'status': 'Выписан'});
      await documentReference.update({'ConditionAfterOperation': selected + 1});
    } catch (e) {
      print('Ошибка при обновлении поля документа: $e');
    }
  }

  void handleToggleButtonsIndexChanged(int index) {
    // Обработка выбранного индекса, сохранение его или что угодно еще
    // Например, вы можете сохранить индекс в состоянии или отправить на сервер
    setState(() {
      selected = index;
    });
  }

  showExitProfileDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Хотите выйти из профиля?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    true); // Возвращает true, если пользователь выбрал "Да"
              },
              child: Text(
                'Ок',
                style: TextStyle(color: Color.fromARGB(255, 0, 7, 205)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // Возвращает false, если пользователь выбрал "Нет"
              },
              child: Text(
                'Нет',
                style: TextStyle(color: Color.fromARGB(255, 0, 7, 205)),
              ),
            ),
          ],
        );
      },
    );
  }
}
