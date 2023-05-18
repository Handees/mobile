import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:handees/shared/routes/routers.dart';

class RootNavigator extends StatefulWidget {
  const RootNavigator({
    super.key,
    required this.router,
  });

  final NavRouter router;

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<RootNavigator> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Navigator(
        onGenerateRoute: widget.router.onGenerateRoute,
        key: widget.router.navigatorKey,
      ),
      onWillPop: () async {
        final navigator = widget.router.navigatorKey.currentState!;
        if (navigator.canPop() || await navigator.maybePop()) {
          navigator.maybePop();
        } else {
          SystemNavigator.pop();
        }
        return false;
      },
    );
  }
}
