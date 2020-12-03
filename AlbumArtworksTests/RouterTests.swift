//
//  RouterTests.swift
//  AlbumArtworksTests
//
//  Created by Roman Trekhlebov on 03.12.2020.
//

import XCTest
@testable import AlbumArtworks

class RouterTests: XCTestCase {
    var router: RouterProtocol!
    var navigatioController: UINavigationController!
    var assembly: AssemblyModuleBuilder!

    override func setUpWithError() throws {
        navigatioController = UINavigationController()
        assembly = AssemblyModuleBuilder()
        router = Router(navigationController: navigatioController, assemblyBuilder: assembly)
    }
    override func tearDownWithError() throws {
        router = nil
        navigatioController = nil
        assembly = nil
    }
    func testInitialViewController() throws {
        router.initialViewController()
        let rootVC = navigatioController.viewControllers.first
        XCTAssertTrue(rootVC is MainViewController)
    }
    func testPopToRoot() {
        router.initialViewController()
        router.popToRoot()
        let visibleVC = navigatioController.visibleViewController
        XCTAssertNotNil(visibleVC)
        XCTAssertTrue(visibleVC is MainViewController)
    }
}
