import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' as vmath;

class RotatableWidget extends StatefulWidget {
  final Widget child;

  const RotatableWidget({super.key, required this.child});

  @override
  RotatableWidgetState createState() => RotatableWidgetState();
}

class RotatableWidgetState extends State<RotatableWidget> {
  vmath.Vector3 _rotation = vmath.Vector3.zero();
  Offset _lastFocalPoint = Offset.zero;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      final dx = details.localPosition.dx - _lastFocalPoint.dx;
      final dy = details.localPosition.dy - _lastFocalPoint.dy;

      _rotation += vmath.Vector3(dy, dx, 0) * 0.01;
      _lastFocalPoint = details.localPosition;
    });
  }

  void _onPanStart(DragStartDetails details) {
    _lastFocalPoint = details.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      child: Transform(
        transform: Matrix4.identity()
          ..rotateX(_rotation.x)
          ..rotateY(_rotation.y)
          ..rotateZ(_rotation.z),
        alignment: FractionalOffset.center,
        child: widget.child,
      ),
    );
  }
}
