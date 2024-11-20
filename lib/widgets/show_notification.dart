import 'package:flutter/material.dart';

class ShowNotification {
  static void show(
      {required BuildContext context,
      required String message,
      required bool isSuccess,
      Duration duration = const Duration(seconds: 2)}) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            bottom: 20,
            right: 20,
            child: Material(
                color: Colors.transparent,
                child: _Notification(isSuccess: isSuccess, message: message))));

    // Вставляем OverlayEntry в наш Overlay
    overlay.insert(overlayEntry);

    // Удаляем слои OverlayEntry c экрана
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

class _Notification extends StatelessWidget {
  final bool isSuccess;
  final String message;

  _Notification({required this.isSuccess, required this.message});

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    Color backgroundColor = isSuccess ? Colors.green : Colors.red;
    IconData icon = isSuccess ? Icons.check : Icons.close;

    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(message, style: TextStyle(color: color))
          ],
        ));
  }
}
