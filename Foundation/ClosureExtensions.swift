import Foundation

// MARK: - Core Intents

typealias Action = () -> Void
/// ### Example
/// ```swift
/// struct Credentials {
///    let username: String
///    let password: String
/// }
///
/// typealias CredentialsHandler = Handler<Credentials>
/// ```
/// or
/// ```swift
/// typealias NameAgeHandler = Handler<(name: String, age: Int)>
/// ```
typealias Handler<Input> = (Input) -> Void

typealias Provider<Output> = () -> Output
typealias AsyncProvider<Output> = () async -> Output

typealias Mapper<Input, Output> = (Input) -> Output
typealias Predicate<Input> = (Input) -> Bool

// MARK: - Common

typealias Completion = Action
typealias ErrorHandler = Handler<Error>
typealias BoolHandler = Handler<Bool>

typealias BoolProvider = Provider<Bool>

// MARK: - Defaults

enum Defaults {
    
    // MARK: - Actions
    
    /// ### Example
    /// ```swift
    /// let completion: Completion = Defaults.action
    /// ```
    static let action: Action = {}
    
    static func handler<T>() -> Handler<T> {
        { _ in }
    }
    
    // MARK: - Providers
    
    static func value<T>(_ value: T) -> Provider<T> {
        { value }
    }
    
    static let trueProvider: BoolProvider = { true }
    static let falseProvider: BoolProvider = { false }
    
    // MARK: - Predicates
    
    /// ### Example
    /// ```swift
    /// let check: Predicate<String> = Defaults.predicate(true)
    /// ```
    static func predicate<T>(_ value: Bool = false) -> Predicate<T> {
        { _ in value }
    }
}
