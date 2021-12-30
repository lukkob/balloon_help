library tooltips;

import 'dart:math';

import 'package:flutter/material.dart';

enum PointerPosition {
  top,
  right,
  bottom,
  left,
  bottomRight,
  bottomLeft,
  topRight,
  topLeft
}

const defaultPointerHeight = 10.0;

class BalloonHelp extends StatelessWidget {
  /// Creates a widget that emulates a speech bubble.
  /// Could be used for a tooltip, or as a pop-up notification, etc.
  const BalloonHelp(
      {Key? key,
        required this.child,
        this.pointerPosition = PointerPosition.bottom,
        this.color = Colors.white,
        this.borderRadius = 4.0,
        this.height,
        this.width,
        this.padding,
        this.pointerHeight = defaultPointerHeight,
        this.offset = Offset.zero})
      : super(key: key);

  /// The [child] contained by the [BalloonHelp]
  final Widget child;

  /// The location of the nip of the speech bubble.
  ///
  /// Use [PointerPosition] enum, either [top], [right], [bottom], or [left].
  /// The nip will automatically center to the side that it is assigned.
  final PointerPosition pointerPosition;

  /// The color of the body of the [BalloonHelp] and nip.
  /// White by default.
  final Color color;

  /// The [borderRadius] of the [BalloonHelp].
  /// The [BalloonHelp] is built with a
  /// circular border radius on all 4 corners.
  final double borderRadius;

  /// The explicitly defined height of the [BalloonHelp].
  /// The [BalloonHelp] will defaultly enclose its [child].
  final double? height;

  /// The explicitly defined width of the [BalloonHelp].
  /// The [BalloonHelp] will defaultly enclose its [child].
  final double? width;

  /// The padding between the child and the edges of the [BalloonHelp].
  final EdgeInsetsGeometry? padding;

  /// The nip height
  final double pointerHeight;

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    Offset? nipOffset;
    AlignmentGeometry? alignment;
    var rotatedPointerHalfHeight = getPointerHeight(pointerHeight) / 2;
    var offset = pointerHeight / 2 + rotatedPointerHalfHeight;
    switch (pointerPosition) {
      case PointerPosition.top:
        nipOffset = Offset(0.0, -offset + rotatedPointerHalfHeight);
        alignment = Alignment.topCenter;
        break;
      case PointerPosition.right:
        nipOffset = Offset(offset - rotatedPointerHalfHeight, 0.0);
        alignment = Alignment.centerRight;
        break;
      case PointerPosition.bottom:
        nipOffset = Offset(0.0, offset - rotatedPointerHalfHeight);
        alignment = Alignment.bottomCenter;
        break;
      case PointerPosition.left:
        nipOffset = Offset(-offset + rotatedPointerHalfHeight, 0.0);
        alignment = Alignment.centerLeft;
        break;
      case PointerPosition.bottomLeft:
        nipOffset = this.offset +
            Offset(
                offset - rotatedPointerHalfHeight, offset - rotatedPointerHalfHeight);
        alignment = Alignment.bottomLeft;
        break;
      case PointerPosition.bottomRight:
        nipOffset = this.offset +
            Offset(
                -offset + rotatedPointerHalfHeight, offset - rotatedPointerHalfHeight);
        alignment = Alignment.bottomRight;
        break;
      case PointerPosition.topLeft:
        nipOffset = this.offset +
            Offset(
                offset - rotatedPointerHalfHeight, -offset + rotatedPointerHalfHeight);
        alignment = Alignment.topLeft;
        break;
      case PointerPosition.topRight:
        nipOffset = this.offset +
            Offset(
                -offset + rotatedPointerHalfHeight, -offset + rotatedPointerHalfHeight);
        alignment = Alignment.topRight;
        break;
      default:
    }

    return Stack(
      alignment: alignment!,
      children: [
        balloonHelp(),
        pointer(nipOffset!),
      ],
    );
  }

  Widget balloonHelp() => Material(
    borderRadius: BorderRadius.all(
      Radius.circular(borderRadius),
    ),
    color: color,
    elevation: 1.0,
    child: Container(
      height: height,
      width: width,
      padding: padding ?? const EdgeInsets.all(8.0),
      child: child,
    ),
  );

  Widget pointer(Offset pointerOffset) => Transform.translate(
    offset: pointerOffset,
    child: RotationTransition(
      turns: const AlwaysStoppedAnimation(45 / 360),
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(1.5),
        ),
        color: color,
        child: SizedBox(
          height: pointerHeight,
          width: pointerHeight,
        ),
      ),
    ),
  );

  double getPointerHeight(double height) => sqrt(2 * pow(height, 2));
}
