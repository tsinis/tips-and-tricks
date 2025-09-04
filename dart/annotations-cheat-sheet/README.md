# Dart & Flutter Annotations: A Practical Cheat Sheet

If you've ever scrolled past an annotation like `@immutable` or `@override` and thought "I kind of know what that does… I think," this article is for you. Annotations (aka metadata) are small hints you attach to code that help the analyzer, tooling, and other developers understand intent. They're low-effort, high-impact, and used everywhere in Dart and Flutter — from simple `@mustCallSuper` to performance-focused `@pragma`.

Here you'll get:

- A quick primer on what metadata is in Dart.
- A practical, narrative guide to commonly used annotations.
- When to use each annotation (and when not to).
- Copy‑pasteable examples.
- Handy tips sprinkled throughout.

> [!NOTE]
> Code-generation annotations, such as `@JsonSerializable`, `@freezed`, and so on - are very common but fall outside the scope of this discussion.

## What is metadata in Dart?

Metadata is extra information you attach to declarations using annotations. In Dart, annotations are expressions that start with `@` and sit before classes, methods, fields, parameters, and more. The analyzer and tools read them to enable checks, guide optimizations, and improve IDE behavior. You'll see two broad kinds:

- Language and SDK annotations (like `@override`, `@Deprecated`, `@pragma`) that the tools understand out of the box.
- Package annotations (most commonly `package:meta`) that the analyzer also knows and can enforce.

For a deeper, formal overview, see Metadata | Dart ([dart.dev](https://dart.dev/language/metadata)) .

## How to use

- Core `dart:core` annotations: available by default.
- `package:meta`: add a [dependency](https://pub.dev/packages/meta) (or use Flutter re‑exports).
- `package:dart_code_metrics_annotations` (DCM): optional, add [dependency](https://pub.dev/packages/dart_code_metrics_annotations) explicitly.

> [!TIP]
> Flutter SDK re‑exports a small subset of annotations via import "package:flutter/foundation.dart" so you can use those without adding `meta` to pubspec.yaml.

## Quick Reference

| Score | Annotation                                         | Source    | Description                                         | From SDK       |
| ----- | -------------------------------------------------- | --------- | --------------------------------------------------- | -------------- |
| 3️⃣    | [deprecated](#deprecated-core)                     | **core**  | Mark API obsolete; include migration hint           | **Yes** (Dart) |
| 3️⃣    | [override](#override-core)                         | **core**  | Assert you’re truly overriding a member             | **Yes** (Dart) |
| 3️⃣    | [awaitNotRequired](#awaitnotrequired-meta)         | meta      | Callers needn’t await this Future                   | No             |
| 2️⃣    | [doNotStore](#donotstore-meta)                     | meta      | Don’t cache or persist the returned value           | No             |
| 2️⃣    | [doNotSubmit](#donotsubmit-meta)                   | meta      | Dev‑only; remove before commit                      | No             |
| 1️⃣    | [experimental](#experimental-meta)                 | meta      | API may change without version bump                 | No             |
| 2️⃣    | [factory](#factory-meta)                           | meta      | Must return a fresh object (or null)                | **Yes**        |
| 3️⃣    | [immutable](#immutable-meta)                       | meta      | All instance fields must be final (incl. inherited) | **Yes**        |
| 1️⃣    | [internal](#internal-meta)                         | meta      | For use inside the declaring package only           | No             |
| 2️⃣    | [isTest](#istest--istestgroup-meta)                | meta      | Marks a single test entry point                     | No             |
| 1️⃣    | [isTestGroup](#istest--istestgroup-meta)           | meta      | Marks a test group entry point                      | No             |
| 2️⃣    | [literal](#literal-meta)                           | meta      | Const constructor should be called with const       | No             |
| 2️⃣    | [mustBeConst](#mustbeconst-meta-experimental)      | meta      | Parameter must be a compile‑time constant           | No             |
| 2️⃣    | [mustBeOverridden](#mustbeoverridden-meta)         | meta      | Every concrete subclass must implement this         | No             |
| 3️⃣    | [mustCallSuper](#mustcallsuper-meta)               | meta      | Overrides must call super implementation            | **Yes**        |
| 2️⃣    | [nonVirtual](#nonvirtual-meta)                     | meta      | Subclasses cannot override this member              | **Yes**        |
| 2️⃣    | [optionalTypeArgs](#optionaltypeargs-meta)         | meta      | Allow omitting generic type arguments               | **Yes**        |
| 2️⃣    | [pragma](#pragma-core)                             | **core**  | Tool/VM/Compiler hint                               | **Yes** (Dart) |
| 3️⃣    | [protected](#protected-meta)                       | meta      | Use inside library and subclasses (on this)         | **Yes**        |
| 1️⃣    | [RecordUse](#recorduse-meta-experimental)          | meta      | Record statically resolved calls for tooling        | No             |
| 1️⃣    | [redeclare](#redeclare-meta-experimental)          | meta      | Extension type redeclares a superinterface member   | No             |
| 2️⃣    | [reopen](#reopen-meta)                             | meta      | Intentionally reopen a hierarchy for subtyping      | No             |
| 2️⃣    | [useResult](#useresult-meta)                       | meta      | Warn if return value is ignored                     | No             |
| 2️⃣    | [visibleForOverriding](#visibleforoverriding-meta) | meta      | Public for override, not for calls                  | **Yes**        |
| 3️⃣    | [visibleForTesting](#visiblefortesting-meta)       | meta      | Public for tests, not for production                | **Yes**        |
| 2️⃣    | [Throws](#throws-dcm)                              | **_DCM_** | Declaration may throw; call sites must handle       | No             |
| 1️⃣    | [AcceptedTypes](#acceptedtypes-dcm)                | **_DCM_** | Restrict Object‑typed values to a type subset       | No             |

## Table of Contents

- **Contracts & Correctness** – `factory`, `mustBeConst`, `mustBeOverridden`, `mustCallSuper`, `nonVirtual`, `override`, `redeclare`.
- **Visibility & API Design** – `internal`, `protected`, `visibleForOverriding`, `visibleForTesting`.
- **Const & Construction** – `immutable`, `literal`, `optionalTypeArgs`.
- **Result & Resource Usage** – `awaitNotRequired`, `doNotStore`, `doNotSubmit`, `useResult`.
- **Testing Aids** – `isTest`, `isTestGroup`.
- **Experimental & Versioning** – `deprecated`, `experimental`, `reopen`.
- **Performance & Tooling Pragmas** – `RecordUse`, `pragma`.
- **Bonus (DCM)** – `Throws`, `AcceptedTypes`.

---

## Contracts & Correctness

### @override (core)

Why: Prevent silent shadowing. The analyzer confirms the member actually overrides something and matches the signature.

When: Every time you intend to override (methods, getters/setters, operators, fields' implicit accessors).

```dart
abstract class Animal { void speak() {} }

class Dog extends Animal {
  @override
  void speak() => print('Woof!');
  // void speaks() {} // analyzer: not overriding anything
}
```

or [DartPad Example](https://gist.github.com/tsinis/177e62cfdac785c6129f627404bd2cd6)

> [!TIP]
> Use `@override` even on fields when you intend to override implicit getters/setters. It catches mistakes early.

---

### @mustCallSuper (meta)

Why: Preserve base invariants. Skipping super often leaks resources or skips setup.

When: Lifecycle hooks (Flutter initState/dispose), telemetry, locking state transitions.

```dart
class BaseState {
  @mustCallSuper
  void init() {
    // register base observers
  }
}

class FeatureState extends BaseState {
  @override
  void init() {
    super.init(); // required
    // feature setup
  }
}
```

or [DartPad Example](https://gist.github.com/tsinis/6c19f6390461c716bc715b49b08e9339)

> [!NOTE]
> Works on getters/setters too — useful for enforcing checks during property overrides.

---

### @mustBeOverridden (meta)

Why: Turn a concrete member into a required hook for all concrete subclasses.

When: Framework scaffolds where "default behavior" would mislead users.

```dart
class RouteGuard {
  @mustBeOverridden
  bool canEnter() => false; // must be overridden by concrete subclasses
}

class LoggedInGuard extends RouteGuard {
  @override
  bool canEnter() => true;
}
// class Missing extends RouteGuard {} // error: must override
```

or [DartPad Example](https://gist.github.com/tsinis/dbd7cd40cf1b042cdde267130adfe7a5)

> [!TIP]
> This lets you keep the class concrete (instantiable) while still forcing customization where it matters.

---

### @factory (meta)

Why: Construction semantics are part of your API. This must create a new instance (or return `null`), not a hidden singleton.

When: Builders, clone/factory helpers, Flutter widget factories.

```dart
class LoggerFactory {
  @factory // Always returns a new Logger instance
  static Logger createLogger(String destination) => Logger(destination);
}
```

or [DartPad Example](https://gist.github.com/tsinis/05d900047495d8b2adc1824eec66e206)

> [!NOTE]
> This acts as a guardrail: if shared instances sneak in during refactors, the analyzer will nudge you back.

---

### @nonVirtual (meta)

Why: Freeze critical behavior. Prevent subclasses from changing invariants.

When: Equality/hashCode, protocol version getters, logging gates, security checks.

```dart
class Entity {
  @nonVirtual
  int get schemaVersion => 3;

  @nonVirtual
  bool get isPersisted => _id != null;
  int? _id;
}
```

or [DartPad Example](https://gist.github.com/tsinis/55a672b2d832aba8a0d56a0e74b4d6cc)

> [!TIP]
> Combine with `@mustCallSuper` on mutation points to tightly control state transitions.

---

### @mustBeConst (meta, experimental)

Why: Some utilities must accept compile‑time constants, not runtime values.

When: Compile‑time lookups, const‑driven config, string validators that rely on const‑eval.

```dart
bool isPremium(@mustBeConst String flag) => flag == 'PREMIUM';

const u = 'PREMIUM';
final r = DateTime.now().toString();
void checkFlags() {
  isPremium(u); // OK
  isPremium(r); // Error: not const
}
```

or [DartPad Example](https://gist.github.com/tsinis/75b40e6f85680ae6cf604e65f8eefa4c)

> [!NOTE]
> Overrides don't inherit this requirement — re‑annotate in subclasses to keep the contract.

---

### @redeclare (meta, experimental)

Why: Make it explicit that an extension type intentionally redeclares a superinterface member.

When: Extension types implementing common protocols with specialized semantics.

```dart
extension type NonNegInt(int value) implements Comparable<int> {
  @redeclare
  int compareTo(int other) => value.compareTo(other);
}
```

or [DartPad Example](https://gist.github.com/tsinis/427fbd19ef50b18544a21e18adae903b)

> [!TIP]
> Helps tools keep your intent tied to interface changes across versions.

---

## Visibility & API Design

### @internal (meta)

Why: "Package‑private" by convention. External use is possible, but tools will warn.

When: Implementation details, helpers, mini‑framework guts.

```dart
@internal
class ParseCursor {/* ... */}
```

or [DartPad Example](https://gist.github.com/tsinis/1ec2311b4fd7b9ee159ceb12d3024467)

> [!TIP]
> If downstream packages depend on `@internal` APIs, you'll see warnings during review — avoid accidental public contracts.

---

### @protected (meta)

Why: For subclass/library use and on this instance only. Encourages safe extension points.

When: Subclass hooks and internal helpers.

```dart
class Bloc {
  @protected
  void notify() {/*...*/}
}

class UserBloc extends Bloc {
  void load() => notify(); // ok
}

// Outside library: Bloc().notify(); // warn
```

or [DartPad Example](https://gist.github.com/tsinis/fb5cb02ccbf114f16c8eb738453cf833)

> [!NOTE]
> Also prevents calling protected members on other instances outside the library.

---

### @visibleForOverriding (meta)

Why: Public for override, not for direct use. Communicate "hook only".

When: Template method pattern for end‑user subclassing.

```dart
class Parser {
  @visibleForOverriding
  void onToken(String t) {}
}
// Users: subclass Parser and override onToken; don't call it directly.
```

or [DartPad Example](https://gist.github.com/tsinis/223b11ac287876493a03815f704d3796)

> [!TIP]
> Pair with `@nonVirtual` on siblings you don't want changed to draw a crisp override surface.

---

### @visibleForTesting (meta)

Why: Expose just enough for tests without endorsing production use.

When: Reset hooks, state peeks, determinism toggles.

```dart
@visibleForTesting
void resetSingletons() {/*...*/}
```

or [DartPad Example](https://gist.github.com/tsinis/cb1f9c4311facfbd343ccbaaa61a0ce2)

> [!TIP]
> Public but "test‑scoped" intent — makes review faster by flagging accidental production calls.

---

## Const & Construction

### @immutable (meta)

Why: Enforce final fields across the hierarchy. Value semantics, safer reuse, easier equality.

When: Value types, Flutter widgets, config objects.

```dart
@immutable
class Point {
  final double x, y;
  const Point(this.x, this.y);
}
```

or [DartPad Example](https://gist.github.com/tsinis/801ff25832dac3ff87027de6276695b1)

> [!NOTE]
> Subclasses must also be immutable. Mutability can't sneak in lower down.

---

### @literal (meta)

Why: Require const invocation for const constructors when possible. Keep instances canonical.

When: Tokens, interned IDs, const config.

```dart
class Tag {
  @literal
  const Tag(this.name);
  final String name;
}

const a = Tag('alpha'); // canonical
```

or [DartPad Example](https://gist.github.com/tsinis/4e0ca7cc77876bc84d3d958f5bf63eac)

> [!TIP]
> Prevent accidental runtime allocation of something that should be const.

---

### @optionalTypeArgs (meta)

Why: Allow generic classes to be used without explicit type arguments when strict analysis is enabled.

When: APIs where type inference usually works, avoiding noisy generics at call sites.

```dart
// Without annotation - triggers strict_raw_type warnings
class Serializer<T> {
  String serialize(T data) => data.toString();
}

@optionalTypeArgs // Allows raw usage even with strict analysis
class FriendlySerializer<T> {
  String serialize(T data) => data.toString();
}

void example() {
  final strict = Serializer(); // Warning: strict_raw_type
  final friendly = FriendlySerializer(); // OK
}
```

or [DartPad Example](https://gist.github.com/tsinis/867339a96acc4355318ecf331a4f6007)

> [!TIP]
> Great transitional tool when adding generics to pre‑generic APIs.

---

## Result & Resource Usage

### @awaitNotRequired (meta)

Why: Fire‑and‑forget by design. Suppress unawaited Future lints at call sites.

When: Logging, analytics, background warmups.

```dart
@awaitNotRequired
Future<void> log(String message) async {
  // enqueue in background
}

void main() {
  log('hello'); // allowed to drop
}
```

or [DartPad Example](https://gist.github.com/tsinis/758cf11dec0ff5cbeff8c14798760f61)

> [!NOTE]
> You can annotate Future‑typed fields and top‑level variables too, not just functions.

---

### @doNotStore (meta)

Why: Value is ephemeral or sensitive; caching is harmful.

When: Nonces, one‑time tokens, IO handles.

```dart
// Annotated: the returned value must not be stored (in fields, top-level vars).
@doNotStore
String newCsrfToken() => DateTime.now().microsecondsSinceEpoch.toString();

// Non-annotated: a stable identifier that is safe to cache.
String stableUserId() => 'user-123';

final cachedTokenGood = stableUserId(); // No analyzer warning.
final cachedTokenWrong = newCsrfToken(); // Warning: assignment_of_do_not_store
```

or [DartPad Example](https://gist.github.com/tsinis/7e38e8e3246b97d92f7fdef628971a43)

> [!TIP]
> If a method passes through a `@doNotStore` value, annotate the pass‑through too to keep the contract alive.

---

### @doNotSubmit (meta)

Why: Dev‑only flags and helpers should never land in main.

When: Local experiments, test skips, trace toggles.

```dart
void test(String name, void Function() body, {@doNotSubmit bool skip = false}) {
  // ...
}

void main() {
  test('ok', () {});
  test('tmp', () {}, skip: true); // remove before commit
}
```

or [DartPad Example](https://gist.github.com/tsinis/cb59d35317b9e0c46f6db863cc3860a8)

> [!NOTE]
> Useful in CI to catch "forgot to remove debug flag."

---

### @useResult (meta)

Why: Dropping the result is almost always a bug.

When: Validators, transforms, error‑carrying types, builders returning new instances.

```dart
class Sanitizer {
  @useResult
  String cleaned(String s) => s.trim();
}

void main() {
  final s = Sanitizer();
  // s.cleaned(' x '); // warn
  final c = s.cleaned(' x ');
}
```

or [DartPad Example](https://gist.github.com/tsinis/32e3c23f17e7fec603217cfafc431d88)

> [!TIP]
> Use `UseResult.unless(parameterDefined: 'sink')` to allow "safe to ignore if you provided a sink/callback" patterns.

---

## Testing Aids

### @isTest / @isTestGroup (meta)

Why: Custom test DSLs still get IDE "run" affordances and discovery.

When: Wrapping or extending test frameworks.

```dart
@isTest
void it(String name, Future<void> Function() body) => test(name, body);

@isTestGroup
void describe(String name, void Function() body) => group(name, body);
```

or [DartPad Example](https://gist.github.com/tsinis/939d4618ae2e54441b09bf6ad2f82805)

> [!NOTE]
> Keep your expressive DSL and preserve tooling integration.

---

## Experimental & Versioning

### @deprecated (core)

Why: Warn and guide. Keep momentum while users migrate.

When: Replacing or removing APIs.

```dart
@Deprecated('Use NewApi.v2')
void oldApi() {}
```

or [DartPad Example](https://gist.github.com/tsinis/4eea5d99d88ab0408d069b0a37829975)

> [!TIP]
> Deprecating at the library level cascades to members — one change can cover a broad surface.

---

### @experimental (meta)

Why: Be explicit that this public API might change or vanish.

When: Early designs, preview features.

```dart
@experimental
class NewRenderer {/*...*/}
```

or [DartPad Example](https://gist.github.com/tsinis/fd0e5f061a7210747ca92fe516a725e3)

> [!NOTE]
> Combine with `@internal` to keep experiments visible inside your package without committing publicly.

---

### @reopen (meta)

Why: Intentionally reopen inheritance where lints would complain. Document the intent.

When: Generated code, staged API stabilization.

```dart
@reopen
class Extensible {}
```

or [DartPad Example](https://gist.github.com/tsinis/608851aa60a21e96cc87b533fb2ef59e)

> [!TIP]
> Useful when accepting constraints from superinterfaces but still allowing downstream extension.

---

## Performance & Tooling Pragmas

### @RecordUse (meta, experimental)

Why: Record statically resolved invocations for post‑compile tooling and analysis.

When: Build‑time analytics, codegen, instrumentation.

```dart
@RecordUse()
void tracked() {/*...*/}
// Calls to tracked() are recorded for tooling steps.
```

or [DartPad Example](https://gist.github.com/tsinis/38dfa4dc5270374262398a0596c69c7e)

> [!NOTE]
> Can be combined with `@mustBeConst` on select parameters to keep post‑compile data const‑safe.

---

### @pragma (core)

Why: Toolchain hint for the VM/compiler. Use only when you know the exact pragma and its implications.

When: VM entry points, interop boundaries, perf tuning.

```dart
@pragma('vm:entry-point')
void keepMe() {}
```

or [DartPad Example](https://gist.github.com/tsinis/d818a6c9e4bba7f8305db85b6ee4f42e)

> [!WARNING]
> Pragmas are not general API annotations; they're instructions to specific tools/runtimes. For a deeper tour of VM pragmas, see Dart VM-Specific Pragma Annotations (mrale.ph) , and the general metadata overview on dart.dev .

---

## Bonus: Dart Code Metrics Annotations

### @Throws (DCM)

Why: Make throwing behavior explicit. Call sites must handle declared exceptions; declarations should truthfully advertise throws.

When: Public APIs that can throw (parsers, IO, validation) and you want consumers to catch or propagate deliberately.

```dart
@Throws({FormatException})
int parsePort(String env) {
  if (env.isEmpty) throw const FormatException('PORT is empty');
  return int.parse(env);
}
```

> [!NOTE]
> With DCM enabled, unhandled invocations of `@Throws` APIs are flagged, and throwers not annotated are suggested to add `@Throws`.

---

### @AcceptedTypes (DCM)

Why: Document and enforce allowed runtime types when a field/parameter is typed as `Object`.

When: Bridging dynamic sources (JSON, message channels, env/config) where only a safe subset of types is valid.

```dart
void logValue(@AcceptedTypes({String, int}) Object value) {}
logValue(true); // flagged by DCM
```

> [!TIP]
> Prefer precise static types when possible; use `@AcceptedTypes` only for unavoidable `Object` surfaces.

---

## Overriding Annotations Compared

For quick decision‑making:

| Annotation       | Intent                             | Analyzer behavior         | Typical use                          |
| ---------------- | ---------------------------------- | ------------------------- | ------------------------------------ |
| mustCallSuper    | Overrides must call super          | Warns if super not called | Lifecycle (init/dispose), invariants |
| mustBeOverridden | Concrete subclasses must implement | Error if missing          | Framework hooks, contracts           |
| nonVirtual       | Disallow overriding                | Error on override attempt | Lock invariants, equality            |

---

## Wrap‑up and next steps

Annotations are tiny but powerful. They turn implicit intentions into explicit contracts, and enlist the analyzer and tooling to keep your codebase honest during refactors. If you're new to Dart, start by consistently using `@override`, `@immutable`, and `@deprecated`. As your codebase grows, layer in `@mustCallSuper`, `@useResult`, `@protected`, and `@visibleForTesting` to make APIs safer and clearer. Reach for pragmas sparingly and deliberately.

Further reading if you want the official details:

- Metadata | Dart: <https://dart.dev/language/metadata>
- Dart VM-Specific Pragma Annotations: <https://mrale.ph/dartvm/pragmas.html>

## How to check those examples locally?

Some examples rely on analyzer and linter behavior that DartPad doesn't support (custom `analysis_options.yaml`, DCM rules, stricter inference). To see all the warnings/hints the cheat sheet talks about, run it in your IDE.
Clone this project and enter it:

```shell
git clone https://github.com/tsinis/tips-and-tricks
cd tips-and-tricks/dart/annotations-cheat-sheet
dart pub get
```

Open in your IDE (e.g., VS Code):

```shell
code .
```

Analyze/Run any example file:

```shell
dart analyze lib/factory.dart
dart run lib/throws.dart
```
