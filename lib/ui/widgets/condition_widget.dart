import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:short_term_hospital_stay/ui/widgets/smiley_button.dart';

class ConditionWidget extends StatefulWidget {
  const ConditionWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ConditionWidgetState createState() => _ConditionWidgetState();
}

int endSelected = 0;
int endSelectedIfNums = 0;

class _ConditionWidgetState extends State<ConditionWidget> {
  int selectedIndex = 0;
  double buttonSize = 60;
  double paddingForSmile = 8;

  List<String> ImagePaths = [
    'assets/images/smile1.png',
    'assets/images/smile2.png',
    'assets/images/smile3.png',
    'assets/images/smile4.png',
    'assets/images/smile5.png',
  ];

  @override
  Widget build(BuildContext context) {
    // double buttonSize = MediaQuery.of(context).size.width / 10;
    // double paddingForButton = buttonSize / 20;
    return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: []));
  }
}
