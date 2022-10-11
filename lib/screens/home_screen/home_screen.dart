//

import 'package:flutter/material.dart';
import 'package:my_school/helpers/routing/nav_link.dart';
import 'package:my_school/models/more_menu_item.dart';
import 'package:my_school/styling/assets.dart';
import 'package:my_school/styling/pallet.dart';

import '../../database/school_database.dart';
import '../../widgets/app_title_bar.dart';
import 'home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _actionFor(BuildContext context, MoreMenuItem item) {
    switch (item) {
      case MoreMenuItem.addStudent:
        Navigator.of(context).pushNamed(NavLink.addStudent);
        break;
      case MoreMenuItem.subjects:
        Navigator.of(context).pushNamed(NavLink.subjects);
        break;
      case MoreMenuItem.workingdays:
        DateTime date = DateTime.now();
        print("weekday is ${date.weekday}");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const AppTitleBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: Pallet.backgroundGradient,
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            _buildContent(context),
            _funnyImage(size),
          ],
        ),
      ),
    );
  }

  Widget _funnyImage(Size size) {
    return IgnorePointer(
      child: Transform.translate(
        offset: const Offset(-30, 66),
        child: Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: size.width * 0.6,
            height: size.width * 0.3,
            child: Image.asset(
              Assests.funnyImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        _header(context),
        Expanded(
          child: Container(
              padding: const EdgeInsets.only(top: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: const StudentsList()),
        ),
      ],
    );
  }

  Container _header(BuildContext context) {
    return Container(
      height: 114,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Scholl',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.white,
                ),
          ),
          PopupMenuButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Transform.translate(
                offset: const Offset(-3, -2),
                child: const Icon(
                  Icons.more_vert,
                  color: Pallet.darkBlue,
                ),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            color: Colors.grey.shade50,
            onSelected: (item) => _actionFor(context, item),
            itemBuilder: (context) => MoreMenuItem.values
                .map((item) => PopupMenuItem(
                      value: item,
                      child: Text(
                        item.title,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
