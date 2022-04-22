import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';

class NotificationWidget extends StatelessWidget {
  NotificationWidget(
      {Key? key,
      required String message,
      this.leading,
      this.style,
      this.timeStyle,
      this.color = Colors.transparent})
      : super(key: key) {
    this.message = Text(
      message,
      style: style,
    );
  }

  NotificationWidget.delivery({
    Key? key,
    required String agentName,
    this.color = HandeeColors.lightBlue,
    this.leading = const CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Icon(
        HandeeIcons.delivery_truck,
        color: HandeeColors.blue,
      ),
    ),
    this.style,
    this.timeStyle,
  }) : super(key: key) {
    message = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: agentName,
            style: const TextStyle(color: HandeeColors.blue),
          ),
          const TextSpan(
            text: ' are on their way to you!',
            style: TextStyle(color: HandeeColors.black),
          ),
        ],
        style: style,
      ),
    );
  }

  NotificationWidget.schedule({
    Key? key,
    required String agentName,
    this.color = HandeeColors.lightBlue,
    this.leading = const CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Icon(
        HandeeIcons.clock,
        color: HandeeColors.blue,
      ),
    ),
    this.style,
    this.timeStyle,
  }) : super(key: key) {
    message = RichText(
      text: TextSpan(children: [
        const TextSpan(
          text: 'Your schedule service with ',
          style: TextStyle(color: HandeeColors.black),
        ),
        TextSpan(
          text: agentName,
          style: const TextStyle(color: HandeeColors.blue),
        ),
        const TextSpan(
          text: ' is tomorrow',
          style: TextStyle(color: HandeeColors.black),
        ),
      ], style: style),
    );
  }

  NotificationWidget.welcome(
      {Key? key, this.style, this.timeStyle, this.color = Colors.transparent})
      : super(key: key) {
    leading = const CircleAvatar(
      backgroundColor: HandeeColors.grey237,
      foregroundColor: HandeeColors.black,
      child: Icon(HandeeIcons.codesandbox),
    );
    message = RichText(
      text: TextSpan(
        children: const [
          TextSpan(
            text: 'Welcome to ',
            style: TextStyle(color: HandeeColors.blue),
          ),
          TextSpan(
            text: 'Handee',
            style: TextStyle(color: HandeeColors.blue),
          ),
          TextSpan(
            text: ' Barbara.',
            style: TextStyle(color: HandeeColors.black),
          ),
        ],
        style: style,
      ),
    );
  }

  Widget? message;
  Widget? leading;
  TextStyle? style = TextStyle(color: Colors.red);
  final TextStyle? timeStyle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 85,
          width: double.infinity,
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: leading,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: message,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12, right: 25),
                  child: Text(
                    'Time',
                    style: timeStyle,
                  ),
                ),
              )
            ],
          ),
        ),
        if (color == HandeeColors.lightBlue) const SizedBox(height: 2),
        if (color != HandeeColors.lightBlue)
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
