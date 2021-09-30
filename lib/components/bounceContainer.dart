import 'package:flutter/material.dart';

class BounceContainer extends StatefulWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final Decoration? decoration;

  const BounceContainer(
      {Key? key,
      this.width = 100.0,
      this.height = 100.0,
      this.decoration,
      this.child})
      : super(key: key);

  @override
  _BounceContainerState createState() => _BounceContainerState();
}

class _BounceContainerState extends State<BounceContainer>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _animationController?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 - _animationController!.value;
    return GestureDetector(
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: widget.decoration != null
              ? widget.decoration
              : BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(38.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 5.0,
                      spreadRadius: 0.25,
                    ),
                  ],
                ),
          child: widget.child,
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _animationController?.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController?.reverse();
  }
}
