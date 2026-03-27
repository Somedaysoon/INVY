import 'package:flutter/material.dart';

class InvyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InvyAppBar({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: subtitle == null ? 72 : 84,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(title, style: theme.textTheme.titleLarge),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: theme.textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(subtitle == null ? 72 : 84);
}
