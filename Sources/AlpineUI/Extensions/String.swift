//
//  String.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 11/23/22.
//

import Foundation

public extension String {
    
    private enum LocationType {
        case lat
        case long
    }
    
    /// Inserts a space before each uppercase letter and capitalizes each word.
    var separated: String {
        self
            .replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
    
    /// Escapes single quotes for use in PostgreSQL.
    var postgresEscaped: String {
        return replacingOccurrences(of: "'", with: "''")
    }
    
    /// Converts the string to a `UUID`.
    /// - Returns: A `UUID` instance if the string is a valid UUID, otherwise `nil`.
    func toUUID() -> UUID? {
        return UUID(uuidString: self)
    }
    
    /// Converts the string to a `Float`.
    /// - Returns: A `Float` value. If the conversion fails, returns `0`.
    func toFloat() -> Float {
        return (Float(self) ?? 0)
    }
    
    /// Converts the string to an `Int`.
    /// - Returns: An `Int` value if the conversion is successful, otherwise `nil`.
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
    
    /// Converts the string to a `Bool`.
    /// - Returns: `true` if the string is not empty or does not start with 0, F, N, f, n. Otherwise, returns `false`.
    func toBool() -> Bool {
        switch self.trimmingCharacters(in: .whitespacesAndNewlines).prefix(1) {
        case "0", "F", "N", "f", "n", "":
            return false
        default:
            return true
        }
    }
    
    /// Converts the string to a JSON object.
    /// - Returns: A JSON object if the conversion is successful, otherwise `nil`.
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    /// Trims and removes extra whitespace from the string.
    /// - Returns: A trimmed string without extra whitespace, or `nil` if the result is empty.
    func trimName() -> String? {
        let regexExtraWS = try! NSRegularExpression(pattern: "\\s{2,}")
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let result = regexExtraWS.stringByReplacingMatches(in: trimmedString, options: [], range: NSRange(location: 0, length: trimmedString.count), withTemplate: "")
        return result.isEmpty ? nil : result
    }
    
    /// Returns the file name without extension from the string path.
    /// - Returns: The file name without extension.
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    /// Returns the file extension from the string path.
    /// - Returns: The file extension.
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
    
    /// Returns the file name with extension from the string path.
    /// - Returns: The file name with extension.
    func fileNameWithExt() -> String {
        return URL(fileURLWithPath: self).lastPathComponent
    }
    
    /// Compares two version strings.
    /// - Parameter otherVersion: The version string to compare with.
    /// - Returns: The comparison result.
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."
        
        var versionComponents = self.components(separatedBy: versionDelimiter)
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)
        
        let zeroDiff = versionComponents.count - otherVersionComponents.count
        
        if zeroDiff == 0 {
            return self.compare(otherVersion, options: .numeric)
        } else {
            let zeros = Array(repeating: "0", count: abs(zeroDiff))
            if zeroDiff > 0 {
                otherVersionComponents.append(contentsOf: zeros)
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                .compare(otherVersionComponents.joined(separator: versionDelimiter), options: .numeric)
        }
    }
    
    /// Converts the string to a date with the given format.
    /// - Parameter format: The date format.
    /// - Returns: A `Date` instance if the conversion is successful, otherwise `nil`.
    func toDate(format: String) -> Date? {
        var f = format
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        var v = self.replace(target: " AM", withString: "")
        if format == "MM/dd/yyyy" {
            f = "MM/dd/yyyy HH:mm"
            v = self + " 00:00";
        }
        dateFormatter.dateFormat = f
        let date = dateFormatter.date(from: v)
        return date
    }
    
    /// Converts the string to a date using RFC-3339 format.
    /// - Returns: A `Date` instance if the conversion is successful, otherwise `nil`.
    func wwwToDate() -> Date? {
        let RFC3339DateFormatter = ISO8601DateFormatter()
        // Note: returns nil if .withFractionalSeconds option and string doesn't have "s.sss" second fraction.
        RFC3339DateFormatter.formatOptions = self.contains(".") ? [.withFractionalSeconds, .withInternetDateTime] : [.withInternetDateTime]
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = RFC3339DateFormatter.date(from: self)
        return date
    }
    
    /// Returns the initials of the string.
    /// - Returns: A string containing the initials.
    func initials() -> String {
        var res = ""
        for comp in self.components(separatedBy: [".", " "]) {
            res = res + (comp.isEmpty ? "" : "\(comp.first?.uppercased() ?? "")")
        }
        return res
    }
    
    /// Converts coordinates to a displayable string.
    /// - Parameters:
    ///   - longitude: The longitude.
    ///   - latitude: The latitude.
    /// - Returns: A formatted string representing the coordinates.
    static func coordinateToDisplayText(longitude: Double, latitude: Double) -> String {
        if latitude == 0 && longitude == 0 {
            return ""
        }
        let NS = latitude  >= 0 ? Character("N") : Character("S")
        let EW = longitude >= 0 ? Character("E") : Character("W")
        let lat = abs(latitude)
        let lon = abs(longitude)
        
        return String(format:"% 9.5f°\(NS)%  10.5f°\(EW)", lat, lon)
    }
    
    /// Converts latitude and longitude to WGS format.
    /// - Parameters:
    ///   - lat: The latitude as a string.
    ///   - long: The longitude as a string.
    /// - Returns: A formatted string representing the coordinates in WGS format.
    static func locationWGS(lat: String?, long: String?) -> String {
        guard let lat = lat, let long = long else {
            return ""
        }
        
        let splitLat = lat.split(separator: ".")
        if splitLat.count != 2 { return "" }
        
        let splitLong = long.split(separator: ".")
        if splitLong.count != 2 { return "" }
        
        let (latPrefix, latSuffix) = convertToWGS(splitLat[0], type: .lat)
        let (longPrefix, longSuffix) = convertToWGS(splitLong[0], type: .long)
        
        return String(latPrefix + "." + splitLat[1].prefix(4) + latSuffix) + " " + String(longPrefix + "." + splitLong[1].prefix(4) + longSuffix)
    }
    
    /// Converts a coordinate to WGS format.
    /// - Parameters:
    ///   - location: The coordinate as a substring.
    ///   - type: The type of the coordinate (latitude or longitude).
    /// - Returns: A tuple containing the formatted coordinate and its suffix.
    static private func convertToWGS(_ location: String.SubSequence, type: LocationType) -> (String.SubSequence, String) {
        var localLocation = location
        
        switch type {
        case .lat:
            if location.first == "-" {
                localLocation.remove(at: localLocation.startIndex)
                return (localLocation, "°S")
            }
            return (localLocation, "°N")
        case .long:
            if location.first == "-" {
                localLocation.remove(at: localLocation.startIndex)
                return (localLocation, "°W")
            }
            return (localLocation, "°E")
        }
    }
    
    
    /// Splits the string into a 2D array using a CSV delimiter.
    /// - Parameter delimiter: The delimiter for the CSV.
    /// - Returns: A 2D array of strings.
    func csv(delimiter: String) -> [[String]] {
        var result: [[String]] = []
        
#if true // T=use new "\r" "\r\n" "\n" row delimiter, F=old way of just "\r".
        // The incoming .csv files may use different delimiter for lines/rows: "\n" (all quality OS's use) or "\r\n" (that third rate junk), or "\r" (wtf). To resolve this start with the lowest common denominator (windows/dos/cpm) and translate "\r\n" -> "\n", "\n\r" to over compensate for the awesome quality windows is, then "\r" -> "\n". Then separate components by "\n".
        
        let s1 = self.replacingOccurrences(of: "\r\n", with: "\n").replacingOccurrences(of: "\n\r", with: "\n").replacingOccurrences(of: "\r", with: "\n")
        let rows = s1.components(separatedBy: "\n")
#else // else original way
        let rows = self.components(separatedBy: "\r")
#endif
        
        for row in rows {
            let columns = row.components(separatedBy: delimiter)
            var tempColumns: [String] = []
            for var column in columns {
                column = column.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
                // column = String(column.f ..filter { !"\n\t\r".characters.contains($0) })
                tempColumns.append(column)
            }
            result.append(tempColumns)
        }
        return result
    }
    
    
    /// Returns a substring from the specified start index.
    /// - Parameter from: The start index.
    /// - Returns: The substring from the specified start index.
    func substring(from: Int) -> String {
        guard self.count > from else { return "" }
        return String(self[self.index(self.startIndex, offsetBy: from)...])
    }
    
    /// Returns a substring using the specified `NSRange`.
    /// - Parameter nsRange: The `NSRange` for the substring.
    /// - Returns: The substring if the range is valid, otherwise `nil`.
    func substring(nsRange: NSRange) -> String? {
        if nsRange.location == NSNotFound {
            return ""
        }
        let string = self.utf16 // NSString/NSRange is 16 bit chars
        let start = string.index(string.startIndex, offsetBy: nsRange.location)
        let end = string.index(start, offsetBy: nsRange.length)
        let substr = string[start..<end]
        return String(substr)
    }
    
    /// Returns a substring from the left side with the specified count.
    /// - Parameter count: The number of characters to include.
    /// - Returns: The left substring.
    func left(_ count: Int) -> String {
        let indexEndOfText = self.index(self.endIndex, offsetBy: -(self.count - count - 1))
        let substring = self[..<indexEndOfText]
        return String(substring)
    }
    
    /// Returns a substring from the right side with the specified count.
    /// - Parameter count: The number of characters to include.
    /// - Returns: The right substring.
    func right(_ count: Int) -> String {
        let indexStartOfText = self.index(self.startIndex, offsetBy: count + 2)
        let substring = self[indexStartOfText...]  // "Hello>>>"   // "<<<Hello"
        return String(substring)
    }
    
    /// Returns a middle substring starting from the specified index and with the specified count.
    /// - Parameters:
    ///   - first: The start index.
    ///   - count: The number of characters to include.
    /// - Returns: The middle substring.
    func middle(first: Int, count: Int) -> String {
        let indexStartOfText = self.index(self.startIndex, offsetBy: first)
        let indexEndOfText = self.index(self.endIndex, offsetBy: -(self.count - count - 1))
        let substring = self[indexStartOfText..<indexEndOfText]
        return String(substring)
    }
    
    // MARK: - Private Methods
    
    /// Replaces occurrences of a target string with another string.
    /// - Parameters:
    ///   - target: The target string to replace.
    ///   - withString: The replacement string.
    /// - Returns: A new string with the target replaced by the replacement.
    private func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
