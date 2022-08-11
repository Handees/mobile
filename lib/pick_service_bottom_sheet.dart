import 'package:flutter/material.dart';
import 'package:handees/home_page.dart';

class PickServiceBottomSheet extends StatelessWidget {
  const PickServiceBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.orange,
            ),
          ),
          ServiceCard(
            serviceName: 'Hair Stylist',
            icon: Icon(Icons.abc),
            iconBackground: Colors.orange,
            artisanCount: 13,
          ),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.error_outline),
              hintText:
                  'Additional information e.g ‘this is the hair style I want...’',
              fillColor: Colors.orange,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Proceed'),
            ),
          ),
        ],
      ),
    );
  }
}
