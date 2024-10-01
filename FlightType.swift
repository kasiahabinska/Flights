import SwiftUI

enum FlightType: String, CaseIterable, Identifiable {
    case roundTrip = "Round trip"
    case oneWay = "One way"
    case multiCity = "Multi-city"
    
    var id: String { rawValue }
}
