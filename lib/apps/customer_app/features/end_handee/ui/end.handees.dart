import 'package:flutter/material.dart';

class EndHandees extends StatefulWidget {
  const EndHandees({super.key});

  @override
  State<EndHandees> createState() => _EndHandeesState();
}

class _EndHandeesState extends State<EndHandees> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              const Text(
                'In progress',
                style: TextStyle(
                  color: Color(0xFF14161C),
                  fontSize: 18,
                  fontFamily: 'Cabin',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              Container(
                width: 366,
                height: 264,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
