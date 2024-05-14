import 'package:flutter/material.dart';
import 'after_discharged_page.dart';
import 'state_change_form.dart';

class HistoryPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/stars.png',
                height: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18, bottom: 20),
              child: Text(
                'Спасибо!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
                'Мы успешно получили Вашу форму. Ваши ответы будут видны только врачу.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  style: Theme.of(context).outlinedButtonTheme.style,
                  child: Text(
                    'Далее',
                  ),
                )),
            ElevatedButton(
              onPressed: () {},
              child: Text('Позвонить 112'),
            )
          ],
        ),
      )),
    );
  }
}
