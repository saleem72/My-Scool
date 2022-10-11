//

import 'package:flutter/material.dart';
import 'package:my_school/helpers/routing/nav_link.dart';
import 'package:my_school/styling/assets.dart';

import '../../styling/pallet.dart';
import '../../widgets/app_title_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SplashScreenContent(totalHeight: size.height);
  }
}

class SplashScreenContent extends StatefulWidget {
  const SplashScreenContent({
    Key? key,
    required this.totalHeight,
  }) : super(key: key);
  final double totalHeight;
  @override
  State<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacity;
  late Animation<EdgeInsets> _margin;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(NavLink.initial, (route) => false);
        }
      });
    final begin = (widget.totalHeight * 0.5) - 62;
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.3,
          0.8,
          curve: Curves.easeIn,
        ),
      ),
    );
    _margin = Tween<EdgeInsets>(
            begin: EdgeInsets.only(top: begin),
            end: const EdgeInsets.only(top: 161))
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.easeIn,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppTitleBar(),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment(-0.4950890839099884, -0.474401593208313),
              //     end: Alignment(0.474401593208313, -0.4950890839099884),
              //     colors: [
              //       Pallet.blue, // Color.fromRGBO(40, 85, 174, 1),
              //       Pallet.lightBlue // Color.fromRGBO(114, 146, 207, 1)
              //     ]),
              color: Pallet.blue,
            ),
            child: Stack(
              children: [
                Opacity(
                  opacity: _opacity.value,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: size.width,
                      height: size.width,
                      child: Image.asset(
                        Assests.splashImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: _margin.value,
                    width: 126.15,
                    height: 62.97,
                    child: Image.asset(
                      Assests.logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
