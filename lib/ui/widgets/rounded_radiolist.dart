import 'package:flutter/material.dart';

class RoundedRadioList extends StatefulWidget {
  final Future<List<RoundedRadioItem>> items;
  final void Function(int)? onChanged;

  RoundedRadioList({required this.items, this.onChanged});

  @override
  _RoundedRadioListState createState() => _RoundedRadioListState();
}

class _RoundedRadioListState extends State<RoundedRadioList> {
  int? selected;
  List<RoundedRadioItem> _radioItems =
      []; // Создаем переменную для хранения списка элементов радио

  @override
  void initState() {
    super.initState();
    // В методе initState ждем разрешения Future и заполняем список элементов радио
    widget.items.then((items) {
      setState(() {
        _radioItems = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _radioItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return ListTile(
          // leading: ClipRRect(
          //   borderRadius: BorderRadius.circular(30),
          //   child: Image.network(
          //     item.imageUrl,
          //     width: 50,
          //     height: 50,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.lastname),
              Text(
                item.name,
                style: TextStyle(
                  fontSize: 12, // или любой другой размер
                  color: Colors.grey, // или любой другой цвет
                ),
              ),
            ],
          ),
          trailing: Radio<int>(
            value: index,
            groupValue: selected,
            onChanged: (value) {
              setState(() {
                selected = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value!);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}

class RoundedRadioItem {
  final String lastname;
  final String name;
  final String imageUrl;

  RoundedRadioItem(
      {required this.lastname, required this.name, required this.imageUrl});
}
