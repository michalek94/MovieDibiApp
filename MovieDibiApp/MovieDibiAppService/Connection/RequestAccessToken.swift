//
//  RequestAccessToken.swift
//  MovieDibiAppService
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppCommon
import Alamofire

public class RequestAccessToken: RequestInterceptor {

    private let dataProvider: AppDataProvider
    private let environment: AppEnvironment

    public init(dataProvider: AppDataProvider,
                environment: AppEnvironment) {
        self.dataProvider = dataProvider
        self.environment = environment
    }

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        if let url = urlRequest.url {
            if url.absoluteString.hasPrefix(environment.serverBaseUrl) {
                var mutableUrlRequest = urlRequest
                dataProvider.customHeaders.forEach {
                    mutableUrlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
                }
                completion(.success(mutableUrlRequest))
            }
        } else {
            completion(.success(urlRequest))
        }
    }

    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }

}
