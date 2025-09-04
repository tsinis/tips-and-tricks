import 'package:meta/meta.dart';

class ConfigManager {
  int _counter = 0;

  void increment() => _counter++;
  int get counter => _counter;

  @visibleForTesting
  void reset() => _counter = 0;
}

void main() {
  final config = ConfigManager();
  config.increment();
  print('Counter: ${config.counter}');
  // Not for production: only for tests
  config.reset(); // IDE warns if used outside test (when used outside the file)
}
