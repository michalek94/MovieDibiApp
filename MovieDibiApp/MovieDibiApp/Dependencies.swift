//
//  Dependencies.swift
//  MovieDibiApp
//
//  Created by Michał Pankowski on 30/01/2021.
//

import MovieDibiAppService
import MovieDibiAppCommon

public class Dependencies {

    public let dataProvider: AppDataProvider = AppDataProvider()
    public let connectionManager: ConnectionManager
    public let environment: AppEnvironment = AppEnvironment()

    public init() {
        connectionManager = ConnectionManager(dataProvider: dataProvider,
                                              environment: environment)
    }

}
