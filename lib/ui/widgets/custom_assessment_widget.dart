import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAssessmentWidget extends StatefulWidget {
  final int initialSelectedIndex;

  final Function(int) onSelectedIndexChangedNumbers;

  const CustomAssessmentWidget({
    Key? key,
    this.initialSelectedIndex = 1,
    required this.onSelectedIndexChangedNumbers,
  }) : super(key: key);

  @override
  _CustomAssessmentWidgetState createState() => _CustomAssessmentWidgetState();
}

int endSelected = 0;
int endSelectedIfNums = 0;

class _CustomAssessmentWidgetState extends State<CustomAssessmentWidget> {
  int selectedIndex = 1;

  double paddingForSmile = 8;

  List<String> ImagePaths = [
    'assets/images/smile1.png',
    'assets/images/smile2.png',
    'assets/images/smile3.png',
    'assets/images/smile4.png',
    'assets/images/smile5.png',
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = MediaQuery.of(context).size.width / 8;
    double paddingForButton = buttonSize / 8;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
            alignment: Alignment.center,
            child: ToggleButtons(
                fillColor: Color.fromARGB(0, 0, 0, 0),
                splashColor: Color.fromARGB(0, 0, 0, 0),
                direction: Axis.horizontal,
                borderRadius: BorderRadius.circular(10),
                renderBorder: false,
                isSelected: List.generate(5, (index) => index == selectedIndex),
                children: [
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: paddingForButton),
                      width: buttonSize,
                      height: buttonSize,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(paddingForSmile),
                      child: Text(
                        '1',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red.shade200,
                          border: Border.all(
                            width: selectedIndex == 0 ? 2 : 0.5,
                            color: selectedIndex == 0
                                ? Color.fromARGB(237, 218, 0, 0)
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0))),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: paddingForButton),
                      width: buttonSize,
                      height: buttonSize,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(paddingForSmile),
                      child: Text(
                        '2',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          border: Border.all(
                            width: selectedIndex == 1 ? 2 : 0.5,
                            color: selectedIndex == 1
                                ? Color.fromARGB(255, 214, 93, 0)
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0))),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: paddingForButton),
                      width: buttonSize,
                      height: buttonSize,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(paddingForSmile),
                      child: Text(
                        '3',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade100,
                          border: Border.all(
                            width: selectedIndex == 2 ? 2 : 0.5,
                            color: selectedIndex == 2
                                ? Color.fromARGB(255, 236, 200, 0)
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0))),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: paddingForButton),
                      width: buttonSize,
                      height: buttonSize,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(paddingForSmile),
                      child: Text(
                        '4',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          border: Border.all(
                            width: selectedIndex == 3 ? 2 : 0.5,
                            color: selectedIndex == 3
                                ? Color.fromARGB(255, 33, 181, 0)
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0))),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: paddingForButton),
                      width: buttonSize,
                      height: buttonSize,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(paddingForSmile),
                      child: Text(
                        '5',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          border: Border.all(
                            width: selectedIndex == 4 ? 2 : 0.5,
                            color: selectedIndex == 4
                                ? Color.fromARGB(255, 25, 134, 0)
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0))),
                ],
                onPressed: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  {
                    widget.onSelectedIndexChangedNumbers(index);
                  } // Вызываем обратный вы
                })));
  }
}
