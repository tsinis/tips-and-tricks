import 'package:meta/meta.dart';

class Logger {
  const Logger(this.destination);
  final String destination;
}

class LoggerFactory {
  @factory // Always returns a new [Logger] instance (not a cached singleton).
  static Logger createLogger(String destination) => Logger(destination);
}

class LoggerCache {
  static final Map<int, Logger> _cache = {};

  @factory // Analyzer error: Factory doesn't return a newly allocated [Logger].
  static Logger createLogger(String destination) =>
      _cache.putIfAbsent(destination.length, () => Logger(destination));
}

void main() {
  final logger1 = LoggerFactory.createLogger('1');
  final logger2 = LoggerCache.createLogger('2');
  print('Logger1 destination: ${logger1.destination}'); // Prints 1
  print('Logger2 destination: ${logger2.destination}'); // Prints 2
  final logger3 = LoggerFactory.createLogger('3');
  final logger4 = LoggerCache.createLogger('4');
  print('Logger3 destination: ${logger3.destination}'); // Prints 3
  print('Logger4 destination: ${logger4.destination}'); // Prints 2
}
