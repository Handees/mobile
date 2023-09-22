import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String text;
  final Widget content;
  const CustomBottomSheet({
    required this.title,
    required this.text,
    required this.content,
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(22),
          topEnd: Radius.circular(22),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 16.0),
            if (leading != null)
              Align(
                alignment: Alignment.centerLeft,
                child: leading,
              ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
              ),
            ),
            const SizedBox(height: 16.0),
            content,
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class CTABottomSheet extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String text;
  // cta = Call To Action
  final String ctaText;
  final void Function() onPressCta;
  const CTABottomSheet(
      {required this.title,
      required this.text,
      required this.ctaText,
      required this.onPressCta,
      this.leading,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: title,
      text: text,
      leading: leading,
      content: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: onPressCta,
          child: Text(ctaText),
        ),
      ),
    );
  }
}
