import 'package:meta/meta.dart';

class Entity {
  const Entity(this._id);

  @nonVirtual
  int get schemaVersion => 3;

  bool get isPersisted => _id != null;
  final int? _id;
}

class User extends Entity {
  const User(this.name, [super._id]);

  @override // Analyzer error: Cannot override non-virtual member.
  int get schemaVersion => 4;

  final String name;
}

void main() {
  final user = User('Alice', 42);
  print('User persisted: ${user.isPersisted}'); // true
  print('User schema version: ${user.schemaVersion}'); // 4

  final user2 = Entity(null);
  print('User2 persisted: ${user2.isPersisted}'); // false
  print('User2 schema version: ${user2.schemaVersion}'); // 3
}
