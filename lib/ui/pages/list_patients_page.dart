import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../controllers/patient_controller.dart';
import '../../models/patient_model.dart';
import 'patient_page.dart';

class ListPatientsPage extends StatefulWidget {
  // final String? doctorId;
  final String medProfile;
  final bool isDischargedPatients;
  const ListPatientsPage(
      {super.key, required this.medProfile, this.isDischargedPatients = false});

  @override
  State<ListPatientsPage> createState() => _ListPatientsPageState();
}

class _ListPatientsPageState extends State<ListPatientsPage> {
  late String medProfile = widget.medProfile;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  String dischargedText = "Выписать";

  final formKey = GlobalKey<FormState>();

  PatientController controller = PatientController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: TextButton(
            onPressed: () {},
            child: Text(
              'Выйти из профиля',
              textAlign: TextAlign.center,
              style: GoogleFonts.ibmPlexSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: Colors.grey),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [
            FutureBuilder<List<PatientModel>>(
              future: widget.isDischargedPatients
                  ? controller
                      .getPatientsFromProfileAfterDischarged(widget.medProfile)
                  : controller.getPatientsFromProfileBeforeDischarged(
                      widget.medProfile),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (c, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PatientProfile(
                                            patientId: snapshot.data![index].id,
                                          )));
                              ;
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.grey, width: 1),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(8),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  120),
                                          child: Image.asset(
                                              'assets/images/smile' +
                                                  snapshot.data![index]
                                                      .lastCondition +
                                                  '.png'),
                                          decoration: BoxDecoration(
                                            color: snapshot.data![index]
                                                        .lastCondition ==
                                                    "1"
                                                ? Colors.green.shade300
                                                : snapshot.data![index]
                                                            .lastCondition ==
                                                        "2"
                                                    ? Colors.green.shade200
                                                    : snapshot.data![index]
                                                                .lastCondition ==
                                                            "3"
                                                        ? Colors.yellow.shade200
                                                        : snapshot.data![index]
                                                                    .lastCondition ==
                                                                "4"
                                                            ? Colors
                                                                .orange.shade300
                                                            : snapshot
                                                                        .data![
                                                                            index]
                                                                        .lastCondition ==
                                                                    "5"
                                                                ? Colors.red
                                                                    .shade300
                                                                : Colors.white,
                                            border: Border.all(
                                              width: 0.5,
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("#" +
                                                snapshot.data![index].id
                                                    .toString()),
                                            Text(
                                              "Профиль: " +
                                                  snapshot
                                                      .data![index].medProfile,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            Text(
                                              "Статус: " +
                                                  snapshot.data![index].status,
                                              style: TextStyle(fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 15),
                                            height: 40,
                                            child: OutlinedButton(
                                              style: TextButton.styleFrom(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.black,
                                                ),
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.black,
                                              ),
                                              onPressed: () {
                                                changeStatus(
                                                    snapshot.data![index].id
                                                        .toString(),
                                                    context);
                                              },
                                              child: Text(dischargedText),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> changeStatus(String patientId, BuildContext context) async {
    try {
      // Получаем ссылку на документ по patientId
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(patientId);

      // Обновляем поля документа с помощью метода update
      await documentReference.update({'status': 'Выписан(-а)'});
      setState(() {
        dischargedText = "Выписан";
      });
    } catch (error) {
      print('Произошла ошибка при обновлении статуса: $error');
    }
  }
}
