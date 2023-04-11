import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:handees/apps/customer_app/home/viewmodels/find_location_viewmodel.dart';
import 'package:handees/res/shapes.dart';
import 'package:handees/services/places_service.dart';

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

class LocationPickerOpened extends StatefulWidget {
  const LocationPickerOpened({super.key});

  @override
  State<LocationPickerOpened> createState() => _LocationPickerOpenedState();
}

class _LocationPickerOpenedState extends State<LocationPickerOpened> {
  final _textFocusNode = FocusNode();

  final viewModel = FindLocationViewModel(PlacesService.test);

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
    return AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
          final notifier = viewModel;
          final suggestions = viewModel.suggestions;

          return Scaffold(
            appBar: AppBar(
              // backgroundColor: Theme.of(context).colorScheme.primary,
              // centerTitle: true,
              title: TextField(
                focusNode: _textFocusNode,
                onChanged: notifier.getSuggestions,
              ),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    notifier.getLocation(suggestions[index].id);
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
        });
  }
}
