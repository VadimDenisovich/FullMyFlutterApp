import 'package:flutter/material.dart';
import '../models/word_card.dart';
import '../services/card_database.dart';
import '../widgets/card_block.dart';
import '../widgets/show_notification.dart';

class ListWords extends StatefulWidget {
  @override
  _ListWordsState createState() => _ListWordsState();
}

class _ListWordsState extends State<ListWords> {
  late List<WordCard> listWords = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _updateDB();
  }

  Future<void> _updateDB() async {
    setState(() {
      isLoading = true;
    });
    listWords = await CardDatabase.instance.getCards();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteDB() async {
    await CardDatabase.instance.clear();
    setState(() {
      isLoading = true;
    });
  }

  Future<void> _deleteCard(WordCard card) async {
    await CardDatabase.instance.deleteCard(card);
    setState(() {
      _updateDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : listWords.isEmpty
                  ? Center(child: Text('No data available'))
                  // ListView.separated
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                      itemCount: listWords.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: CardBlock(
                            card: listWords[index],
                            onDelete: () {
                              _deleteCard(listWords[index]);
                              ShowNotification.show(
                                  context: context,
                                  message:
                                      'Card ${listWords[index].id} successfully deleted!',
                                  isSuccess: true);
                            },
                          ),
                        );
                      }),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _updateDB();
                    },
                    child: Text('Update database')),
                SizedBox(width: 30),
                ElevatedButton(
                    onPressed: () {
                      _deleteDB();
                    },
                    child: Text('Delete database')),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
