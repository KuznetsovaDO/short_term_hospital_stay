import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:short_term_hospital_stay/services/shared_preferences_secvice.dart';
import '../../models/patient_model.dart';
import '../../routes.dart';
import '../widgets/step_indicator.dart';
import 'patient_after_operation_page.dart';

class PatientBeforeOperationPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final PatientModel patient;
  FirebaseAuth auth = FirebaseAuth.instance;
  PatientBeforeOperationPage({required this.patient});
  final PrefService _prefService = PrefService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: Text('Статус: после операции',
              style: GoogleFonts.ibmPlexSans(
                  fontSize: 18, letterSpacing: 0, fontWeight: FontWeight.w500)),
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () async {
                        bool? result = await showExitProfileDialog(context);
                        if (result != null && result) {
                          await _prefService
                              .removeCache("password")
                              .whenComplete(() {
                            Navigator.of(context).pushNamed(AuthRoute);
                          });
                        }
                      })
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StepIndicator(currentStep: 1),
                Container(
                    margin: EdgeInsets.only(top: 40, bottom: 15),
                    child: ElevatedButton(
                        onPressed: () {
                          changeStatus(patient.getId, context);
                        },
                        style: Theme.of(context).outlinedButtonTheme.style,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'После операции',
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(
                                    Icons.done,
                                    size: 30,
                                  ))
                            ]))),
                Text('Пожалуйста, нажмите на эту кнопку после операции',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //     margin: EdgeInsets.symmetric(vertical: 40),
                //     child: OutlinedButton(
                //         onPressed: () {},
                //         style: TextButton.styleFrom(
                //             textStyle: Theme.of(context).textTheme.labelMedium,
                //             elevation: 0,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: BorderSide(width: 2, color: Colors.black),
                //             backgroundColor: Colors.white,
                //             foregroundColor: Colors.black),
                //         child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Написать врачу',
                //               ),
                //               Container(
                //                   margin: EdgeInsets.symmetric(horizontal: 8),
                //                   child: Icon(
                //                     Icons.create,
                //                     size: 25,
                //                   ))
                //             ]))),

                SizedBox(height: 30),
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
                            "Рекомендации до операции",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "1. Перед операцией вам нужно сдать все необходимые анализ ыи пройти исследования:",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            " · Посмотреть список можно в медицинском заключении",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "2. За 3 дня до операции категорически запрещено: ",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            " · употреблять алкогольные напитки\n" +
                                " · выкуривать более 3-5 сигарет в день\n" +
                                " · выпивать более 3-х чашек кофе\n" +
                                " · усиленно заниматься физическими упражнениями\n",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "3. За 5 дней до операции:",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            " · Отложите прием кардиомагнила и аспирина (по назначению лечащего врача)",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            " · Если вы принимаете варфарин, ксарелто или другие препараты, снижающие свертываемость крови, - пожалуйста, сообщите об этом лечащему врачу",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "4. Утром в день операции: ",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            " · Не есть и не пить (можно запить лекарственные препараты)",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "5. Операция откладывается при всех признаках инфекционных болезней:",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            " · ОРВИ\n" +
                                " · Гнойничковые заболевания кожи\n" +
                                " · При повышении температуры тела за неделю до операции (независимо от причины)\n",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          )
                        ])),
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
                            "После операции",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "1. Пожалуйста, не садитесь за руль. Это может создать опасную ситуацию на дороге!",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "2. Ваши родственники смогут забрать вас сразу после выписки ",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "3. Мы рекомендуем планировать домой заранее:",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            "· Попросите родственников встретить вас\n" +
                                "И/или рассмотрите  возможность вызова такси",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "· Если вы принимаете варфарин, ксарелто или другие препараты, снижающие свертываемость крови, - пожалуйста, сообщите об этом лечащему врачу",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                              color: Colors.black,
                            ),
                          ),
                        ]))
              ],
            ),
          )),
        ));
  }

  Future<void> changeStatus(String patientId, BuildContext context) async {
    try {
      // Получаем ссылку на документ по patientId
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(patientId);

      // Обновляем поля документа с помощью метода update
      await documentReference.update({'status': 'После операции'});

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PatientAfterOperationPage(
            patient: patient,
          ),
        ),
      );
    } catch (error) {
      print('Произошла ошибка при обновлении статуса: $error');
    }
  }

  Future<bool?> showExitProfileDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Хотите выйти из профиля?"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _prefService.removeCache("password").whenComplete(() {
                  Navigator.of(context).pushNamed(AuthRoute);
                });
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
