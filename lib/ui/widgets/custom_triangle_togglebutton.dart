import 'package:flutter/material.dart';

class CustomTriangleToggleButtons extends StatefulWidget {
  final String label1;
  final String label2;
  final Function(bool) onPressed;

  const CustomTriangleToggleButtons({
    Key? key,
    required this.label1,
    required this.label2,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CustomTriangleToggleButtonsState createState() =>
      _CustomTriangleToggleButtonsState();
}

class _CustomTriangleToggleButtonsState
    extends State<CustomTriangleToggleButtons> {
  bool _isFirstSelected = false;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [_isFirstSelected, !_isFirstSelected],
      borderRadius: BorderRadius.circular(10),
      borderColor: Colors.grey,
      selectedColor: Color.fromARGB(255, 3, 21, 140),
      focusColor: Color.fromARGB(167, 42, 63, 200),
      selectedBorderColor: Colors.black,
      onPressed: (int newIndex) {
        setState(() {
          _isFirstSelected = newIndex == 0;
          widget.onPressed(_isFirstSelected);
        });
      },
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(widget.label1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(widget.label2),
        ),
      ],
    );
  }
}
