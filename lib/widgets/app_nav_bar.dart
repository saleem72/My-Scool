//

import 'package:flutter/material.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    Key? key,
    required this.label,
    this.height = 56,
    this.actions,
  }) : super(key: key);

  final String label;
  final Widget? actions;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white,
                    ),
              )
            ],
          ),
          actions != null ? actions! : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
