import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';

class NotificationWidget extends StatelessWidget {
  NotificationWidget({Key? key}) : super(key: key);

  final isBlue = true; //TODO: find out why

  final message = RichText(
    text: const TextSpan(
      children: [
        TextSpan(
          text: 'The Heat Cleaners ',
          style: TextStyle(color: HandeeColors.blue),
        ),
        TextSpan(
          text: 'are on their way to you!',
          style: TextStyle(color: HandeeColors.black),
        ),
      ],
    ),
    textScaleFactor: 0.9,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 85,
          width: double.infinity,
          color: isBlue ? HandeeColors.lightBlue : HandeeColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.insert_emoticon),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: message,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12, right: 25),
                  child: Text('Time', textScaleFactor: 0.7,),
                ),
              )
            ],
          ),
        ),
        if (isBlue) SizedBox(height: 2),
        if (!isBlue)
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Container(
                height: 0.5,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 0.75),
                color: HandeeColors.grey161),
          ),
      ],
    );
  }
}
