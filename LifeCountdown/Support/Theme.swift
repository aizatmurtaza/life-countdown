import SwiftUI

enum Theme {
    static let paper = Color(red: 244 / 255, green: 240 / 255, blue: 232 / 255)
    static let surface = Color(red: 251 / 255, green: 248 / 255, blue: 241 / 255)
    static let surfaceSoft = Color(red: 238 / 255, green: 232 / 255, blue: 221 / 255)
    static let ink = Color(red: 36 / 255, green: 35 / 255, blue: 31 / 255)
    static let muted = Color(red: 119 / 255, green: 113 / 255, blue: 102 / 255)
    static let line = Color(red: 36 / 255, green: 35 / 255, blue: 31 / 255).opacity(0.12)
    static let track = Color(red: 36 / 255, green: 35 / 255, blue: 31 / 255).opacity(0.11)
    static let fill = Color(red: 53 / 255, green: 50 / 255, blue: 44 / 255)

    static let display = Font.Design.serif
}
