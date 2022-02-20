import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';

class NotificationWidget extends StatelessWidget {
  NotificationWidget({
    Key? key,
    this.message,
    this.leading = const CircleAvatar(
      backgroundColor: HandeeColors.grey237,
      foregroundColor: HandeeColors.black,
      child: Icon(HandeeIcons.codesandbox),
    ),
  }) : super(key: key);

  NotificationWidget.delivery({
    Key? key,
    required String agentName,
  }) : super(key: key) {
    _color = HandeeColors.lightBlue;
    leading = CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Icon(
        HandeeIcons.delivery_truck,
        color: HandeeColors.blue,
      ),
    );
    message = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: agentName,
            style: TextStyle(color: HandeeColors.blue),
          ),
          TextSpan(
            text: ' are on their way to you!',
            style: TextStyle(color: HandeeColors.black),
          ),
        ],
      ),
      textScaleFactor: 0.9,
    );
  }

  NotificationWidget.schedule({
    Key? key,
    required String agentName,
  }) : super(key: key) {
    _color = HandeeColors.lightBlue;
    leading = CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Icon(
        HandeeIcons.clock,
        color: HandeeColors.blue,
      ),
    );
    message = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Your schedule service with ',
            style: TextStyle(color: HandeeColors.black),
          ),
          TextSpan(
            text: agentName,
            style: TextStyle(color: HandeeColors.blue),
          ),
          TextSpan(
            text: ' is tomorrow',
            style: TextStyle(color: HandeeColors.black),
          ),
        ],
      ),
      textScaleFactor: 0.9,
    );
  }

  var message;
  Widget? leading;
  Color _color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 85,
          width: double.infinity,
          color: _color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: leading,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: message,
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12, right: 25),
                  child: Text(
                    'Time',
                    textScaleFactor: 0.7,
                  ),
                ),
              )
            ],
          ),
        ),
        if (_color == HandeeColors.lightBlue) const SizedBox(height: 2),
        if (_color != HandeeColors.lightBlue)
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
                height: 0.5,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 0.75),
                color: HandeeColors.grey161),
          ),
      ],
    );
  }
}
