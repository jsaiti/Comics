//
//  ComicTableViewCellViewModelTest.swift
//  ComicsTests
//
//  Created by Jusuf Saiti on 25.7.22.
//

import XCTest
@testable import Comics

final class ComicTableViewCellViewModelTest: XCTestCase {
    
    var viewModel: ComicTableViewCellViewModel!
    
    override func setUpWithError() throws {
        viewModel = ComicTableViewCellViewModel(comic: mockedComic)
    }
    
    func testComicNumber() {
        XCTAssertEqual(viewModel.comicNumber, "Comic #2649")
    }
    
    func testTitle() {
        XCTAssertEqual(viewModel.title, "Physics Cost-Saving Tips")
    }
    
    func testDate() {
        let date = "22.7.2022"
        XCTAssertEqual(viewModel.date, date)
    }
    
    func testSavedImage() {
        let image = UIImage(named: "no-image")
        XCTAssertEqual(viewModel.savedImage, image)
    }
    
    func testImageUrl() {
        let imageUrl = "https://imgs.xkcd.com/comics/physics_cost_saving_tips.png"
        XCTAssertEqual(viewModel.imageUrl, imageUrl)
    }
}

private var mockedComic: Comic! {
    let json = "{\"month\": \"7\", \"num\": 2649, \"link\": \"\", \"year\": \"2022\", \"news\": \"\", \"safe_title\": \"Physics Cost-Saving Tips\", \"transcript\": \"\", \"alt\": \"I got banned from the county fair for handing out Helium-2 balloons. Apparently the instant massive plasma explosions violated some local ordinance or something.\", \"img\": \"https://imgs.xkcd.com/comics/physics_cost_saving_tips.png\", \"title\": \"Physics Cost-Saving Tips\", \"day\": \"22\"}"
    
    if let data = json.data(using: .utf8) {
        do {
            let comic = try JSONDecoder().decode(Comic.self, from: data)
            return comic
            
        } catch {
            Debug.log("Failed to serialize JSON: \(error)")
        }
    }
    return nil
}
