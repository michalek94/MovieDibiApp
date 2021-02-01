//
//  MoviesResponse.swift
//  MovieDibiAppModel
//
//  Created by Michał Pankowski on 30/01/2021.
//

public struct MoviesResponse: Codable {

    public let page: Int
    public let results: [Movie]
    public let dates: MovieDate?
    public let totalPages: Int
    public let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results, dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        results = try values.decode([Movie].self, forKey: .results)
        dates = try values.decodeIfPresent(MovieDate.self, forKey: .dates)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
    }

}
