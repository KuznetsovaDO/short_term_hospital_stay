import 'package:flutter/material.dart';

class AdressPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Информация"),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  Navigator.pop(context, true);
                })),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text("СКП (стационар кратковременного пребывания)"),
                    Text("+7 (495) 136-22-68"),
                    Text(
                        "Понедельник-пятница: 9:00-16:00 \n(кроме 4-й пятницы каждого месяца и праздничных дней)")
                  ],
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: Text("Как пройти в СКП")),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    Image(image: AssetImage('assets/images/enter_SKP.gif'))
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                            "От м.Кантемировская Первый вагон из центра, выход из метро №3, далее на автобусе е80 или с891 до остановки \"Больница им.Буянова\"")),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    Image(image: AssetImage('assets/images/kantem-mini.png'))
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                            "От м.Царицыно \nПервый вагон из центра, выход из метро №1, далее на автобусе с869 до остановки \Больница им.Буянова ")),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    Image(image: AssetImage('assets/images/caric-mini.png'))
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
