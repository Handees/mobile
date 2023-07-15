import 'package:flutter/material.dart';


class EditProfileOptions extends StatelessWidget
{
  const EditProfileOptions({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            SizedBox(
              height: 10,
              child: GestureDetector(
                onTap: () { Navigator.pop(context) ;},
                child: const Icon(Icons.arrow_back)
              ),
            )
          ],)
        ),
      )
    );
  }
}
