import 'package:perfect_freehand/perfect_freehand.dart';

StrokeOptions options = StrokeOptions(
  size: 15,
  thinning: 0,
  smoothing: 0.5,
  streamline: 0,
  start: StrokeEndOptions.start(
    taperEnabled: false,
    customTaper: 0.0,
    cap: true,
  ),
  end: StrokeEndOptions.end(taperEnabled: false, customTaper: 0.0, cap: true),
  simulatePressure: false,
  isComplete: false,
);
