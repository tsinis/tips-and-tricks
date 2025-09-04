import 'package:meta/meta.dart';

base class PaymentMethod {
  @mustBeOverridden
  bool validatePayment(double amount) => amount > 0;

  void process(double amount) {
    if (!validatePayment(amount)) throw Exception('Payment validation failed!');
    print('Processing payment of $amount');
  }
}

final class CreditCardPayment extends PaymentMethod {
  @override
  bool validatePayment(double amount) =>
      super.validatePayment(amount) && amount < 100_000; // Can use super.
}

// Analyzer error: Missing concrete implementation of 'validatePayment'.
final class CashPayment extends PaymentMethod {}

// The analyzer will require every concrete subclass of PaymentMethod
// to implement validatePayment, enforcing correct framework usage.
void main() {
  final payment = CreditCardPayment();
  print(payment.validatePayment(-1)); // Uses super check but needs override.
  payment.process(100); // OK
}
