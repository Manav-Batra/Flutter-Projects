import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _buttonradius = 100;
  final Tween<double> _backgroundscale = Tween<double>(begin: 0.0, end: 1.0);
  AnimationController? _stariconcontroller;
  @override
  void initState() {
    super.initState();
    _stariconcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _stariconcontroller!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _pagebackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [_circularanimationbutton(), _staricon()],
            )
          ],
        ),
      ),
    );
  }

  Widget _pagebackground() {
    return TweenAnimationBuilder(
      tween: _backgroundscale,
      duration: Duration(seconds: 2),
      builder: (_context, double _scale, _child) {
        return Transform.scale(
          scale: _scale,
          child: _child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget _circularanimationbutton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _buttonradius += _buttonradius == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.bounceOut,
          height: _buttonradius,
          width: _buttonradius,
          decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(_buttonradius)),
        ),
      ),
    );
  }

  Widget _staricon() {
    return AnimatedBuilder(
      animation: _stariconcontroller!.view,
      builder: (_buildcontext, _child) {
        return Transform.rotate(
          angle: _stariconcontroller!.value * 2 * pi,
          child: _child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
