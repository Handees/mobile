import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/widgets/home_screen/notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with TickerProviderStateMixin {
  double _height = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_height == 0) {
      _height = MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.vertical -
          kBottomNavigationBarHeight -
          kTextTabBarHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                unselectedLabelColor: HandeeColors.black,
                labelColor: HandeeColors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: HandeeColors.black,
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: 90,
                      child: Center(child: Text('All')),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: 90,
                      child: Center(child: Text('Reminders')),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _height,
                child: TabBarView(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 500,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (ctx, index) {
                          return NotificationWidget();
                          // return Notification();
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 500,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
