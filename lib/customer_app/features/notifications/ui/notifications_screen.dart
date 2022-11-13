import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text('Notifications'),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => const NotificationCard(
                  icon: Icon(Icons.abc),
                  iconBackground: Colors.orange,
                ),
              ),
              const SizedBox(),
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
              shape: const CircleBorder(),
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
          const SizedBox(width: 16.0),
          const Expanded(
            child: Text('Your handee man has arrived'),
          ),
          const SizedBox(width: 16.0),
          const Text('Time'),
        ],
      ),
    );
  }
}
