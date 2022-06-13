import 'package:flutter/material.dart';

import 'package:handee/utils/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/home_screen/service_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
                cursorColor: HandeeColors.grey161,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: const Categories(),
            );
          }, childCount: 3)),
        ],
      ),
    );

    SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          //widthFactor: 0.85,
          child: Column(
            children: [
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
