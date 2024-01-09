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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 18.0, top: 18.0),
                child: Text(
                  'In progress',
                  style: TextStyle(
                    color: Color(0xFF14161C),
                    fontSize: 18,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 18.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 18.0, top: 18.0),
                  width: 366,
                  height: 264,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(132, 246, 246, 246),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 62.95,
                            height: 39.90,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage("https://picsum.photos/64/40"),
                            ),
                          ),
                          Text(
                            "Jane Foster",
                            style: TextStyle(
                              color: Color(0xFF939393),
                              fontSize: 16,
                              fontFamily: 'Cabin',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      EndHandeesRows(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/end_handees/fluent_wrench-20-regular.png")),
                          text: "Additional information"),
                      EndHandeesRows(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/end_handees/fluent_payment-24-regular.png")),
                          text: "Card transaction"),
                      EndHandeesRows(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/end_handees/fluent_timer-12-regular.png")),
                          text: "Contract"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Container(
            width: 363,
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            decoration: ShapeDecoration(
              color: const Color(0xFFCC4A4A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'END SERVICE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFDFDFD),
                    fontSize: 16,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: 0.64,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}


class EndHandeesRows extends StatelessWidget {
  final DecorationImage image;
  final String text;
  const EndHandeesRows({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 62.95,
          height: 39.90,
          decoration: BoxDecoration(image: image),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF939393),
            fontSize: 16,
            fontFamily: 'Cabin',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        
      ],
    );
  }
}

