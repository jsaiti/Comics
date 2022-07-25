//
//  ComicsViewModelTest.swift
//  ComicsTests
//
//  Created by Jusuf Saiti on 25.7.22.
//

import XCTest
@testable import Comics

class ComicsViewModelTest: XCTestCase {

    var viewModel: ComicsViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = MockedViewModel()
    }

    func testFirsItem() {
        let comicNumber = viewModel.items.first?.num ?? -1
        XCTAssertEqual(comicNumber, 2649)
    }
    
    func testNumberOfItems() {
        XCTAssertEqual(viewModel.numberOfRows, 1)
    }
    
    func testFirstTableItem() {
        XCTAssertNotNil(viewModel.getItemForIndex(index: 0))
    }
    
    func testSingleComic() {
        var comicNumber = -1
        let expectation = self.expectation(description: "getSingleComic")
        viewModel.getSingleComic(comicNumber: 2) { comic in
            comicNumber = comic.num
            expectation.fulfill()
        } onError: { _, _ in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(comicNumber, 2)
    }
}

private class MockedViewModel: ComicsViewModel {
    override var items: [Comic] {
        get {
            let json = "{\"month\": \"7\", \"num\": 2649, \"link\": \"\", \"year\": \"2022\", \"news\": \"\", \"safe_title\": \"Physics Cost-Saving Tips\", \"transcript\": \"\", \"alt\": \"I got banned from the county fair for handing out Helium-2 balloons. Apparently the instant massive plasma explosions violated some local ordinance or something.\", \"img\": \"https://imgs.xkcd.com/comics/physics_cost_saving_tips.png\", \"title\": \"Physics Cost-Saving Tips\", \"day\": \"22\"}"
            
            if let data = json.data(using: .utf8) {
                do {
                    let comic = try JSONDecoder().decode(Comic.self, from: data)
                    return [comic]
                    
                } catch {
                    Debug.log("Failed to serialize JSON: \(error)")
                }
            }
            return []
        }
        set {}
    }
}
