import 'package:meta/meta.dart';

class Tag {
  const Tag(this.name); // Regular constructor.
  @literal
  const Tag.literal(this.name); // Literal constructor.

  final String name;
}

void main() {
  // Using the @literal constructor: must use const.
  const tagA = Tag.literal('alpha');
  const tagB = Tag.literal('alpha');
  print('literal: identical(tagA, tagB): ${identical(tagA, tagB)}'); // true

  // Using the regular const constructor: can use const or not.
  const tagC = Tag('beta');
  final tagD = Tag('beta');
  print('regular: identical(tagC, tagD): ${identical(tagC, tagD)}'); // false

  // Tag below will cause analyzer error: must use const with @literal
  final tagE = Tag.literal('gamma');
}
