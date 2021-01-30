//
//  AppEnvironment.swift
//  MovieDibiAppCommon
//
//  Created by Michał Pankowski on 30/01/2021.
//

public enum AppEnvironmentConfiguration: String {
    case development, staging, production
}

public class AppEnvironment {

    public let configuration: AppEnvironmentConfiguration

    public init() {
        let bundleEnvironment = (Bundle.main.object(forInfoDictionaryKey: "Environment") as? String) ?? AppEnvironmentConfiguration.development.rawValue
        self.configuration = AppEnvironmentConfiguration(rawValue: bundleEnvironment)!
    }

    public lazy var serverBaseUrl: String = {
        switch configuration {
        case .development, .staging, .production: return "https://api.themoviedb.org/3/movie/"
        }
    }()

}
