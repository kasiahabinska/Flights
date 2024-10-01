import SwiftUI

struct ContentView: View {    
    @State private var type: FlightType = .roundTrip
    @State private var origin: String = ""
    @State private var destination: String = ""
    @State private var from: Date = Date()
    @State private var to: Date = Date()
    @State private var selectedTab: Int = 0
    @State private var departures: [MultiCity] = [MultiCity()]

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack {
                    Picker("Flight type", selection: $type) {
                        ForEach(FlightType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    Form {
                        FlightDetails(type: $type,
                                      origin: $origin,
                                      destination: $destination,
                                      from: $from,
                                      to: $to,
                                      departures: $departures)
                    }
                    
                    
                    
                }
            }
            .tabItem {
                Image(systemName: "airplane")
                Text("Flights")
            }
            .tag(0)

            MapView()
                .tabItem {
                    Image(systemName: "mappin")
                    Text("Destinations")
                }
                .tag(1)

            HotelView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Accommodation")
                }
                .tag(2)
        }
    }
}



    






