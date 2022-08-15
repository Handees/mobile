import 'package:flutter/material.dart';

import 'package:handees/res/shapes.dart';
import 'package:handees/utils/widgets/custom_delegate.dart';

import 'pick_service_bottom_sheet.dart';
import 'service_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Scaffold(
        drawer: const Drawer(),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.only(
            bottom: horizontalPadding,
            left: horizontalPadding,
            right: horizontalPadding,
          ),
          child: SearchWidget(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CustomScrollView(
              clipBehavior: Clip.none,
              slivers: [
                SliverAppBar(
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Hello Barbara',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Let\'s give you a hand',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 8),
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
                      height: 64.0,
                      child: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        decoration: ShapeDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: Shapes.bigShape,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            border: InputBorder.none,
                          ),
                          cursorColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
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
                                builder: (sheetCtx) {
                                  return PickServiceBottomSheet();
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
      color: Theme.of(context).colorScheme.primary,
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        textController.clear();
                      },
                      icon: const Icon(Icons.cancel),
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
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const Spacer(flex: 2),
                      const CircleAvatar(
                        child: Icon(Icons.search),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
