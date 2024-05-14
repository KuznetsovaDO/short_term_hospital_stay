import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:short_term_hospital_stay/controllers/doctors_controller.dart';
import 'package:short_term_hospital_stay/models/doctor_model.dart';
import 'package:short_term_hospital_stay/ui/pages/after_discharged_page.dart';
import 'package:short_term_hospital_stay/ui/widgets/custom_assessment_widget.dart';
import 'package:short_term_hospital_stay/ui/widgets/patient_condition_widget.dart';
import '../../controllers/patient_controller.dart';
import '../../models/patient_model.dart';
import '../widgets/rounded_radiolist.dart';
import 'patient_after_operation_page.dart';
import 'patient_page.dart';

class QualityAssessmentPage extends StatefulWidget {
  //const QualityAssessmentPage({Key? key}) : super(key: key);
  final PatientModel patient;

  QualityAssessmentPage({required this.patient});

  @override
  State<QualityAssessmentPage> createState() => _QualityAssessmentState();
}

DoctorsController doctorsController = DoctorsController();
PatientController patientController = PatientController();

class _QualityAssessmentState extends State<QualityAssessmentPage> {
  int selected = 0;
  DoctorsController doctorsController = DoctorsController();
  late Future<List<RoundedRadioItem>> items;

  @override
  void initState() {
    super.initState();
    // Выполняем асинхронную операцию и сохраняем результат в переменную items
    items = _fetchDoctorListData();
  }

  Future<List<RoundedRadioItem>> _fetchDoctorListData() async {
    List<Map<String, dynamic>> doctorDataList =
        await doctorsController.doctorListData(widget.patient.getProfile);
    List<RoundedRadioItem> radioItems = doctorDataList.map((item) {
      return RoundedRadioItem(
        lastname: item['lastname'],
        name: item["name"],
        imageUrl: item['imageUrl'],
      );
    }).toList();
    RoundedRadioItem last = RoundedRadioItem(
        lastname: "Я не помню ФИО врача", name: "", imageUrl: "");
    radioItems[radioItems.length - 1] = last;
    return radioItems;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(children: [
          Padding(padding: EdgeInsets.all(8), child: Icon(Icons.arrow_back)),
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "Выберите вариант, в наибольшей степени соответствующий Вашему мнению.",
              style: TextStyle(
                  fontSize: 14, color: Color.fromARGB(255, 0, 60, 210)),
              textAlign: TextAlign.center,
            ),
            Text(
                "Оцените уровень вашей удовлетворенности качеством медицинской помощи, оказанной в стационаре кратковременного пребывания ГКБ им. В.М.Буянова"),
            Text(
                "(по пятибальной шкале: 5 - полностью удовлетворен, 1 - совсем не удовлетворен)"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text(
                "С чем связана Ваша оценка качества медицинской помощи, оказанной Вам в стационаре кратковременного пребывания ГКБ им. Буянова?\n(Напишите)"),
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
            Text("Выберите, пожалуйста, вашего лечащего врача."),
            RoundedRadioList(
              items: items,
              onChanged: (value) {
                setState(() {
                  selected = value;
                });
              },
            ),
            Text(
                "Оцените уровень Вашей удовлетворенности работой Вашего врача"),
            Text(
                "(по пятибальной шкале: 5 - полностью удовлетворен, 1 - совсем неудовлетворен)"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text(
                "С чем связана Ваша оценка качества Вашего лечащего врача? (напишите)"),
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
            Text(
                "Оцените отдельные аспекты работы стационара кратковременного пребыванияГКБ им. В.М.Буянова:"),
            Text(
                "(по пятибальной шкале: 5 - полностью удовлетворен, 1 - совсем неудовлетворен)"),
            Text("удобство записи на прием:"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text("работа регистратуры (ресепшен):"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text("организация консультативного приема:"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text("время, отведенное на прием:"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text("сроки ожидания плановой госпитализации:"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text("удобство палат:"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text("санитарно-гигиенические условия:"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text("отношение медицинского персонала к пациентам:"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text(
                "оснащение станционара современным медицинским оборудованием:"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text("обеспеченность лекарствами препаратами:"),
            CustomAssessmentWidget(
              initialSelectedIndex: selected,
              onSelectedIndexChangedNumbers: handleToggleButtonsIndexChanged,
            ),
            Text("Благодарим за участие в опросе!"),
            OutlinedButton(
                onPressed: () {
                  widget.patient.survey = true;
                  CollectionReference patients =
                      FirebaseFirestore.instance.collection('patients');

                  // Преобразуем объект PatientModel в JSON
                  Map<String, dynamic> patientJson = widget.patient.toJson();

                  // Добавляем JSON-объект в Firestore
                  patients
                      .doc(widget.patient.id)
                      .set(patientJson)
                      .then((value) {
                    print("Patient added to Firestore successfully!");
                  }).catchError((error) {
                    print("Failed to add patient to Firestore: $error");
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            widget.patient.status == "Выписан(-а)"
                                ? AfterDischargedPage(
                                    patient: widget.patient,
                                  )
                                : AfterDischargedPage(
                                    patient: widget.patient,
                                  )),
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
