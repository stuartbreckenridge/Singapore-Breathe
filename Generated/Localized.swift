// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10N {
  /// Dismiss
  internal static let apiErrorDismiss = L10N.tr("Localizable", "API_ERROR_DISMISS")
  /// No data was returned by the API. Please try later.
  internal static let apiErrorNoData = L10N.tr("Localizable", "API_ERROR_NO_DATA")
  /// There was an error retrieving updated air quality data. %@ Please try later.
  internal static func apiErrorOther(_ p1: Any) -> String {
    return L10N.tr("Localizable", "API_ERROR_OTHER", String(describing: p1))
  }
  /// API Error
  internal static let apiErrorTitle = L10N.tr("Localizable", "API_ERROR_TITLE")
  /// Central
  internal static let central = L10N.tr("Localizable", "CENTRAL")
  /// East
  internal static let east = L10N.tr("Localizable", "EAST")
  /// Good
  internal static let good = L10N.tr("Localizable", "GOOD")
  /// Hazardous
  internal static let hazardous = L10N.tr("Localizable", "HAZARDOUS")
  /// Moderate
  internal static let moderate = L10N.tr("Localizable", "MODERATE")
  /// National
  internal static let national = L10N.tr("Localizable", "NATIONAL")
  /// North
  internal static let north = L10N.tr("Localizable", "NORTH")
  /// Fine Particulate Matter
  internal static let pmFineLong = L10N.tr("Localizable", "PM_FINE_LONG")
  /// Particulate Matter
  internal static let pmLong = L10N.tr("Localizable", "PM_LONG")
  /// PM
  internal static let pmShort = L10N.tr("Localizable", "PM_SHORT")
  /// Pollutant Standards Index
  internal static let psiLong = L10N.tr("Localizable", "PSI_LONG")
  /// PSI
  internal static let psiShort = L10N.tr("Localizable", "PSI_SHORT")
  /// South
  internal static let south = L10N.tr("Localizable", "SOUTH")
  /// 24-Hourly
  internal static let time24 = L10N.tr("Localizable", "TIME_24")
  /// 8-Hourly
  internal static let time8 = L10N.tr("Localizable", "TIME_8")
  /// Hourly
  internal static let timeHourly = L10N.tr("Localizable", "TIME_HOURLY")
  /// 1-Hour Max
  internal static let timeOneMax = L10N.tr("Localizable", "TIME_ONE_MAX")
  /// Unhealthy
  internal static let unhealthy = L10N.tr("Localizable", "UNHEALTHY")
  /// Very Unhealthy
  internal static let veryUnhealthy = L10N.tr("Localizable", "VERY_UNHEALTHY")
  /// West
  internal static let west = L10N.tr("Localizable", "WEST")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10N {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
