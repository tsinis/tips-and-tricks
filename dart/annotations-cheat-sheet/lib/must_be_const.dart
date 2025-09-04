import 'package:meta/meta.dart';

class FeatureFlag {
  const FeatureFlag(this.value);
  final int value;
}

/// Only compile-time constant 'b' is allowed for comparison.
bool areFlagsEqual(FeatureFlag a, @mustBeConst FeatureFlag b) => a == b;

const flagA = FeatureFlag(1);
const flagB = FeatureFlag(1);
var flagC = FeatureFlag(flagA.value); // NOT const.

void main() {
  // This is OK: both are constants.
  print('flagA == flagB: ${areFlagsEqual(flagA, flagB)}');

  // This will cause analyzer warning: 'flagC' is not const.
  print('flagA == flagC: ${areFlagsEqual(flagA, flagC)}');

  // Real difference: @mustBeConst ensures only canonical, compile-time objects
  // are compared preventing subtle bugs from runtime-generated values.
}
