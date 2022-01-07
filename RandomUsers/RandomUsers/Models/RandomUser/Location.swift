//
//  Location.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 07/01/2022.
//

import Foundation

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: String
    let coordinates: Coordinates
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(Street.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        country = try container.decode(String.self, forKey: .country)
        do {
            postcode = try (String(container.decode(Int.self, forKey: .postcode)))
        } catch DecodingError.typeMismatch {
            postcode = try container.decode(String.self, forKey: .postcode)
        }
        coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
    }
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Coordinates: Codable {
    let latitude: String
    let longitude: String
}
