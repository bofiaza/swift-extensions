import SwiftUI

extension View {
    
    /// Conditionally applies a transformation to this view.
    ///
    /// This is useful when you want to apply a modifier or transformation
    /// only if a certain condition is true.
    ///
    /// Example:
    /// ```swift
    /// Text("Hello, world!")
    ///     .applyIf(true, 24) { view, fontSize in
    ///         view.font(.system(size: CGFloat(fontSize)))
    ///     }
    /// ```
    /// In this example, the font is increased to 24 points because the condition is `true`.
    ///
    /// - Parameters:
    ///   - condition: A Boolean value that determines whether the transformation is applied.
    ///   - value: A value to pass into the transformation closure.
    ///   - apply: A closure that takes the current view (`self`) and the provided value,
    ///            returning a modified view.
    ///
    /// - Returns: Either the original view if `condition` is false, or the transformed view if `condition` is true.
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
    /// ### Example:
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
    
    /// Conditionally applies a glass effect to this view if enabled and supported by the iOS version.
    ///
    /// - Parameter enabled: A Boolean value indicating whether to apply the glass effect.
    /// - Returns: Either the original view if `enabled` is false or the current iOS version does not support `glassEffect()`,
    ///            or the view with `glassEffect()` applied.
    @ViewBuilder
    public func applyGlassEffect(_ enabled: Bool) -> some View {
        if enabled, #available(iOS 26.0, *) {
            self.glassEffect()
        } else {
            self
        }
    }
}
