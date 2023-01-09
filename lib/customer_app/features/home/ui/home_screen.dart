import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
import 'package:google_maps_flutter/google_maps_flutter.dart';
=======
import 'package:handees/customer_app/features/auth/providers/auth_provider.dart';
>>>>>>> e1ea510b942263af873e653f3495dbb6d9028841
import 'package:handees/customer_app/features/home/providers/home_provider.dart';
import 'package:handees/customer_app/features/test/test.dart';
import 'package:handees/customer_app/features/tracker/ui/tracking_screen.dart';
import 'package:handees/customer_app/services/auth_service.dart';

import 'package:handees/res/shapes.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/shared/widgets/circle_fadeout_loader.dart';
import 'package:handees/theme/theme.dart';
import 'package:handees/shared/widgets/custom_delegate.dart';
// import 'package:http/http.dart';

import 'location_picker.dart';
import 'pick_service_bottom_sheet.dart';
import 'service_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const horizontalPadding = 16.0;
    // const drawerItemHeight = 56.0;

    final authModel = ref.watch(authProvider.notifier);
    final submitStatus = ref.watch(userDataStatusProvider);

    final name = ref.watch(nameProvider);
    final categories = ref.watch(categoryProvider);
    Function focusNodeCallback = () {};

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());

        focusNodeCallback();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Scaffold(
          // backgroundColor: Theme.of(context).colorScheme.background,
          drawer: Drawer(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      DrawerHeader(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(CustomerAppRoutes.profile),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AuthService.instance.user.photoURL != null
                                    ? CircleAvatar(
                                        radius: 28,
                                        backgroundImage: NetworkImage(
                                          AuthService.instance.user.photoURL!,
                                        ),
                                      )
                                    : Container(
                                        height: 48,
                                        width: 48,
                                        decoration: ShapeDecoration(
                                          shape: CircleBorder(),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                        child: Icon(Icons.account_circle),
                                      ),
                                const SizedBox(width: 16.0),
                                Text(
                                  name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    debugPrint("Swap button pressed");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: const EdgeInsets.all(5),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  child: const Icon(
                                    Icons.swap_horiz,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.credit_card),
                        title: const Text('Payments'),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(CustomerAppRoutes.history),
                        leading: const Icon(Icons.history),
                        title: const Text('History'),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(CustomerAppRoutes.settings),
                        leading: const Icon(Icons.settings_outlined),
                        title: const Text('Settings'),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.support_agent),
                        title: const Text('Customer Support'),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const Test();
                            },
                          ));
                        },
                        leading: const Icon(Icons.handyman),
                        title: const Text('Test'),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          AuthService.instance.signoutUser();
                        },
                        leading: const Icon(Icons.help_outline_outlined),
                        title: const Text('FAQ'),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            style: Theme.of(context)
                                .extension<ButtonThemeExtensions>()
                                ?.filled,
                            onPressed: () {},
                            child: const Text(
                              'Become a Handee Man',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              bottom: horizontalPadding,
              left: horizontalPadding,
              right: horizontalPadding,
            ),
            child: SearchWidget((callback) {
              focusNodeCallback = callback;
            }),
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(CustomerAppRoutes.notifications);
                      },
                      icon: const Icon(Icons.notifications_outlined),
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
                        const SizedBox(height: 8),
                        Text(
                          'Hello $name',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                  ),
                  sliver: SliverPersistentHeader(
                    // pinned: true,
                    floating: true,
                    delegate: CustomDelegate(
                      height: 64.0,
                      child: const LocationPicker(),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomDelegate(
                    height: 144.0,
                    shape: const RoundedRectangleBorder(),
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        return const OngoingServiceHeader(
                          horizontalPadding: horizontalPadding,
                        );
                      },
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
                                    child: PickServiceBottomSheet(
                                        categories[index]),
                                  );
                                });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: horizontalPadding,
                            ),
                            child: ServiceCard(
                              artisanCount: 12,
                              icon: Icon(
                                categories[index].icon,
                                color: Colors.white,
                              ),
                              iconBackground: categories[index].foregroundColor,
                              serviceName: categories[index].name,
                            ),
                          ),
                        );
                      },
                      childCount: categories.length,
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

class OngoingServiceHeader extends StatelessWidget {
  const OngoingServiceHeader({
    Key? key,
    required this.horizontalPadding,
  }) : super(key: key);

  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ongoing Handee',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '00 : 03 : 43',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        const Spacer(flex: 1),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: const ProgressCard(),
        ),
        const Spacer(flex: 3),
        const Divider(
          thickness: 8.0,
          height: 0.0,
        ),
      ],
    );
  }
}

class SearchWidget extends StatefulWidget {
  final callback;
  const SearchWidget(this.callback, {Key? key}) : super(key: key);

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
    widget.callback(() => setState(
          () => isFocused = false,
        ));
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
                    filled: false,
                    suffixIcon: IconButton(
                      onPressed: () {
                        textController.clear();
                      },
                      icon: Icon(
                        Icons.close,
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
