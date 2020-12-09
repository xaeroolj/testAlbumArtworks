//
//  MockMainView.swift
//  AlbumArtworksTests
//
//  Created by Roman Trekhlebov on 09.12.2020.
//

import XCTest
@testable import AlbumArtworks

class MockView: MainViewProtocol, DetailViewProtocol {

    let viewLoadingExpectation = XCTestExpectation(description: "viewLoading called")
    let initStateExpectation = XCTestExpectation(description: "viewInit called")
    let viewUpdateExpectation = XCTestExpectation(description: "viewUpdate called")
    let viewShowErrorExpectation = XCTestExpectation(description: "viewError called")

    func viewLoad() {
        initStateExpectation.fulfill()
    }

    func updateView() {
        viewUpdateExpectation.fulfill()
    }

    func loading() {
        viewLoadingExpectation.fulfill()
    }

    func showError(_ error: NetworkError) {
        viewShowErrorExpectation.fulfill()
    }
}
