import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:short_term_hospital_stay/services/shared_preferences_secvice.dart';
import 'package:short_term_hospital_stay/ui/pages/address_and_contacts_page.dart';
import 'package:short_term_hospital_stay/ui/pages/after_discharged_page.dart';
import 'package:short_term_hospital_stay/ui/pages/patient_page_3.dart';
import 'package:short_term_hospital_stay/ui/pages/patient_page_4.dart';
import '../../controllers/patient_controller.dart';
import '../../models/patient_model.dart';
import 'auth_stuff_page.dart';
import 'patient_page_2.dart';
import 'patient_page_1.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthPage> {
  final PrefService _prefService = PrefService();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool medicalCardChecked = false;
  bool passportChecked = false;
  late PatientModel patient;
  final formKey = GlobalKey<FormState>();
  PatientController controller = PatientController();
  String debugMessage = "";
  bool isLoading = false;

  //  список состояний чек-листа
  List<bool> checklist = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  String userID = "";

  @override
  void initState() {
    _prefService.readList().then((value) {
      print(value.toString());
      if (value.isNotEmpty) {
        setState(() {
          checklist = value;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) CircularProgressIndicator();
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/icons/logo.png",
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AuthStaffPage()));
            },
            child: Text(
              'Войти как сотрудник',
              style: GoogleFonts.ibmPlexSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 30, 15, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Пожалуйста, введите код пациента',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 30,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w800)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    'Код был ранее выдан Вам в регистратуре',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: 18,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 10,
                    ),
                    child: PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      appContext: context,
                      length: 4,
                      obscureText: false,
                      textStyle: GoogleFonts.ibmPlexSans(
                          fontSize: 30,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w700),
                      animationType: AnimationType.fade,
                      validator: (v) {},
                      controller: textEditingController,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: MediaQuery.of(context).size.width / 5,
                          fieldWidth: MediaQuery.of(context).size.width / 5,
                          borderRadius: BorderRadius.circular(14),
                          activeFillColor: Colors.white,
                          inactiveColor: Colors.grey[400],
                          selectedColor: Colors.blueAccent[700],
                          activeColor: Colors.blueAccent[700]),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onChanged: (value) {
                        debugMessage = "";
                        setState(() {
                          codeValue = value;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  debugMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromARGB(255, 178, 1, 1)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (codeValue.length < 4) {
                        setState(() {
                          debugMessage =
                              "Код должен содержать не менее 4 символов";
                        });
                      } else {
                        bool isPatientValid =
                            await controller.checkPatient(codeValue);
                        if (isPatientValid) {
                          patient = await controller.getPatientData(
                              access_code: codeValue);
                          _prefService.setCache("userID", patient.id);
                          if (patient.status == null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientPage1()));
                          } else if (patient.status == "До операции") {
                            _prefService.setCache("lastscreen", patient.status);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientPage1()));
                          } else if (patient.status == "После операции") {
                            _prefService.setCache("lastscreen", patient.status);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientPage2()));
                          } else if (patient.status == "Выписан") {
                            _prefService.setCache("lastscreen", patient.status);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientPage4()));
                          } else if (patient.status ==
                              "12 часов после операции") {
                            _prefService.setCache("lastscreen", patient.status);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientPage3()));
                          } else if (patient.status ==
                              "24 часа после операции") {
                            _prefService.setCache("lastscreen", patient.status);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AfterDischargedPage()));
                          }
                        } else {
                          setState(() {
                            debugMessage = "Пациент с таким кодом не найден";
                            isLoading = false;
                          });
                        }
                      }
                    },
                    style: Theme.of(context).outlinedButtonTheme.style,
                    child: Text('Войти'),
                  ),
                ),
                Text(
                  'Не получили код?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '+7 999 200 10 10',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSans(
                      fontSize: 17,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdressPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(width: 1.5, color: Colors.black),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'Посмотреть адрес и контакты',
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 7),
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 25,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                        "Чек-лист - что стоит взять с собой в больницу",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "1. Документы",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: Colors.grey[800],
                        ),
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Паспорт'),
                        value: checklist[0],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[0] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Полис ОМС'),
                        value: checklist[1],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[1] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('СНИЛС'),
                        value: checklist[2],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[2] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      Text(
                        "2. Обследования и выписки",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        "Возьмите все документы, связанные с причиной госпитализации",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                          color: Colors.grey[400],
                        ),
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Результаты анализов'),
                        value: checklist[3],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[3] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Справки с обследованиями'),
                        value: checklist[4],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[4] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Выписки из других больниц'),
                        value: checklist[5],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[5] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      Text(
                        "3. Личные вещи",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: Colors.grey[800],
                        ),
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Сменная обувь'),
                        value: checklist[6],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[6] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Средства личной гигиены'),
                        value: checklist[7],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[7] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      Text(
                        "4. Техника и зарядные устройства",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0,
                          color: Colors.grey[800],
                        ),
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Телефон'),
                        value: checklist[8],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[8] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Наушники, чтобы не мешать соседям'),
                        value: checklist[9],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[9] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Color.fromARGB(255, 0, 59, 206),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Можно взять ноутбук или планшет'),
                        value: checklist[10],
                        onChanged: (bool? value) {
                          setState(() {
                            checklist[10] = value!;

                            _prefService
                                .createList(checklist
                                    .map((boolValue) => boolValue.toString())
                                    .toList()!)
                                .whenComplete(() {});
                          });
                        },
                      ),
                      Text(
                        "Помните: в больнице никто не может гарантировать сохранность ваших вещей.",
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                          color: Colors.redAccent,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// // Сохранение списка булевых значений
//   void saveCheckboxStates(List<bool> values) async {
//     SharedPreferencesPlugin prefs = await SharedPreferencesPlugin.getInstance();
//     List<String> stringValues =
//         values.map((value) => value.toString()).toList();
//     await prefs.setValue('checkbox_states', stringValues as String);
//   }

// Загрузка списка булевых значений
  loadCheckboxStates() async {
    _prefService
        .createList(
            checklist.map((boolValue) => boolValue.toString()).toList()!)
        .whenComplete(() {});
  }

  Future<void> auth(PatientModel patient, BuildContext context) async {
    if (patient.status == "До операции") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PatientPage1(),
        ),
      );
      _prefService.setCache("lastscreen", "BeforeOperation");
    }
    //  else if (status == "После операции") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => PatientAfterOperationPage(

    //       ),
    //     ),
    //   );
    // } else if (status == "Выписан(-а)") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => PatientDischargedPage(

    //       ),
    //     ),
    //   );
    // } else if (status == "12 часов после операции") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => PatientDischargedPage(

    //         isMorning: true,
    //       ),
    //     ),
    //   );
    // } else if (status == "форма вечер") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => EveningAndMorningFormPage(

    //         isMorning: false,
    //       ),
    //     ),
    //   );
    // } else if (status == "24 часа после операции") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => AfterDischargedPage(

    //       ),
    //     ),
    //   );
    // } else if (status == "форма утро") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => EveningAndMorningFormPage(
    //         isMorning: true,

    //       ),
    //     ),
    //   );
    // }
  }
}
