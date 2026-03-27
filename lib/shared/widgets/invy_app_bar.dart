import 'package:flutter/material.dart';

class InvyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InvyAppBar({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitleStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onPrimary.withValues(alpha: 0.78),
      fontSize: 13,
    );
    final titleStyle = theme.textTheme.headlineSmall?.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 30,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.4,
    );

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: subtitle == null ? 110 : 126,
      clipBehavior: Clip.antiAlias,
      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.20),
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 18,
            left: -20,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -24,
            bottom: -34,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.paddingOf(context).top + 18,
              24,
              20,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, textAlign: TextAlign.left, style: titleStyle),
                    if (subtitle != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle!,
                        textAlign: TextAlign.left,
                        style: subtitleStyle,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(subtitle == null ? 110 : 126);
}
