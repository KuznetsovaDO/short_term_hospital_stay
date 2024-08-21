import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:short_term_hospital_stay/controllers/doctors_controller.dart';
import 'package:short_term_hospital_stay/models/patient_model.dart';
import 'package:short_term_hospital_stay/services/shared_preferences_secvice.dart';

import 'package:short_term_hospital_stay/ui/pages/patient_page_3.dart';
import 'package:short_term_hospital_stay/ui/widgets/custom_assessment_widget.dart';

import '../../controllers/patient_controller.dart';
import '../widgets/rounded_radiolist.dart';
import 'auth_page.dart';

class QualityAssessmentPage extends StatefulWidget {
  //const QualityAssessmentPage({Key? key}) : super(key: key);

  @override
  State<QualityAssessmentPage> createState() => _QualityAssessmentState();
}

DoctorsController doctorsController = DoctorsController();
PatientController patientController = PatientController();
List<Widget> radioButtons = [];
final _db = FirebaseFirestore.instance;

class _QualityAssessmentState extends State<QualityAssessmentPage> {
  late String userID;
  final PrefService _prefService = PrefService();
  late PatientModel patient;
  int selected = 0;
  String selectedRadio = '';
  DoctorsController doctorsController = DoctorsController();
  PatientController controller = PatientController();
  List<RoundedRadioItem> items = [];

  @override
  void initState() {
    _prefService.readList().then((value) {
      print(value.toString());
      if (value.isNotEmpty) {
        setState(() async {
          userID = value;
          patient = await controller.getPatientData(access_code: userID);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //эти данные нужно вывести в список из radiobutton

    _db
        .collection('doctors')
        .where('med_profile', isEqualTo: patient.medProfile)
        .get()
        .then((QuerySnapshot snapshot) {
      // Handle the snapshot data here
      snapshot.docs.forEach((doc) {
        setState(() {
          items.add(RoundedRadioItem(
            lastname: doc['lastname'],
            name: doc["name"],
            imageUrl: doc['imageUrl'],
          ));
        });
      });
    }).catchError((error) {
      // Handle any errors that occur during the query
      print("Error getting documents: $error");
    });
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(children: [
          Padding(
              padding: EdgeInsets.all(8),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => {Navigator.of(context).pop()},
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Нам важно Ваше мнение"),
              Text(
                "Это займет около 5 минут",
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.left,
              )
            ],
          )
        ]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Выберите вариант, в наибольшей степени соответствующий Вашему мнению.",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Color.fromARGB(255, 0, 60, 210)),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 7),
                  child: Text(
                      "Оцените уровень вашей удовлетворенности качеством медицинской помощи, оказанной в стационаре кратковременного пребывания ГКБ им. В.М.Буянова"),
                ),
                Text(
                  "(по пятибальной шкале: 5 - полностью удовлетворен, 1 - совсем не удовлетворен)",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 98, 98, 98)),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                    "С чем связана Ваша оценка качества медицинской помощи, оказанной Вам в стационаре кратковременного пребывания ГКБ им. Буянова?"),
                Text(
                  "(Напишите)",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 98, 98, 98)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text("Выберите, пожалуйста, вашего лечащего врача."),

                //
                SizedBox(height: 25),
                Text(
                  "Оцените уровень Вашей удовлетворенности работой Вашего врача",
                  textAlign: TextAlign.left,
                ),
                Text(
                  "(по пятибальной шкале: 5 - полностью удовлетворен, 1 - совсем неудовлетворен)",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 98, 98, 98)),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                    "С чем связана Ваша оценка качества Вашего лечащего врача? "),
                Text(
                  "(Напишите)",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 98, 98, 98)),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                    "Оцените отдельные аспекты работы стационара кратковременного пребыванияГКБ им. В.М.Буянова:"),
                Text(
                  "(по пятибальной шкале: 5 - полностью удовлетворен, 1 - совсем неудовлетворен)",
                  style: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 98, 98, 98)),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 25,
                ),
                Text("удобство записи на прием:"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 25,
                ),
                Text("работа регистратуры (ресепшен):"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 25,
                ),
                Text("организация консультативного приема:"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 25,
                ),
                Text("время, отведенное на прием:"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 25,
                ),
                Text("сроки ожидания плановой госпитализации:"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 25,
                ),
                Text("удобство палат:"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 15,
                ),
                Text("санитарно-гигиенические условия:"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 15,
                ),
                Text("отношение медицинского персонала к пациентам:"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                    "оснащение станционара современным медицинским оборудованием:"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                SizedBox(
                  height: 25,
                ),
                Text("обеспеченность лекарствами препаратами:"),
                SizedBox(
                  height: 7,
                ),
                CustomAssessmentWidget(
                  initialSelectedIndex: selected,
                  onSelectedIndexChangedNumbers:
                      handleToggleButtonsIndexChanged,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 35, bottom: 20),
                  child: Text(
                    "Благодарим за участие в опросе!",
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                    onPressed: () async {
                      patient.survey = true;
                      CollectionReference patients =
                          FirebaseFirestore.instance.collection('patients');

                      // Преобразуем объект PatientModel в JSON
                      Map<String, dynamic> patientJson = patient.toJson();

                      // Добавляем JSON-объект в Firestore
                      try {
                        await patients.doc(patient.id).set(patientJson);
                        print("Patient added to Firestore successfully!");
                      } catch (error) {
                        print("Failed to add patient to Firestore: $error");
                      }

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Спасибо за участие в опросе!'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          patient.status == "Выписан(-а)"
                                              ? AuthPage()
                                              : PatientPage3(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Отправить форму"))
              ]),
        ),
      ),
    );
  }

  void handleToggleButtonsIndexChanged(int index) {
    // Обработка выбранного индекса
    setState(() {
      selected = index;
    });
  }
}
