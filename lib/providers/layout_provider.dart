import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final layoutProvider = ChangeNotifierProvider<AppLayout>((ref) {
  return AppLayout();
});

const double _STARTING_SIDE_WIDTH = 150;

class AppLayout extends ChangeNotifier {
  final double minCenterWidth = 100;

  double _leftDivider = _STARTING_SIDE_WIDTH;
  double _rightDivider = _STARTING_SIDE_WIDTH;

  double _appWidth = 250;

  double get appWidth => _appWidth;
  double get leftDivider => isReducedWidth ? reducedLeftWidth : _leftDivider;
  double get rightDivider => isReducedWidth ? reducedRightWidth : _rightDivider;

  bool isReducedWidth = false;
  double reducedRightWidth = _STARTING_SIDE_WIDTH;
  double reducedLeftWidth = _STARTING_SIDE_WIDTH;

  set appWidth(double width) {
    if (width == _appWidth) return;
    if (width < (leftDivider + rightDivider + minCenterWidth)) {
      isReducedWidth = true;
      final delta = minCenterWidth + rightDivider + leftDivider - width;
      reducedLeftWidth = reducedLeftWidth - (delta / 2);
      reducedRightWidth = reducedRightWidth - (delta / 2);
    } else if ((reducedRightWidth < _rightDivider ||
            reducedLeftWidth < _leftDivider) &&
        width > _appWidth) {
      final delta = width - _appWidth;
      if (reducedRightWidth < _rightDivider) reducedRightWidth += delta;
      if (reducedLeftWidth < _leftDivider) reducedLeftWidth += delta;
      if (reducedLeftWidth == _leftDivider &&
          reducedRightWidth == _rightDivider) isReducedWidth = false;
    }
    _appWidth = width;
    notifyListeners();
  }

  set leftDivider(double left) {
    if (rightDivider + left + minCenterWidth >= _appWidth) {
      _leftDivider = _appWidth - rightDivider - minCenterWidth;
    } else {
      _leftDivider = left < 10 ? 10 : left;
    }
    reducedLeftWidth = _leftDivider;
    notifyListeners();
  }

  set rightDivider(double right) {
    if (leftDivider + right + minCenterWidth >= _appWidth) {
      _rightDivider = _appWidth - leftDivider - minCenterWidth;
    } else {
      _rightDivider = right < 10 ? 10 : right;
    }
    reducedRightWidth = _rightDivider;
    notifyListeners();
  }
}
