import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Platform.isIOS
          ? CupertinoAlertDialog(
              content: Container(
                width: 382,
                height: 301,
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                        "  Kindly confirm the amount received for your service"),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '₦7,500',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 0.32,
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Done',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Cabin',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: 0.32,
                    ),
                  ),
                ),
              ],
            )
          : AlertDialog(
              content: Container(
                width: 382,
                height: 301,
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/Hands Cash.png"),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Kindly confirm the amount received for your service"),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        '₦7,500',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: 0.32,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Done',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: 0.32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    },
  );
}
