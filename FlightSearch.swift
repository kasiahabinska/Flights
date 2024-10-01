import SwiftUI
import Combine
import Foundation

enum NetworkError: Error {
    case badUrl, requestFailed, decodingError, unknown
}

struct AirportResponse: Codable {
    let data: [Airport]
    let status: Bool
    let message: String
}

struct Airport: Codable, Identifiable  {
    let iata: String
    let icao: String
    let name: String
    let location: String
    let time: String
    let id: String?
    let skyId: String?
    
    enum CodingKeys: String, CodingKey {
        case iata, icao, name, location, time, id, skyId
    }
}

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    
    @Published var airports: [Airport] = []
    @Published var errorMessage = ""
    
    private let apiKey = "17a002b937msh59b2d32b0364370p1a6eb0jsn3ed38acd8b07"
    private let baseURL = "https://sky-scanner3.p.rapidapi.com/flights/airports"
    
    func fetchSampleAirports() -> [Airport] {
        let sampleAirports = [
            Airport(iata: "AAA", icao: "NTGA", name: "Anaa Airport", location: "Anaa, Tuamotus, French Polynesia", time: "UTC−10:00", id: "eyJlIjoiMTI4NjY4MjQzIiwicyI6IkFBQSIsImgiOiI4MTk3NjE4NiIsInQiOiJBSVJQT1JUIn0=", skyId: "AAA"),
            Airport(iata: "AAK", icao: "NGUK", name: "Aranuka Airport", location: "Aranuka, Kiribati", time: "UTC+12:00", id: "eyJlIjoiMTI5MDU0NDg1IiwicyI6IkFBSyIsImgiOiI4MTk3NjA1MSIsInQiOiJBSVJQT1JUIn0=", skyId: "AAK"),
            Airport(iata: "ABP", icao: "", name: "Atkamba Airport", location: "Atkamba, Papua New Guinea", time: "UTC+10:00", id: nil, skyId: nil),
            Airport(iata: "OSL", icao: "ENGM", name: "Oslo lufthavn (Gardermoen)", location: "Oslo, Norway", time: "UCT+2:00", id: nil, skyId: nil)
        ]
        return sampleAirports
    }

    /*func fetchAirports(query: String, completion: @escaping ([Airport]) -> Void) {
        guard let url = URL(string: "\(baseURL)?query=\(query)") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("sky-scanner3.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    completion([])
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data returned"
                    completion([])
                }
                return
            }
            
            do {
                let airportResponse = try JSONDecoder().decode(AirportResponse.self, from: data)
                DispatchQueue.main.async {
                    self.errorMessage = ""
                    completion(airportResponse.data)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode data"
                    completion([])
                }
            }
        }.resume()
    }*/
}
