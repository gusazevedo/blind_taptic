import 'package:blind_taptic/config/stroke.dart';
import 'package:blind_taptic/config/stroke_options.dart';
import 'package:blind_taptic/widgets/stroke_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vibration/vibration.dart';

class BlindView extends StatelessWidget {
  final List<Stroke> lines;
  BlindView({super.key, required this.lines});

  final shapeKey = GlobalKey();

  void vibrateIfHit(PointerEvent details) {
    final box = shapeKey.currentContext!.findRenderObject() as RenderBox;

    final boxHitTestResult = BoxHitTestResult();

    Offset localPosition = box.globalToLocal(details.position);

    final resultHitTest = box.hitTest(
      boxHitTestResult,
      position: localPosition,
    );

    final shouldVibrate = resultHitTest;

    if (shouldVibrate) {
      Vibration.vibrate(pattern: [0, 500], repeat: 0);
      print('SHOULD VIBRATE');
    } else {
      Vibration.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Área tátil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        backgroundColor: const Color(0xff8257E5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: PopScope(
        canPop: false,
        child: Scaffold(
          body: Listener(
            onPointerDown: vibrateIfHit,
            onPointerMove: vibrateIfHit,
            onPointerCancel: (_) {
              Vibration.cancel();
            },
            onPointerUp: (_) {
              Vibration.cancel();
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
              child: CustomPaint(
                key: shapeKey,
                painter: StrokePainter(
                  isBlindMode: true,
                  color: colorScheme.onSurface,
                  lines: lines,
                  options: options,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
