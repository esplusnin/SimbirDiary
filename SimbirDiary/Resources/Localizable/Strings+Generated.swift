// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum General {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "general.cancel", fallback: "Cancel")
    /// Date
    internal static let date = L10n.tr("Localizable", "general.date", fallback: "Date")
    /// Delete
    internal static let delete = L10n.tr("Localizable", "general.delete", fallback: "Delete")
    /// Done
    internal static let done = L10n.tr("Localizable", "general.done", fallback: "Done")
    /// Time
    internal static let time = L10n.tr("Localizable", "general.time", fallback: "Time")
  }
  internal enum NewTask {
    /// Description
    internal static let description = L10n.tr("Localizable", "newTask.description", fallback: "Description")
    /// Name
    internal static let name = L10n.tr("Localizable", "newTask.name", fallback: "Name")
    /// Select date
    internal static let selectDate = L10n.tr("Localizable", "newTask.selectDate", fallback: "Select date")
    /// Select time
    internal static let selectTime = L10n.tr("Localizable", "newTask.selectTime", fallback: "Select time")
    /// New Task
    internal static let title = L10n.tr("Localizable", "newTask.title", fallback: "New Task")
  }
  internal enum TaskDetail {
    /// Start date
    internal static let startDate = L10n.tr("Localizable", "taskDetail.startDate", fallback: "Start date")
    /// About the task
    internal static let title = L10n.tr("Localizable", "taskDetail.title", fallback: "About the task")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
