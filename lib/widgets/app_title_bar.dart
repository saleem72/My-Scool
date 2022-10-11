//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTitleBar extends StatelessWidget with PreferredSizeWidget {
  const AppTitleBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
