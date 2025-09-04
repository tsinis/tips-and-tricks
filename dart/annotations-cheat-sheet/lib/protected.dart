import 'package:meta/meta.dart';

class BankAccount {
  BankAccount(this._balance);
  double _balance;

  @protected
  void applyFee(double fee) => _balance -= fee;

  double get balance => _balance;
}

class PremiumAccount extends BankAccount {
  PremiumAccount(super.initial);

  /// Allowed: subclass can call protected method
  void monthlyMaintenance() => applyFee(5);
}

void main() {
  final account = PremiumAccount(100);
  account.monthlyMaintenance();
  print('Balance after fee: ${account.balance}');
  // Not allowed: protected method is not accessible outside the class hierarchy.
  account.applyFee(10); // Show a warning in IDEs (when used outside the file).
}
