import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/widgets/id_type_card.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/widgets/image_upload.dart';
import 'package:handees/theme/theme.dart';

class ValidIDScreen extends StatefulWidget {
  ValidIDScreen({super.key});

  @override
  State<ValidIDScreen> createState() => _ValidIDScreenState();
}

class _ValidIDScreenState extends State<ValidIDScreen> {
  final double horizontalPadding = 16.0;

  final List<String> _idTypes = [
    "National ID",
    "Drivers' License",
    "Voters' Card",
    "International Passport"
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Valid ID",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Please kindly upload any of the valid means of identification specified below",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xff949494)),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: horizontalPadding),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - horizontalPadding,
                height: 40,
                child: ListView.separated(
                  itemCount: _idTypes.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (ctx, idx) => const SizedBox(width: 8.0),
                  itemBuilder: (BuildContext ctx, int index) {
                    return InkWell(
                      onTap: (() {
                        setState(() {
                          _selectedIndex = index;
                        });
                      }),
                      child: IDTypeCard(
                        _idTypes[index],
                        index == _selectedIndex,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 520,
              child: Column(
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  const ImageUpload(),
                  const Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    width: double.infinity,
                    height: 64,
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('Done'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    width: double.infinity,
                    height: 64,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Cancel',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
