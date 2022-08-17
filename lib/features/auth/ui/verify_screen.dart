import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/theme/theme.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = authTheme;
    final verticalMargin = 24.0;

    return Theme(
      data: themeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Verify Phone'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: Column(
            children: [
              Text('Code has been sent to *** ***68'),
              SizedBox(height: verticalMargin),
              Container(
                width: double.infinity,
                // color: Colors.orange,
                height: 48,
                child: TextField(
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: verticalMargin),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Didn\'t get code? '),
                  InkWell(
                    onTap: () {},
                    child: Text('Request again'),
                  ),
                ],
              ),
              SizedBox(height: verticalMargin),
              Text('Get via call'),
              SizedBox(height: verticalMargin),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.home),
                  style: themeData.extension<ButtonThemeExtensions>()?.filled,
                  child: Text('Verify and Create Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
