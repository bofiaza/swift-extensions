# Changelog

All notable changes to this project are documented here.
The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and the project uses [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added
- Swift Package Manager support with `SwiftExtensionsFoundation` and `SwiftExtensionsSwiftUI` products.
- `View.applyIf(_:transform:)`, a simpler conditional modifier.
- `Optional<URL>.isNilOrBlank`.
- Unit tests for the Foundation target, and a CI workflow (macOS and Linux).

### Changed
- **Breaking:** `Predicate<Input>` is renamed to `Condition<Input>` and `StubDefaults.predicate(_:)` to
  `StubDefaults.condition(_:)`, to avoid clashing with Foundation's `Predicate`.
- `Text.withTextAttribute(_:)` returns `Text` instead of `some View`, so styled texts can be concatenated,
  and uses `foregroundStyle` where available.
- `Optional.or(_:)` evaluates its default lazily and rethrows.
- `URL.blank` is a stored constant.
- `StubDefaults` closures are computed properties, so they compile under Swift 6 strict concurrency.
- `applyGlassEffect` checks all platform versions and only compiles the effect with Swift 6.2+.

### Deprecated
- `View.applyIf(_:_:apply:)`; capture the value in the closure and use `applyIf(_:transform:)`.
