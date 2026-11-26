import SwiftUI

extension View {
    
    /// Conditionally applies a transformation to this view.
    ///
    /// ### Example
    /// ```swift
    /// Text("Hello, world!")
    ///     .applyIf(isHighlighted) { view in
    ///         view.font(.title)
    ///     }
    /// ```
    ///
    /// - Important: The two branches produce different view types, so SwiftUI treats them
    ///   as different views. When `condition` changes at runtime, the view's `@State` is
    ///   reset and the change is not animated. For values that change often, prefer passing
    ///   the condition into the modifier itself, e.g. `.opacity(isHidden ? 0 : 1)`.
    ///
    /// - Parameters:
    ///   - condition: A Boolean value that determines whether the transformation is applied.
    ///   - transform: A closure that takes the current view and returns a modified view.
    /// - Returns: The transformed view if `condition` is `true`; otherwise, the original view.
    @ViewBuilder
    public func applyIf(
        _ condition: Bool,
        transform: (Self) -> some View
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Conditionally applies a transformation to this view, passing an extra value.
    ///
    /// - Parameters:
    ///   - condition: A Boolean value that determines whether the transformation is applied.
    ///   - value: A value to pass into the transformation closure.
    ///   - apply: A closure that takes the current view and the provided value,
    ///            returning a modified view.
    /// - Returns: The transformed view if `condition` is `true`; otherwise, the original view.
    @available(*, deprecated, message: "Capture the value in the closure and use applyIf(_:transform:) instead.")
    @ViewBuilder
    public func applyIf<T, V: View>(
        _ condition: Bool,
        _ value: T,
        apply: (Self, T) -> V
    ) -> some View {
        if condition {
            apply(self, value)
        } else {
            self
        }
    }
    
    /// Conditionally applies a view modifier only when an optional value is non-`nil`.
    ///
    /// This helper is useful when a modifier (such as accessibility or styling modifiers)
    /// requires a non-optional value, but the data driving it is optional.
    /// If the value is `nil`, the original view is returned unchanged.
    ///
    /// - Parameter value: An optional value that determines whether the modifier is applied.
    /// - Parameter apply: A closure that takes the original view and the unwrapped value,
    ///   and returns a modified view.
    /// - Returns: Either the modified view (if `value` is non-`nil`) or the original view.
    ///
    /// - Important: As with `applyIf(_:transform:)`, switching between `nil` and non-`nil`
    ///   at runtime changes the view's identity, resetting its `@State` and skipping animations.
    ///
    /// ### Example
    /// ```swift
    /// Text("Hello")
    ///     .applyIf(accessibilityId) { view, id in
    ///         view.accessibilityIdentifier(id)
    ///     }
    /// ```
    @ViewBuilder
    public func applyIf<T>(
        _ value: T?,
        apply: (Self, T) -> some View
    ) -> some View {
        if let value {
            apply(self, value)
        } else {
            self
        }
    }
    
    /// Conditionally applies a glass effect to this view if enabled and supported by the OS version.
    ///
    /// The effect is only compiled in with a Swift 6.2+ compiler (Xcode 26 SDKs), so the
    /// package still builds with older toolchains. On visionOS the view is returned unchanged.
    ///
    /// - Parameter enabled: A Boolean value indicating whether to apply the glass effect.
    /// - Returns: Either the original view if `enabled` is false or the current OS version does not support `glassEffect()`,
    ///            or the view with `glassEffect()` applied.
    @ViewBuilder
    public func applyGlassEffect(_ enabled: Bool) -> some View {
        #if compiler(>=6.2) && !os(visionOS)
        if enabled, #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            self.glassEffect()
        } else {
            self
        }
        #else
        self
        #endif
    }
}
