import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Stack using to show how to overlap
    // Stack-size
    return Stack(
      children: [
        Container(
          width: 500,
          height: 500,
          color: Colors.blue,
        ),
        Positioned(
            top: 30,
            left: 30,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            )),
        Positioned(
            top: 13,
            left: 13,
            child: Text('Busser is shit',
                style: TextStyle(
                    fontSize: 12,
                    color: const Color.fromARGB(255, 236, 189, 120)))),
        Positioned(
            bottom: 100,
            right: 100,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Карточка с elevation 4'),
              ),
            ))
      ],
    );
  }
}
