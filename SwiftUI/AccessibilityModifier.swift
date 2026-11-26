import SwiftUI

/// A view modifier that turns its content into an accessibility container
/// and optionally applies accessibility metadata to that container.
///
/// The container:
/// - Exposes an optional accessibility label, hint, and identifier
/// - Keeps its children individually accessible (`children: .contain`)
/// - Does not change layout or hit testing of the wrapped content
///
/// Use this when multiple child views should be grouped under a single
/// accessibility container while remaining fully discoverable.
struct ViewAccessibilityModifier: ViewModifier {
    
    private let label: String?
    private let hint: String?
    private let identifier: String?
    
    /// Initializes the modifier with optional accessibility information.
    ///
    /// - Parameters:
    ///   - label: An optional accessibility label describing the container.
    ///   - hint: An optional accessibility hint providing extra context.
    ///   - identifier: An optional accessibility identifier for UI testing.
    init(
        label: String?,
        hint: String?,
        identifier: String?
    ) {
        self.label = label
        self.hint = hint
        self.identifier = identifier
    }
    
    func body(content: Content) -> some View {
        content
            .accessibilityElement(children: .contain)
            .applyIf(label) { view, label in
                view.accessibilityLabel(label)
            }
            .applyIf(hint) { view, hint in
                view.accessibilityHint(hint)
            }
            .applyIf(identifier) { view, identifier in
                view.accessibilityIdentifier(identifier)
            }
    }
}

extension View {
    /// Wraps the view in an accessibility container with optional metadata.
    ///
    /// If at least one of `label`, `hint`, or `identifier` is provided, the view becomes
    /// an accessibility container that exposes this information to assistive technologies,
    /// while its children stay individually accessible.
    /// If all parameters are `nil`, the view is returned unchanged.
    ///
    /// - Parameters:
    ///   - label: Optional accessibility label for the container.
    ///   - hint: Optional accessibility hint for the container.
    ///   - identifier: Optional accessibility identifier for UI testing.
    /// - Returns: Either the view wrapped in an accessibility container or the original view.
    ///
    /// ### Example
    /// ```swift
    /// VStack {
    ///     Text("Title")
    ///     Text("Subtitle")
    /// }
    /// .applyAccessibilityInfo(
    ///     label: "Profile Information",
    ///     hint: "Displays the user’s profile details",
    ///     identifier: "profile_container"
    /// )
    /// ```
    @ViewBuilder
    public func applyAccessibilityInfo(
        label: String? = nil,
        hint: String? = nil,
        identifier: String? = nil
    ) -> some View {
        if label == nil && hint == nil && identifier == nil {
            self
        } else {
            modifier(
                ViewAccessibilityModifier(
                    label: label,
                    hint: hint,
                    identifier: identifier
                )
            )
        }
    }
}
