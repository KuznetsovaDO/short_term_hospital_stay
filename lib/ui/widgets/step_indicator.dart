import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        // Определяем цвет и стиль для каждого шага
        Color color = index + 1 <= currentStep
            ? Color.fromARGB(255, 0, 67, 235)
            : Colors.grey;
        FontWeight fontWeight =
            index + 1 == currentStep ? FontWeight.bold : FontWeight.normal;

        return Row(
          children: [
            // Круглый контейнер с цифрой шага
            Container(
              margin: EdgeInsets.all(7),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 1),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: fontWeight,
                  ),
                ),
              ),
            ),
            // Разделитель только если не последний шаг
            if (index != 4)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Container(
                  width: MediaQuery.of(context).size.width / 30,
                  height: 1,
                  color: Colors.grey,
                ),
              )
          ],
        );
      }),
    ));
  }
}
