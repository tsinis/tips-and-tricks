import 'package:meta/meta.dart';

class DataProcessor {
  @visibleForOverriding
  void onData(String data) {
    // Intended for override, not for direct calls
  }

  void process(String data) {
    // ... some processing logic ...
    onData(data);
  }
}

class CustomProcessor extends DataProcessor {
  @override
  void onData(String data) => print('Custom processed: $data');
}

void main() {
  final processor = CustomProcessor();
  processor.process('Hello'); // Calls overridden onData.
  /// Not recommended: direct call to onData:
  processor.onData('!'); // Show a warning in IDEs (when used outside the file).
}
