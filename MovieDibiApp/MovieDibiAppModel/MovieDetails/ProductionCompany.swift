//
//  ProductionCompany.swift
//  MovieDibiAppModel
//
//  Created by Michał Pankowski on 01/02/2021.
//

public struct ProductionCompany: Codable {

    public let name: String
    public let id: Int
    public let logoPath: String?
    public let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case name
        case id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
        logoPath = try values.decodeIfPresent(String.self, forKey: .logoPath)
        originCountry = try values.decode(String.self, forKey: .originCountry)
    }

}
