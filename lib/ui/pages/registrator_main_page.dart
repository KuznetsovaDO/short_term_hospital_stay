import 'dart:async';
import 'package:flutter/material.dart';
import 'package:short_term_hospital_stay/ui/pages/new_patient_page.dart';
import '../../controllers/patient_controller.dart';
import 'auth_stuff_page.dart';
import 'list_patients_page.dart';

class RegistratorMainPage extends StatefulWidget {
  const RegistratorMainPage({super.key});

  @override
  State<RegistratorMainPage> createState() => _RegistratoreMainPageState();
}

class _RegistratoreMainPageState extends State<RegistratorMainPage> {
  final formKey = GlobalKey<FormState>();

  PatientController controller = PatientController();
  int countDischargedPatients = 0;
  int countActivePatients = 0;

  @override
  void initState() {
    controller
        .getCountBeforeDischargedPatient("Регистрация")
        .then((value) => setState(() {
              this.countActivePatients = value;
            }));
    controller
        .getCountAfterDischargedPatient("Регистрация")
        .then((value) => setState(() {
              this.countDischargedPatients = value;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String medProfile = "Регистрация";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GestureDetector(
          onTap: () async {
            bool? result = await showExitProfileDialog(context);
            if (result != null && result) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthStaffPage(),
                  ));
            }
          },
          child: Text(
            'Выйти из профиля',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              color: Colors.grey,
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.notifications),
        //     onPressed: () {
        //       // Действия при нажатии на иконку уведомлений
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Профиль: Регистрация ",
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 20,
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
                            medProfile: "Регистрация",
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
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text("Пациенты в отделении"),
                            Text(
                                "Количество: " + countActivePatients.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
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

                  showAboutDialog(context: context);
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
                            medProfile: "Регистрация",
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 15),
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
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text("Выписанные пациенты"),
                            Text(
                                "Количество: " +
                                    countDischargedPatients.toString(),
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewPatientPage(),
                          ),
                        );
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Добавить нового пациента"),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(Icons.add)
                          ]))),
            ],
          ),
        ),
      ),
    );
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
              child: Text('Да',
                  style: TextStyle(color: Color.fromARGB(255, 0, 7, 205))),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(
                    false); // Возвращает false, если пользователь выбрал "Нет"
              },
              child: Text('Нет',
                  style: TextStyle(color: Color.fromARGB(255, 0, 7, 205))),
            ),
          ],
        );
      },
    );
  }
}
