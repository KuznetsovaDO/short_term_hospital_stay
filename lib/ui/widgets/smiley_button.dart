import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmileyButton extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final String iconNumber;
  final Color selectedColor;
  final Color selectedBorderColor;
  final bool isSelected;
  final bool isSmiles;

  const SmileyButton({
    Key? key,
    required this.color,
    required this.selectedColor,
    required this.iconNumber,
    required this.borderColor,
    required this.selectedBorderColor,
    required this.isSelected,
    this.isSmiles = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth / 7;
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? selectedBorderColor : borderColor,
            width: isSelected ? 4 : 1,
          ),
        ),
        child: isSmiles
            ? Image.asset('assets/images/smile' + iconNumber + '.png')
            : Text(
                iconNumber,
                textAlign: TextAlign.center,
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 20,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ));
  }
}
