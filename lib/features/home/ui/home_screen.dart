import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handees/features/test/test.dart';

import 'package:handees/res/shapes.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/theme/theme.dart';
import 'package:handees/utils/widgets/custom_delegate.dart';
// import 'package:http/http.dart';

import 'pick_service_bottom_sheet.dart';
import 'service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;
    const drawerItemHeight = 56.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.profile),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Barbara',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'Edit profile',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.history),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  height: drawerItemHeight,
                  child: Text(
                    'History',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.settings),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  height: drawerItemHeight,
                  child: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  height: drawerItemHeight,
                  child: Text(
                    'Customer Support',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return Test();
                    },
                  ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  height: drawerItemHeight,
                  child: Text(
                    'Test',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  height: drawerItemHeight,
                  child: Text(
                    'F.A.Q',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: Theme.of(context)
                        .extension<ButtonThemeExtensions>()
                        ?.filled,
                    onPressed: () {},
                    child: Text(
                      'Become a Handee Man',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.only(
            bottom: horizontalPadding,
            left: horizontalPadding,
            right: horizontalPadding,
          ),
          child: SearchWidget(),
        ),
        body: SafeArea(
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverAppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.notifications);
                    },
                    icon: const Icon(Icons.notifications_outlined),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Hello Barbara',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Let\'s give you a hand',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomDelegate(
                    height: 80.0,
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: ShapeDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: Shapes.bigShape,
                      ),
                      child: TextSelectionTheme(
                        data: TextSelectionThemeData(
                          cursorColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          selectionColor: Colors.orange,
                          selectionHandleColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        child: TextField(
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 8.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (sheetCtx) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(sheetCtx)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: PickServiceBottomSheet(),
                                );
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: horizontalPadding,
                          ),
                          child: ServiceCard(
                            artisanCount: 12,
                            icon: Icon(Icons.abc),
                            iconBackground: Colors.orange,
                            serviceName: 'Laundry',
                          ),
                        ),
                      );
                    },
                    childCount: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final focusNode = FocusNode();
  final textController = TextEditingController();
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 32.0,
    );
    return Material(
      elevation: 4.0,
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: Shapes.bigShape,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64.0),
        child: isFocused
            ? Padding(
                padding: padding,
                child: TextField(
                  focusNode: focusNode,
                  controller: textController,
                  onEditingComplete: () {
                    setState(() {
                      isFocused = false;
                      focusNode.unfocus();
                    });
                  },
                  cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        textController.clear();
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    isFocused = true;
                    focusNode.requestFocus();
                  });
                },
                customBorder: Shapes.bigShape,
                child: Padding(
                  padding: padding,
                  child: Row(
                    children: [
                      const Spacer(flex: 5),
                      Expanded(
                        flex: 9,
                        child: Text(
                          'Need a hand?',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                        ),
                      ),
                      const Spacer(flex: 2),
                      Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class TrackerBottomSheet extends StatelessWidget {
  const TrackerBottomSheet({Key? key}) : super(key: key);

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
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          const ServiceCard(
            serviceName: 'Hair Stylist',
            icon: const Icon(Icons.abc),
            iconBackground: Colors.orange,
            artisanCount: 13,
          ),
          Text(
            'While you wait, you can reach out to them to'
            'confirm the  details of the service you need.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Call'),
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.filled,
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Message'),
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.tonal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
