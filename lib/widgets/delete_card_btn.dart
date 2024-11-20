import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onTap;

  DeleteButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(255, 201, 29, 17),
                  width: 1.5,
                )),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.delete, color: Color.fromARGB(255, 181, 9, 9)),
            )));
  }
}
