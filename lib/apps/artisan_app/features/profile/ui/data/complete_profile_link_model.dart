class CompleteProfileLink {
  final String title;
  final String subtitle;
  final String disabledText;
  final String routerLink;
  final bool disabled;

  CompleteProfileLink({
    required this.title,
    required this.subtitle,
    required this.routerLink,
    this.disabled = false,
    this.disabledText = '',
  });
}
