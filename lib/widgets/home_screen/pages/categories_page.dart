import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/home_screen/service_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          //widthFactor: 0.85,
          child: Column(
            children: [
              const SizedBox(height: 80),
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: HandeeColors.grey237,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                      cursorColor: HandeeColors.grey161,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Categories(),
              const SizedBox(height: 40),
              Categories(),
              const SizedBox(height: 40),
              Categories(),
              const SizedBox(height: 40),
              Categories(),
              const SizedBox(height: 40),
              Categories(),
              const SizedBox(height: 40),
              Categories(),
              const SizedBox(height: 40),
              Categories(),
            ],
          ),
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  final String name = 'Laundry';
  final Icon icon = const Icon(
    HandeeIcons.washing_machine,
    size: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                textScaleFactor: 1.1,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 5),
              icon,
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: 15,
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ServiceCard(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
