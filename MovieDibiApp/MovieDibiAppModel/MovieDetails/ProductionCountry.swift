//
//  ProductionCountry.swift
//  MovieDibiAppModel
//
//  Created by Michał Pankowski on 01/02/2021.
//

public struct ProductionCountry: Codable {

    public let iso31661: String
    public let name: String

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso31661 = try values.decode(String.self, forKey: .iso31661)
        name = try values.decode(String.self, forKey: .name)
    }

}
