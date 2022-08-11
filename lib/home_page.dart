import 'package:flutter/material.dart';
import 'package:handees/pick_service_bottom_sheet.dart';

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
                const SliverAppBar(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Barbara',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Let\'s give you a hand',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
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
                      child: const SizedBox(
                        height: double.infinity,
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
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.zero,
      child: Container(
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
                customBorder: Theme.of(context).cardTheme.shape,
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

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key? key,
    required this.serviceName,
    required this.icon,
    required this.iconBackground,
    required this.artisanCount,
  }) : super(key: key);

  final String serviceName;
  final Widget icon;
  final Color iconBackground;
  final int artisanCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 96,
      width: double.infinity,
      child: Row(
        children: [
          Ink(
            decoration: BoxDecoration(
              color: iconBackground.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24.0),
            ),
            height: 72,
            width: 72,
            child: Center(
              child: CircleAvatar(
                backgroundColor: iconBackground,
                child: icon,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Laundry',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '$artisanCount Handeemen near you',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  CustomDelegate({
    required this.height,
    required this.child,
  });

  final double height;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4.0,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
