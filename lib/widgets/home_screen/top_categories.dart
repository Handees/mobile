import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  final Color color = HandeeColors.transparent;
  final Color textColor = HandeeColors.blue;

  @override
  Widget build(BuildContext context) {
    final categories = Categories([
      'Gardening',
      'Dry Cleaning',
      'Car',
      'Laundromat',
      'Cable',
      'House Keeping',
    ]);

    categories.Sort();

    return Container(
      width: double.infinity,
      height: 100,
      child: Column(
        children: [
          Row(
            //direction: Axis.horizontal,
            children: [
              InkWell(
                onTap: () => print('Launch ${categories.items[5]}'),
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 40,
                  color: color,
                  child: Text(
                    categories.items[5],
                    style: const TextStyle(
                      color: HandeeColors.blue
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => print('Launch ${categories.items[3]}'),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 40,
                  color: color,
                  child: Text(
                    categories.items[3],
                    style: const TextStyle(
                        color: HandeeColors.blue
                    ),
                  ),

                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => print('Launch ${categories.items[1]}'),
                child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 40,
                  color: color,
                  child: Text(
                    categories.items[1],
                    style: const TextStyle(
                        color: HandeeColors.blue
                    ),
                  ),

                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            //direction: Axis.horizontal,
            children: [
              InkWell(
                onTap: () => print('Launch ${categories.items[2]}'),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 40,
                  color: color,
                  child: Text(
                    categories.items[2],
                    style: const TextStyle(
                        color: HandeeColors.blue
                    ),
                  ),

                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => print('Launch ${categories.items[0]}'),
                child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 40,
                  color: color,
                  child: Text(
                    categories.items[0],
                    style: const TextStyle(
                        color: HandeeColors.blue
                    ),
                  ),

                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => print('Launch ${categories.items[4]}'),
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 40,
                  color: color,
                  child: Text(
                    categories.items[4],
                    style: const TextStyle(
                        color: HandeeColors.blue
                    ),
                  ),

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Categories {
  Categories(this.items);

  List<String> items;

  List<String> Sort() {
    items.sort((a, b) => a.length.compareTo(b.length));
    print(items);
    return items;
  }
}
