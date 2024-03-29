import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/features/home/providers/find_location.provider.dart';

import 'package:handees/shared/res/shapes.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) {
        return const LocationPickerClosed();
      },
      // closedColor: Theme.of(context).cardColor,
      closedShape: Shapes.bigShape,
      openShape: Shapes.bigShape,
      // openColor: Theme.of(context).colorScheme.primary,
      closedColor: Theme.of(context).colorScheme.primary,
      // middleColor: Colors.red, // Theme.of(context).colorScheme.primary,
      openBuilder: (context, action) {
        return const LocationPickerOpened();
      },
    );
  }
}

class LocationPickerClosed extends StatelessWidget {
  const LocationPickerClosed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 64.0,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
          selectionColor:
              Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
          selectionHandleColor:
              Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        child: TextField(
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
          decoration: InputDecoration(
            enabled: false,
            filled: false,
            prefixIcon: Icon(
              Icons.location_on,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class LocationPickerOpened extends ConsumerStatefulWidget {
  const LocationPickerOpened({super.key});

  @override
  ConsumerState<LocationPickerOpened> createState() =>
      _LocationPickerOpenedState();
}

class _LocationPickerOpenedState extends ConsumerState<LocationPickerOpened> {
  final _textFocusNode = FocusNode();

  @override
  void initState() {
    _textFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = ref.watch(findLocationProvider);
    final findLocationStateNotifier = ref.watch(findLocationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        // centerTitle: true,
        title: TextField(
          focusNode: _textFocusNode,
          onChanged: findLocationStateNotifier.getSuggestions,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              findLocationStateNotifier.getLocation(suggestions[index].id);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(suggestions[index].description),
            ),
          );
        },
        itemCount: suggestions.length,
      ),
    );
  }
}
