import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollTohideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollTohideWidget({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  _ScrollTohideWidgetState createState() => _ScrollTohideWidgetState();
}

class _ScrollTohideWidgetState extends State<ScrollTohideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      print("Show ---------- ");
      show();
    }

    if (direction == ScrollDirection.reverse) {
      print("hide ---------- ");
      hide();
    }
  }

  void show() {
    if (isVisible == false) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? size.height * 0.08 : 0,
      child: widget.child,
    );
  }
}
