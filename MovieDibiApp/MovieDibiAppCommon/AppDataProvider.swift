//
//  AppDataProvider.swift
//  MovieDibiAppCommon
//
//  Created by Michał Pankowski on 30/01/2021.
//

public protocol CustomHeadersProvider {
    var customHeaders: [String: String] { get }
}

public class AppDataProvider: CustomHeadersProvider {
    
    private var token: String {
        return
            "eyJhbGciOiJIUzI1NiJ9." +
            "eyJhdWQiOiJmYzVmZTMwNDM2YzZjNmJjMjZkZGNmM2JjYjZkOWQyZCIsInN1YiI6IjYwMTU2ZDU5YjViYzIxMDAzZDk5NDExOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ." +
            "60h2qhLybmmg-G50vXQ2_6Ahg2xpMCEvQU7cG9lGBlc"
    }

    public var customHeaders: [String: String] {
        return ["Authorization": "Bearer \(token)",
                "Accept": "application/json"]
    }

    public init() { }

}
