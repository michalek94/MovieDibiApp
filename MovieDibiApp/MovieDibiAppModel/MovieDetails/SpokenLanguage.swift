//
//  SpokenLanguage.swift
//  MovieDibiAppModel
//
//  Created by Michał Pankowski on 01/02/2021.
//

public struct SpokenLanguage: Codable {

    public let iso6391: String
    public let name: String

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso6391 = try values.decode(String.self, forKey: .iso6391)
        name = try values.decode(String.self, forKey: .name)
    }

}
