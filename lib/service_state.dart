import 'package:flutter/material.dart';
import 'package:handees/res/shapes.dart';

enum ServiceState {
  confirmed,
  ongoing,
  completed,
  canceled,
}

class ServiceStateWidget extends StatelessWidget {
  const ServiceStateWidget.confirmed({Key? key})
      : color = Colors.blue,
        label = 'Confirmed',
        textColor = Colors.white,
        super(key: key);

  const ServiceStateWidget.ongoing({Key? key})
      : color = Colors.green,
        label = 'Confirmed',
        textColor = Colors.white,
        super(key: key);

  const ServiceStateWidget.completed({Key? key})
      : color = Colors.black,
        label = 'Completed',
        textColor = Colors.white,
        super(key: key);

  ServiceStateWidget.canceled({Key? key})
      : color = Color.fromARGB(255, 201, 200, 200),
        label = 'Canceled',
        textColor = Color.fromARGB(255, 105, 105, 105),
        super(key: key);

  final Color color;
  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      decoration: ShapeDecoration(
        shape: Shapes.mediumShape,
        color: color,
      ),
      child: Text(label),
    );
  }
}
