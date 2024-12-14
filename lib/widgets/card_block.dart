import 'package:flutter/material.dart';
import 'package:flutter_proj/services/card_database.dart';
import '../models/word_card.dart';
import 'delete_card_btn.dart';

class CardBlock extends StatelessWidget {
  // TODO:
  // 1. Create GestureDetector onLongTap (edit card menu), onTap (overlay btn openmenu), onDoubleTap (edit card menu)
  final WordCard card;
  final VoidCallback onDelete;
  final TextStyle style = TextStyle(fontSize: 20);

  CardBlock({required this.card, required this.onDelete});

  Future onTap() async {
    await CardDatabase.instance.deleteCard(card);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(60, 99, 99, 99),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: Color.fromARGB(133, 72, 72, 72), width: 1.3)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 14, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(card.first, style: style),
                  SizedBox(height: 5),
                  Text(card.second, style: style)
                ],
              ),
              DeleteButton(
                onTap: onDelete,
              )
            ],
          ),
        ));
  }
}
