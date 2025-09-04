import 'package:meta/meta.dart';

class DatabaseConnection {
  @mustCallSuper
  void open() => print('Opening base database connection...');
}

class LoggingDatabaseConnection extends DatabaseConnection {
  @override
  void open() {
    // Uncommenting the next line will fix the analyzer warning:
    // super.open();
    print('Opening database connection with logging...');
  }
}

void main() => LoggingDatabaseConnection().open();
// The analyzer will warn that LoggingDatabaseConnection.open()
// does not call super.open(), violating the @mustCallSuper contract.
