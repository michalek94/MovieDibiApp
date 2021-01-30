//
//  Movie.swift
//  MovieDibiAppModel
//
//  Created by Michał Pankowski on 30/01/2021.
//

public struct Movie: Codable {

    public let posterPath: String?
    public let adult: Bool
    public let overview: String
    public let releaseDate: String
    public let genreIds: [Int]
    public let id: Int
    public let originalTitle: String
    public let originalLanguage: String
    public let title: String
    public let backdropPath: String?
    public let popularity: Double
    public let voteCount: Int
    public let video: Bool
    public let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        adult = try values.decode(Bool.self, forKey: .adult)
        overview = try values.decode(String.self, forKey: .overview)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        genreIds = try values.decode([Int].self, forKey: .genreIds)
        id = try values.decode(Int.self, forKey: .id)
        originalTitle = try values.decode(String.self, forKey: .originalTitle)
        originalLanguage = try values.decode(String.self, forKey: .originalLanguage)
        title = try values.decode(String.self, forKey: .title)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        popularity = try values.decode(Double.self, forKey: .popularity)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
        video = try values.decode(Bool.self, forKey: .video)
        voteAverage = try values.decode(Double.self, forKey: .voteAverage)
    }

}
