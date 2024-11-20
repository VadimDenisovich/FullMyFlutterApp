import 'package:flutter/material.dart';
import '../models/word_card.dart';
import '../services/card_database.dart';
import '../widgets/show_notification.dart';

class AddWord extends StatefulWidget {
  @override
  _AddWordState createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  // TODO:
  // 1. create blue outline for TextFields
  // 2. ElevatedButton: text to white, background to blue
  // 3. Create two notifications: when success and not
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _firstController.dispose();
    _secondController.dispose();
  }

  Widget _createTextField(TextEditingController controller, String hint) {
    return SizedBox(
        width: 300,
        height: 50,
        child: TextField(
          controller: controller,
          decoration:
              InputDecoration(labelText: hint, border: OutlineInputBorder()),
        ));
  }

  void _saveWord(BuildContext context) {
    final firstPart = _firstController.text;
    final secondPart = _secondController.text;
    var card;
    if (firstPart.isNotEmpty && secondPart.isNotEmpty) {
      card = WordCard(
          id: DateTime.now().millisecondsSinceEpoch,
          first: firstPart,
          second: secondPart);
      // Добавляем карточку в бд
      CardDatabase.instance.create(card.toMap());
      ShowNotification.show(
          context: context,
          message: 'Card ${card.id} successfully inserted!',
          isSuccess: true);
      _firstController.clear();
      _secondController.clear();
    } else {
      ShowNotification.show(
          context: context,
          message: 'Please fill all inputs!',
          isSuccess: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget firstPart;
    Widget secondPart;
    firstPart = _createTextField(_firstController, 'Type first part of word');
    secondPart =
        _createTextField(_secondController, 'Type second part of word');

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          firstPart,
          SizedBox(height: 10),
          secondPart,
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                _saveWord(context);
              },
              child: Text('Save')),
        ],
      ),
    ));
  }
}
