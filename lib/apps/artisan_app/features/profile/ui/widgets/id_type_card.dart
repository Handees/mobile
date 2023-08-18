import 'package:flutter/material.dart';

class IDTypeCard extends StatelessWidget {
  const IDTypeCard(this.idType, this.isSelected, {super.key});

  final String idType;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xffa8dadc) : null,
        border: Border.all(
          color: Color(isSelected ? 0xffa8dadc : 0xff14161c),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Text(
        idType,
        style: isSelected
            ? const TextStyle(
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
