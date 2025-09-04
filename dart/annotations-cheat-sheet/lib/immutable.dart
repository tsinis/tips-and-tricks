import 'package:meta/meta.dart';

@immutable
base class Point {
  const Point(this.x, this.y);
  final double x, y;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Point && other.x == x && other.y == y;
  }

  @override
  int get hashCode => Object.hash(x, y);
}

/// Analyzer error: must_be_immutable!
final class MutablePoint extends Point {
  MutablePoint(super.x, super.y, [this.z]);
  double? z;
}

void main() {
  final a = MutablePoint(1, 2, 3); // Cannot be assigned as a constant.
  const b = Point(1, 2);
  print(a == b); // true, value semantics.
  a.z = 5; // Not possible in an immutable class.
}
