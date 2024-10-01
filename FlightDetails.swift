import SwiftUI
import Combine

struct FlightDetails: View {
    @Binding var type: FlightType
    @Binding var origin: String
    @Binding var destination: String
    @Binding var from: Date
    @Binding var to: Date
    @Binding var departures: [MultiCity]
    
    @ObservedObject var networkManager = NetworkManager.shared
    @State private var query = ""
    
    @State private var showDepartureDropdown = false
    @State private var showDestinationDropdown = false
    
    let airports = [
        Airport(iata: "AAK", icao: "NGUK", name: "Aranuka Airport", location: "Aranuka, Kiribati", time: "UTC+12:00", id: "eyJlIjoiMTI5MDU0NDg1IiwicyI6IkFBSyIsImgiOiI4MTk3NjA1MSIsInQiOiJBSVJQT1JUIn0=", skyId: "AAK"),
        Airport(iata: "ABP", icao: "", name: "Atkamba Airport", location: "Atkamba, Papua New Guinea", time: "UTC+10:00", id: nil, skyId: nil),
        Airport(iata: "AAA", icao: "NTGA", name: "Anaa Airport", location: "Anaa, Tuamotus, French Polynesia", time: "UTC−10:00", id: "eyJlIjoiMTI4NjY4MjQzIiwicyI6IkFBQSIsImgiOiI4MTk3NjE4NiIsInQiOiJBSVJQT1JUIn0=", skyId: "AAA"),
        Airport(iata: "OSL", icao: "ENGM", name: "Oslo lufthavn (Gardermoen)", location: "Oslo, Norway", time: "UCT+2:00", id: nil, skyId: nil)
    ]
    
    var body: some View {
        VStack {
            TextField("Departure Airport", text: $origin, onEditingChanged: { isEditing in
                showDepartureDropdown = isEditing
            })
            .textContentType(.none)
            .autocapitalization(.allCharacters)
            
            if showDepartureDropdown {
                airportList(text: origin, selectedAirport: $origin)
            }
            
            TextField("Destination Airport", text: $destination, onEditingChanged: { isEditing in
                showDestinationDropdown = isEditing
            })
            .textContentType(.none)
            .autocapitalization(.allCharacters)
            
            if showDestinationDropdown {
                airportList(text: destination, selectedAirport: $destination)
            }
                    
            DatePicker("Departure Date", selection: $from, displayedComponents: .date)
            
            switch type {
            case .roundTrip:
                DatePicker("Return Date", selection: $to, displayedComponents: .date)
                
            case .multiCity:
                ForEach($departures) { $city in
                    VStack {
                        TextField("Departure Airport", text: $city.origin)
                        TextField("Destination Airport", text: $city.destination)
                        DatePicker("Departure Date", selection: $city.date, displayedComponents: .date)
                        
                    }
                    .padding(.bottom)
                }
                
                Button(action: {
                    departures.append(MultiCity())
                }) {
                    Label("Add another destination", systemImage: "plus.circle.fill")
                }
                Button(action: {
                    departures.removeLast()
                }) {
                    Label("Remove last destination", systemImage: "minus.circle.fill")
                }
                
            default:
                EmptyView()
            }
        }
    }
    
    private func airportList(text: String, selectedAirport: Binding<String>) -> some View {
        List {
            ForEach(airports.filter {
                $0.iata.contains(text.uppercased()) ||
                $0.name.lowercased().contains(text.lowercased()) ||
                $0.location.lowercased().contains(text.lowercased())
            }, id: \.iata) { airport in
                Button(action: {
                    selectedAirport.wrappedValue = airport.name
                    showDepartureDropdown = false
                    showDestinationDropdown = false
                }) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(airport.name)
                                .font(.headline)
                                .lineLimit(1)
                            Spacer()
                        }
                        HStack {
                            Text("\(airport.location) (\(airport.iata))")
                                .font(.subheadline)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
            


        
        


