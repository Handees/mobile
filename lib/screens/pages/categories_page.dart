import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/home_screen/service_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          //widthFactor: 0.85,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: HandeeColors.grey237,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        label: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.search,
                                color: HandeeColors.grey141,
                              ),
                              Text('Search'),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: HandeeColors.grey161,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Categories(),
              const SizedBox(height: 40),
              const Categories(),
              const SizedBox(height: 40),
              const Categories(),
              const SizedBox(height: 40),
              const Categories(),
              const SizedBox(height: 40),
              const Categories(),
              const SizedBox(height: 40),
              const Categories(),
              const SizedBox(height: 40),
              const Categories(),
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
    HandeeIcons.laundry,
    size: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: 5),
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
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ServiceCard(),
              );
            },
          ),
        ),
      ],
    );
  }
}
