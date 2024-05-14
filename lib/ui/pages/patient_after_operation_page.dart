import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:short_term_hospital_stay/models/patient_model.dart';
import 'package:short_term_hospital_stay/ui/pages/auth_page.dart';
import '../widgets/custom_richtext_widget.dart';
import '../widgets/patient_condition_widget.dart';
import '../widgets/step_indicator.dart';
import 'patient_discharged_page.dart';

class PatientAfterOperationPage extends StatefulWidget {
  final PatientModel patient;
  PatientAfterOperationPage({required this.patient});
  @override
  _PatientAfterOperationPageState createState() =>
      _PatientAfterOperationPageState();
}

class _PatientAfterOperationPageState extends State<PatientAfterOperationPage> {
  final formKey = GlobalKey<FormState>();
  int selectedButtonIndex = 0;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    List<bool> _isSelected = [false, true];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Статус: перед операцией"),
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
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Как вы себя чувствуете?',
                            textAlign: TextAlign.left,
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
                          EdgeInsets.symmetric(horizontal: 20, vertical: 7),
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
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientDischargedPage(
                                          patient: widget.patient,
                                        )));
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
                  widget.patient.survey
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 35),
                          child: OutlinedButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side:
                                      BorderSide(width: 2, color: Colors.black),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Оценить качество обслуживания',
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Icon(
                                          Icons.create,
                                          size: 25,
                                        ))
                                  ])))
                      : SizedBox(),
                  Text(
                      "Пожалуйста, пройдите форму обратной связи, чтобы мы могли улучшить работу нашего стационара! Спасибо!"),
                  CustomRichTextContainer(
                      richText: RichText(
                    text: TextSpan(
                      text: 'Рекомендации\n\n',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'В течение',
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ))
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
      await documentReference.update({'status': 'Выписан(-а)'});
      await documentReference.update({'ConditionAfterOperation': selected + 1});
      // ignore: use_build_context_synchronously

      // print('Поле документа успешно обновлено');
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
    changeStatus(widget.patient.id, context);
  }

  Future<bool?> showExitProfileDialog(BuildContext context) {
    return showDialog<bool>(
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
              child: Text('Да'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // Возвращает false, если пользователь выбрал "Нет"
              },
              child: Text('Нет'),
            ),
          ],
        );
      },
    );
  }
}
