import 'package:flutter/material.dart' show kToolbarHeight;
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../data/constants/const_colours.dart';

/// Standard [PlatformAppBar] for the app
class GsAppBar extends PlatformAppBar implements PreferredSizeWidget {
  /// Customized app bar for the app
  GsAppBar({
    Widget? title,
    bool centerTitle = true,
    Widget? leading,
    Widget? trailing,
    super.automaticallyImplyLeading = true,
    super.key,
  }) : super(
          title: centerTitle
              ? Center(
                  child: title,
                )
              : title,
          backgroundColor: ConstColours.indigoDye,
          leading: leading ??
              IgnorePointer(
                child: Opacity(
                  opacity: 0,
                  child: trailing,
                ),
              ),
          trailingActions: trailing != null
              ? [trailing]
              : (centerTitle
                  ? [
                      IgnorePointer(
                        child: Opacity(opacity: 0, child: leading),
                      ),
                    ]
                  : []),
          cupertino: (_, __) => CupertinoNavigationBarData(
            noMaterialParent: true,
            transitionBetweenRoutes: true,
          ),
        );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
