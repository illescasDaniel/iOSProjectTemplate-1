// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Errors {
    internal enum Json {
      /// Json - Member not found for key "%@"
      internal static func memberNotFound(_ p1: String) -> String {
        return L10n.tr("Localizable", "**Errors.Json.memberNotFound", p1)
      }
      /// Json - Value "%@" is not an array
      internal static func valueIsNotAnArray(_ p1: String) -> String {
        return L10n.tr("Localizable", "**Errors.Json.valueIsNotAnArray", p1)
      }
    }
    internal enum UserDefaultsManager {
      internal enum Retrieve {
        /// UserDefaultsManager - Could not cast retrieved value (%@) to "%@"
        internal static func couldNotCast(_ p1: String, _ p2: String) -> String {
          return L10n.tr("Localizable", "**Errors.UserDefaultsManager.retrieve.couldNotCast**", p1, p2)
        }
        /// UserDefaultsManager - Key "%@" was not found
        internal static func keyNotFound(_ p1: String) -> String {
          return L10n.tr("Localizable", "**Errors.UserDefaultsManager.retrieve.keyNotFound**", p1)
        }
      }
      internal enum Set {
        /// UserDefaultsManager - "%@" is not a valid properyty list object type
        internal static func notAPropertyListObject(_ p1: String) -> String {
          return L10n.tr("Localizable", "**Errors.UserDefaultsManager.set.notAPropertyListObject**", p1)
        }
      }
    }
  }

  internal enum Test {
    /// Hi!!
    internal static let label = L10n.tr("Localizable", "**Test.Label**")
    /// Hi!
    internal static let label2 = L10n.tr("Localizable", "**Test.Label2**")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
