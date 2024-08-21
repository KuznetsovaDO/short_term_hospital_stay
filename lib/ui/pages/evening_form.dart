import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:short_term_hospital_stay/services/shared_preferences_secvice.dart';
import 'package:short_term_hospital_stay/ui/pages/gratitude_page.dart';
import 'package:short_term_hospital_stay/ui/widgets/custom_triangle_togglebutton.dart';
import '../widgets/smiley_button.dart';

class EveningForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _EveningFormPageState createState() => _EveningFormPageState();
}

class _EveningFormPageState extends State<EveningForm> {
  final formKey = GlobalKey<FormState>();
  List<bool> feelingStates = [false, false, false, false, false];
  List<bool> painStates = [false, false, false, false, false];
  String strTemperature = "";
  late String userID;
  final PrefService _prefService = PrefService();

  int selectedCondition = 0;
  int step = 0;

  int selectedPain = 0;
  late TextEditingController _controller;

  double _temperature = 36.6;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _temperature.toString());
    _prefService.readList().then((value) {
      print(value.toString());
      if (value.isNotEmpty) {
        setState(() {
          userID = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> someMap = {};
    return Scaffold(
      appBar: AppBar(
        title: Text('Форма "Вечер"'),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //   'Вы ответили на $step вопросов из 6 ',
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.grey,
                  //   ),
                  //   textAlign: TextAlign.start,
                  // ),
                  Text(
                    'Оцените свое самочувствие в настоящее время?',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    '(где 1 - жалоб нет, 5 - очень плохо)',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  step += 1;
                                  step += 1;
                                  feelingStates = [
                                    true,
                                    false,
                                    false,
                                    false,
                                    false
                                  ];
                                });
                              },
                              child: SmileyButton(
                                color: Color.fromARGB(255, 193, 255, 192),
                                iconNumber: '1',
                                borderColor: Color.fromARGB(255, 88, 190, 81),
                                selectedColor:
                                    Color.fromARGB(255, 162, 248, 161),
                                selectedBorderColor:
                                    Color.fromARGB(255, 36, 183, 34),
                                isSelected: feelingStates[0],
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    step += 1;
                                    feelingStates = [
                                      false,
                                      true,
                                      false,
                                      false,
                                      false
                                    ];
                                  });
                                },
                                child: SmileyButton(
                                  color: Color.fromARGB(255, 211, 255, 161),
                                  iconNumber: '2',
                                  borderColor:
                                      Color.fromARGB(255, 140, 194, 77),
                                  isSelected: feelingStates[1],
                                  selectedColor:
                                      Color.fromARGB(255, 195, 246, 136),
                                  selectedBorderColor:
                                      Color.fromARGB(255, 126, 216, 22),
                                )),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    step += 1;
                                    feelingStates = [
                                      false,
                                      false,
                                      true,
                                      false,
                                      false
                                    ];
                                  });
                                },
                                child: SmileyButton(
                                  color: Color.fromARGB(255, 244, 255, 149),
                                  selectedBorderColor:
                                      Color.fromARGB(255, 238, 227, 0),
                                  selectedColor:
                                      Color.fromARGB(255, 249, 255, 72),
                                  iconNumber: '3',
                                  borderColor:
                                      Color.fromARGB(255, 234, 243, 70),
                                  isSelected: feelingStates[2],
                                )),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    step += 1;
                                    feelingStates = [
                                      false,
                                      false,
                                      false,
                                      true,
                                      false
                                    ];
                                  });
                                },
                                child: SmileyButton(
                                  color: Color.fromARGB(255, 255, 236, 177),
                                  selectedColor:
                                      Color.fromARGB(255, 255, 216, 108),
                                  selectedBorderColor:
                                      Color.fromARGB(255, 233, 164, 2),
                                  iconNumber: '4',
                                  borderColor:
                                      Color.fromARGB(255, 230, 181, 84),
                                  isSelected: feelingStates[3],
                                )),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    step += 1;
                                    feelingStates = [
                                      false,
                                      false,
                                      false,
                                      false,
                                      true
                                    ];
                                  });
                                },
                                child: SmileyButton(
                                  color: Color.fromARGB(255, 252, 208, 208),
                                  selectedColor:
                                      Color.fromARGB(255, 244, 129, 129),
                                  selectedBorderColor:
                                      Color.fromARGB(255, 209, 63, 18),
                                  iconNumber: '5',
                                  borderColor:
                                      Color.fromARGB(255, 234, 119, 119),
                                  isSelected: feelingStates[4],
                                )),
                          ])),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Пожалуйста, оцените интенсивность боли в послеоперационной области?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '(где 1 - почти не ощущаю, 5 - сложно терпеть)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  step += 1;
                                  painStates = [
                                    true,
                                    false,
                                    false,
                                    false,
                                    false
                                  ];
                                });
                              },
                              child: SmileyButton(
                                isSmiles: false,
                                color: Color.fromARGB(255, 193, 255, 192),
                                iconNumber: '1',
                                borderColor: Color.fromARGB(255, 88, 190, 81),
                                selectedColor:
                                    Color.fromARGB(255, 162, 248, 161),
                                selectedBorderColor:
                                    Color.fromARGB(255, 36, 183, 34),
                                isSelected: painStates[0],
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    step += 1;
                                    painStates = [
                                      false,
                                      true,
                                      false,
                                      false,
                                      false
                                    ];
                                  });
                                },
                                child: SmileyButton(
                                  isSmiles: false,
                                  color: Color.fromARGB(255, 211, 255, 161),
                                  iconNumber: '2',
                                  borderColor:
                                      Color.fromARGB(255, 140, 194, 77),
                                  isSelected: painStates[1],
                                  selectedColor:
                                      Color.fromARGB(255, 195, 246, 136),
                                  selectedBorderColor:
                                      Color.fromARGB(255, 126, 216, 22),
                                )),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    step += 1;
                                    painStates = [
                                      false,
                                      false,
                                      true,
                                      false,
                                      false
                                    ];
                                  });
                                },
                                child: SmileyButton(
                                  isSmiles: false,
                                  color: Color.fromARGB(255, 244, 255, 149),
                                  selectedBorderColor:
                                      Color.fromARGB(255, 238, 227, 0),
                                  selectedColor:
                                      Color.fromARGB(255, 249, 255, 72),
                                  iconNumber: '3',
                                  borderColor:
                                      Color.fromARGB(255, 234, 243, 70),
                                  isSelected: painStates[2],
                                )),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    step += 1;
                                    painStates = [
                                      false,
                                      false,
                                      false,
                                      true,
                                      false
                                    ];
                                  });
                                },
                                child: SmileyButton(
                                  isSmiles: false,
                                  color: Color.fromARGB(255, 255, 236, 177),
                                  selectedColor:
                                      Color.fromARGB(255, 255, 216, 108),
                                  selectedBorderColor:
                                      Color.fromARGB(255, 233, 164, 2),
                                  iconNumber: '4',
                                  borderColor:
                                      Color.fromARGB(255, 230, 181, 84),
                                  isSelected: painStates[3],
                                )),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    step += 1;
                                    painStates = [
                                      false,
                                      false,
                                      false,
                                      false,
                                      true
                                    ];
                                  });
                                },
                                child: SmileyButton(
                                  isSmiles: false,
                                  color: Color.fromARGB(255, 252, 208, 208),
                                  selectedColor:
                                      Color.fromARGB(255, 244, 129, 129),
                                  selectedBorderColor:
                                      Color.fromARGB(255, 209, 63, 18),
                                  iconNumber: '5',
                                  borderColor:
                                      Color.fromARGB(255, 234, 119, 119),
                                  isSelected: painStates[4],
                                )),
                          ])),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(
                        'Пожалуйста, укажите вашу текущую температуру тела',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Введите температуру',
                              suffixText: '°C',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          controller: _controller,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onChanged: (value) {
                            setState(() {
                              step += 1;
                              if (double.tryParse(value)! > 35 &&
                                  double.tryParse(value)! < 42.5) {
                                _temperature =
                                    double.tryParse(value) ?? _temperature;
                              } else {
                                //showMessage(context);
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(102, 48, 72, 251)),
                            surfaceTintColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(167, 148, 165, 208)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(197, 255, 255, 255)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 7, 27, 155))),
                        onPressed: () {
                          if (_temperature < 42.5) {
                            _incrementTemperature(0.1);
                          }
                        },
                        child: Icon(
                          Icons.arrow_upward,
                          color: Color.fromARGB(255, 7, 27, 155),
                        ),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(102, 48, 72, 251)),
                            surfaceTintColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(167, 148, 165, 208)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(197, 255, 255, 255)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 7, 27, 155))),
                        onPressed: () {
                          if (_temperature > 35) {
                            _incrementTemperature(-0.1);
                          }
                        },
                        child: Icon(Icons.arrow_downward),
                      ),
                    ],
                  ),
                  Text(strTemperature),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        'Отметьте, пожалуйста, наличие/отсутствие у Вас следующих симпотомов:',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 17,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      )),
                  const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Есть ли у вас головокружение?',
                        textAlign: TextAlign.start,
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Align(
                          alignment: Alignment.center,
                          child: CustomTriangleToggleButtons(
                            label1: 'Да',
                            label2: 'Нет',
                            onPressed: (bool isFirstSelected) {
                              // Пишите здесь код, который будет выполняться при выборе одной из кнопок
                              if (isFirstSelected) {
                                someMap["dizziness"] = "true";
                              } else {
                                someMap["dizziness"] = "false";
                              }
                            },
                          ))),
                  Align(
                      alignment: Alignment.center,
                      child: Text('Есть ли у вас кровотечение?')),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Align(
                          alignment: Alignment.center,
                          child: CustomTriangleToggleButtons(
                            label1: 'Да',
                            label2: 'Нет',
                            onPressed: (bool isFirstSelected) {
                              // Пишите здесь код, который будет выполняться при выборе одной из кнопок
                              if (isFirstSelected) {
                                someMap["bleeding"] = "true";
                              } else {
                                someMap["bleeding"] = "false";
                              }
                            },
                          ))),
                  Align(
                      alignment: Alignment.center,
                      child: Text('Есть ли у вас тошнота и рвота?')),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Align(
                          alignment: Alignment.center,
                          child: CustomTriangleToggleButtons(
                            label1: 'Да',
                            label2: 'Нет',
                            onPressed: (bool isFirstSelected) {
                              // Пишите здесь код, который будет выполняться при выборе одной из кнопок
                              if (isFirstSelected) {
                                someMap["nausea"] = "true";
                              } else {
                                someMap["nausea"] = "false";
                              }
                            },
                          ))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            writeData(userID, someMap, context);
                          },
                          child: Text(
                            'Отправить форму',
                          ),
                          style: Theme.of(context).outlinedButtonTheme.style)),
                ],
              ))),
    );
  }

  Future<void> writeData(
      String patientId, Map data, BuildContext context) async {
    try {
      bool alarmingSymptoms = false;
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(patientId);

      // Обновляем поля документа с помощью метода update
      await documentReference.update({'status': '12 часов после операции'});
      data["painIntensity"] = (selectedCondition + 1).toString();
      data["condition"] = (selectedPain + 1).toString();

      if (data["dizziness"] == "true" ||
          data["nausea"] == true ||
          data["bleeding"] == "true" ||
          _temperature > 40 ||
          data["condition"] == "5" ||
          data["painIntensity"] == "5" ||
          data["painIntensity"] == "5") {
        alarmingSymptoms = true;
        await documentReference.update({'morningForm': data});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GratitudePage(
                      isMorning: true,
                      alarmingSymptoms: alarmingSymptoms,
                    )));
      } else {
        if (data["dizziness"] == "true" ||
            data["nausea"] == true ||
            data["bleeding"] == "true" ||
            _temperature > 40 ||
            data["condition"] == "5" ||
            data["painIntensity"] == "5" ||
            data["painIntensity"] == "5") {
          alarmingSymptoms = true;
        }
        await documentReference.update({'eveningForm': data});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GratitudePage(
                      isMorning: false,
                      alarmingSymptoms: alarmingSymptoms,
                    )));
      }
    } catch (e) {
      print('Ошибка при обновлении поля документа: $e');
    }
  }

  void _incrementTemperature(double delta) {
    setState(() {
      _temperature += delta;
      _controller.text = _temperature.toStringAsFixed(1);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleToggleButtonsIndexChangedSmiles(int index) {
    setState(() {
      step += 1;
      selectedCondition = index;
    });
  }

  void handleToggleButtonsIndexChangedNumbers(int index) {
    setState(() {
      step += 1;
      // Делайте что-то с индексом, если нужно
      selectedPain = index;
    });
  }

  void handleSmileyButtonPressed(int index) {
    setState(() {
      step += 1;
      feelingStates[index] =
          !feelingStates[index]; // Инвертируем значение в массиве
    });
  }

  Future<bool?> showMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Недопустимое значение"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Возвращает true, если пользователь выбрал "Да"
              },
              child: Text('Ок'),
            ),
          ],
        );
      },
    );
  }
}
