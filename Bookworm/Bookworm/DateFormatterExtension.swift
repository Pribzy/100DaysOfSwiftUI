import Foundation

extension DateFormatter {

    // MARK: - Date formats
    private enum Format: String {
        case yearMonthDayWithDot = "yyyy.MM.dd"
        case yearMonthDayWithLine = "yyyy-MM-dd"
        case yearMonthDayWithoutSeparator = "yyyyMMdd"
        case yearMonthDayHourMinute = "yyyy-MM-dd HH:mm"
        case yearMonthDayHourMinuteSecond = "yyyy.MM.dd HH:mm:ss"
        case parsable = "yyyy-MM-dd'T'HH:mmZ"
        case fileLogger = "yyyyMMdd-HHmm"
    }

    // MARK: - Formatters
    @objc static let yearMonthDayWithDot: DateFormatter = {
        return make(for: .yearMonthDayWithDot)
    }()
    @objc static let yearMonthDayWithLine: DateFormatter = {
        return make(for: .yearMonthDayWithLine)
    }()
    @objc static let yearMonthDayWithoutSeparator: DateFormatter = {
        return make(for: .yearMonthDayWithoutSeparator)
    }()
    @objc static let yearMonthDayHourMinute: DateFormatter = {
        return make(for: .yearMonthDayHourMinute)
    }()
    @objc static let yearMonthDayHourMinuteSecond: DateFormatter = {
        return make(for: .yearMonthDayHourMinuteSecond)
    }()
    @objc static let parsable: DateFormatter = {
        return make(for: .parsable)
    }()
    @objc static let fileLogger: DateFormatter = {
        return make(for: .fileLogger)
    }()

    // MARK: - Private functions
    private static func make(for format: Format) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter
    }
}
