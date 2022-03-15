import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';

class TopSearched extends StatelessWidget {
  const TopSearched({Key? key}) : super(key: key);

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

    categories.sort();

    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Column(
        children: [
          Row(
            //direction: Axis.horizontal,
            children: [
              SearchItem(categories.items[5]),
              const SizedBox(width: 10),
              SearchItem(categories.items[3]),
              const SizedBox(width: 10),
              SearchItem(categories.items[1]),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            //direction: Axis.horizontal,
            children: [
              SearchItem(categories.items[2]),
              const SizedBox(width: 10),
              SearchItem(categories.items[0]),
              const SizedBox(width: 10),
              SearchItem(categories.items[4]),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  const SearchItem(
    this.name, {
    Key? key,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: name.length,
      child: InkWell(
        onTap: () => print('Launch ${name}'),
        child: Container(
          alignment: Alignment.center,
          //width: 150,
          height: 40,
          color: HandeeColors.transparent,
          child: Text(
            name,
            style: const TextStyle(color: HandeeColors.blue),
          ),
        ),
      ),
    );
  }
}

class Categories {
  Categories(this.items);

  List<String> items;

  List<String> sort() {
    items.sort((a, b) => a.length.compareTo(b.length));
    print(items);
    return items;
  }
}
