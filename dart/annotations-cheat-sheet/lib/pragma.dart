// Dart VM pragmas are toolchain hints. They do not usually produce analyzer
// warnings; they influence JIT/AOT compilers and tree-shaking.

// Keep this symbol reachable in AOT (tree-shaken) builds, even if it appears
// unused to the compiler (for example, called from native/FFI or reflection).
@pragma('vm:entry-point')
void keepDuringTreeShaking() {
  // FFI/platform code may call into this. The pragma prevents its removal.
}

class Service {
  // Mark a constructor as an entry point if it can be constructed via native
  // code or reflection. Without this, AOT might remove it as "unused".
  @pragma('vm:entry-point')
  Service._();

  static Service create() => Service._();
}

// Hint to the VM that this tiny function is a good candidate for inlining in
// optimized (release/AOT) builds. Inlining can reduce call overhead.
@pragma('vm:prefer-inline')
int clampToByte(int value) {
  if (value < 0) return 0;
  if (value > 255) return 255;
  return value;
}

// Conversely, prevent inlining to keep a clear stack frame (useful for
// profiling or to avoid code bloat when the function is large).
@pragma('vm:never-inline')
String computeTag(int id) => 'item_$id';

void main() {
  // Using the functions normally; analyzer does not warn about pragmas.
  keepDuringTreeShaking();
  final svc = Service.create();
  final a = clampToByte(300);
  final b = computeTag(a);
  // Touch values to avoid "unused" lints in examples.
  if (svc.hashCode == 0) {
    // This branch is never true; it just keeps variables "used".
    print(b);
  }
}
