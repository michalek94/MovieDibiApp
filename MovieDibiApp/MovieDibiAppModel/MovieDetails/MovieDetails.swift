//
//  MovieDetails.swift
//  MovieDibiAppModel
//
//  Created by Michał Pankowski on 01/02/2021.
//

import MovieDibiAppCommon

public struct MovieDetails: Codable {
    
    public let adult: Bool
    public let backdropPath: String?
    public let budget: Int
    public let genres: [Genre]
    public let homePage: String?
    public let id: Int
    public let imdbId: String?
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String?
    public let popularity: Double
    public let posterPath: String?
    public let productionCompanies: [ProductionCompany]
    public let productionCountries: [ProductionCountry]
    public let releaseDate: String
    public let revenue: Int
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguage]
    public let status: String
    public let tagline: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homePage = "home_page"
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decode(Bool.self, forKey: .adult)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        budget = try values.decode(Int.self, forKey: .budget)
        genres = try values.decode([Genre].self, forKey: .genres)
        homePage = try values.decodeIfPresent(String.self, forKey: .homePage)
        id = try values.decode(Int.self, forKey: .id)
        imdbId = try values.decodeIfPresent(String.self, forKey: .imdbId)
        originalLanguage = try values.decode(String.self, forKey: .originalLanguage)
        originalTitle = try values.decode(String.self, forKey: .originalTitle)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity = try values.decode(Double.self, forKey: .popularity)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        productionCompanies = try values.decode([ProductionCompany].self, forKey: .productionCompanies)
        productionCountries = try values.decode([ProductionCountry].self, forKey: .productionCountries)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        revenue = try values.decode(Int.self, forKey: .revenue)
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
        spokenLanguages = try values.decode([SpokenLanguage].self, forKey: .spokenLanguages)
        status = try values.decode(String.self, forKey: .status)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        title = try values.decode(String.self, forKey: .title)
        video = try values.decode(Bool.self, forKey: .video)
        voteAverage = try values.decode(Double.self, forKey: .voteAverage)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
    }

    public var posterUrl: URL {
        URL(string: "https://image.tmdb.org/t/p/w780\(posterPath ?? "")")!
    }

    public var releaseDateFormatted: String? {
        guard let date = AppDateFormatter.shared.date(from: releaseDate) else {
            return nil
        }
        return AppDateFormatter.shared.string(from: date)
    }

    public var backdropUrl: URL {
        URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath ?? "")")!
    }

    public var voteAverageText: String {
        "\(voteAverage)"
    }

}
