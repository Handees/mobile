import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:handees/res/shapes.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Notifications'),
        //   centerTitle: true,
        //   bottom: TabBar(
        //     indicatorSize: TabBarIndicatorSize.label,
        //     tabs: [
        //       Tab(
        //         child: Text(
        //           'All',
        //           style: Theme.of(context).textTheme.bodyMedium,
        //         ),
        //       ),
        //       Tab(
        //         child: Text(
        //           'Notifications',
        //           style: Theme.of(context).textTheme.bodyMedium,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text('Notifications'),
                centerTitle: true,
                pinned: true,
                floating: true,
                snap: true,
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  tabs: [
                    Tab(
                      child: Text(
                        'All',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Notifications',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => NotificationCard(
                  icon: Icon(Icons.abc),
                  iconBackground: Colors.orange,
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
        //
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.icon,
    required this.iconBackground,
  }) : super(key: key);

  final Color iconBackground;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Ink(
            decoration: ShapeDecoration(
              color: iconBackground.withOpacity(0.2),
              shape: CircleBorder(),
            ),
            height: 56,
            width: 56,
            child: Center(
              child: CircleAvatar(
                backgroundColor: iconBackground,
                radius: 16,
                child: icon,
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text('Your handee man has arrived'),
          ),
          SizedBox(width: 16.0),
          Text('Time'),
        ],
      ),
    );
  }
}
