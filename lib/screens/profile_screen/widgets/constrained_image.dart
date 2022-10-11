//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_school/styling/pallet.dart';

import '../../../styling/assets.dart';

class ConstrainedImage extends StatelessWidget {
  const ConstrainedImage({
    Key? key,
    required this.width,
    required this.height,
    required this.path,
    this.isPlaceholder = false,
    this.isRound = true,
  }) : super(key: key);

  final double width;
  final double height;
  final String path;
  final bool isPlaceholder;
  final bool isRound;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: height,
      ),
      decoration: isRound
          ? const BoxDecoration(
              color: Pallet.grey,
              shape: BoxShape.circle,
            )
          : null,
      clipBehavior: isRound ? Clip.hardEdge : Clip.none,
      child: isPlaceholder
          ? Image.asset(Assests.avatarIcon)
          : Image.file(File(path)),
    );
  }
}
