//
//  PaginationDataProvider.swift
//  MovieDibiAppViewModel
//
//  Created by Michał Pankowski on 30/01/2021.
//

public protocol PaginationDataProvider: class {
    var currentPage: Int { get }
}
