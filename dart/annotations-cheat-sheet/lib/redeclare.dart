import 'package:meta/meta.dart';

/// Extension type for non-negative integers (e.g., for car mileage, age, etc.).
extension type const NonNegativeInt(int value) implements int {
  @redeclare
  int operator -(int other) {
    final result = value - other;
    assert(!result.isNegative, 'Result cannot be negative!');

    return result;
  }
}

void main() {
  const balance = NonNegativeInt(100);
  const withdrawal = NonNegativeInt(300);

  // This will throw an assertion error in debug mode:
  final newBalance = balance - withdrawal;
  print('New balance: $newBalance');
}
