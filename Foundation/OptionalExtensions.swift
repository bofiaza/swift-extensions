import Foundation

// MARK: - Optional Extensions
extension Optional {
    
    /// Returns the wrapped value if the optional is non-`nil`; otherwise, returns the provided default value.
    ///
    /// - Parameter defaultValue: The value to return if the optional is `nil`.
    /// - Returns: The unwrapped value, or `defaultValue` if the optional is `nil`.
    ///
    /// ### Example
    /// ```swift
    /// let username: String? = nil
    /// print(username.or("Guest")) // Prints "Guest"
    ///
    /// let score: Int? = 42
    /// print(score.or(0)) // Prints "42"
    ///
    /// let isEnabled: Bool? = nil
    /// print(isEnabled.or(true)) // Prints "true"
    ///
    /// let items: [String]? = []
    /// print(items.or(["Default Item"])) // Prints []
    /// ```
    public func or(_ defaultValue: Wrapped) -> Wrapped {
        self ?? defaultValue
    }
}

// MARK: - Optional<URL> Extensions
extension Optional where Wrapped == URL {
    
    /// Returns the URL if non-`nil`, otherwise returns a blank URL (`about:blank`).
    ///
    /// - Returns: The unwrapped URL, or `URL.blank` if the optional is `nil`.
    ///
    /// ### Example
    /// ```swift
    /// let url: URL? = nil
    /// print(url.orBlank) // Prints "about:blank"
    ///
    /// let website: URL? = URL(string: "https://example.com")
    /// print(website.orBlank) // Prints "https://example.com"
    /// ```
    public var orBlank: URL {
        self ?? .blank
    }
    
    /// Indicates whether the optional URL is non-nil and not blank.
    ///
    /// - Returns: `true` if the optional contains a URL and it is not `about:blank`; otherwise, `false`.
    ///
    /// ### Example
    /// ```swift
    /// let url1: URL? = URL(string: "https://example.com")
    /// print(url1.isNotBlank) // true
    ///
    /// let url2: URL? = nil
    /// print(url2.isNotBlank) // false
    ///
    /// let url3: URL? = URL.blank
    /// print(url3.isNotBlank) // false
    /// ```
    public var isNotBlank: Bool {
        return self?.isNotBlank ?? false
    }
}
