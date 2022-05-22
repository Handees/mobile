import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/home_screen/top_rated_card.dart';
import 'package:handee/widgets/home_screen/top_searched.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.account_circle,
                size: 30,
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 35),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Hi\n$username',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(height: 35),
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const TextField(
                  //autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                  ),
                  cursorColor: HandeeColors.grey161,
                ),
              ),
              const SizedBox(height: 45),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Top searched',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              const TopSearched(),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top rated',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    children: const [
                      Text('See all'),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemBuilder: (ctx, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TopRatedCard(),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
