import SwiftUI

struct MultiCity: Identifiable {
    var id = UUID()
    var origin: String = ""
    var destination: String = ""
    var date: Date = Date()
}
