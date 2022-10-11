//

import 'package:flutter/material.dart';

import '../styling/assets.dart';

class StarPattern extends StatelessWidget {
  const StarPattern({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Image.asset(Assests.starPattern),
    );
  }
}
