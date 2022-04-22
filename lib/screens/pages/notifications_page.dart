import 'package:flutter/material.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/icons/handee_icons.dart';
import 'package:handee/widgets/home_screen/notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: const [
            TabBar(
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
            Expanded(
              child: TabBarView(
                children: [
                  _AllTab(),
                  _ReminderTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllTab extends StatelessWidget {
  const _AllTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (ctx, index) {
          switch (index) {
            case 0:
              return NotificationWidget.delivery(
                agentName: 'The Heat Cleaners',
              );
            case 1:
              return NotificationWidget.schedule(
                agentName: 'The Heat Cleaners',
              );
            case 2:
              return NotificationWidget(
                leading: const CircleAvatar(
                  backgroundColor: Color.fromRGBO(255, 220, 220, 1),
                  child: Icon(
                    HandeeIcons.alert_triangle,
                    color: HandeeColors.red,
                  ),
                ),
                message: 'New device login. Is this you?',
              );
            case 3:
              return NotificationWidget.welcome();
            default:
              return const Text('Never getting here');
          }
          // return Notification();
        },
      ),
    );
  }
}

class _ReminderTab extends StatelessWidget {
  const _ReminderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      color: Colors.blue,
    );
  }
}
