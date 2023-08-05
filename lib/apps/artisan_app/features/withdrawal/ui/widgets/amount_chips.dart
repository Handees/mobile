import 'package:flutter/material.dart';

class AmountChips extends StatefulWidget {
  const AmountChips({super.key});

  @override
  State<AmountChips> createState() => _AmountChipsState();
}

class _AmountChipsState extends State<AmountChips> {
  int? selectedIndex;
  final choices = <String>[
    'N20,000',
    'N50,000',
    'N100,000',
    'N200,000',
    'N250,000',
    'N500,000',
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        children: List.generate(
          6,
          (int index) {
            return InputChip(
              showCheckmark: false,
              label: Text(choices[index]),
              labelStyle: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
              ),
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              onSelected: (bool selected) {
                setState(() {
                  selectedIndex = selected ? index : -1;
                });
              },
              selected: selectedIndex == index,
              backgroundColor: const Color(0xff14161c).withOpacity(0.15),
              selectedColor: const Color(0xff14161c),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            );
          },
        ),
      ),
    );
  }
}
