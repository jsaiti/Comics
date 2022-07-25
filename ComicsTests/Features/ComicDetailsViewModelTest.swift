//
//  ComicDetailsViewModelTest.swift
//  ComicsTests
//
//  Created by Jusuf Saiti on 25.7.22.
//

import XCTest
@testable import Comics

final class ComicDetailsViewModelTest: XCTestCase {

    var viewModel: ComicDetailsViewModel!

    override func setUpWithError() throws {
        viewModel = MockedViewModel()
    }

    func testNavigationTitle() {
        let title =  "Comic #2649"
        XCTAssertEqual(viewModel.navigationTitle, title)
    }
    
    func testTitle() {
        let title =  "Physics Cost-Saving Tips"
        XCTAssertEqual(viewModel.title, title)
    }
    
    func testImageURL() {
        let imageUrl = "https://imgs.xkcd.com/comics/physics_cost_saving_tips.png"
        XCTAssertEqual(viewModel.imageURL, imageUrl)
    }
    
    func testDate() {
        let date = "22.7.2022"
        XCTAssertEqual(viewModel.date, date)
    }
    
    func testDescription() {
        XCTAssertEqual(viewModel.description, "")
    }
    
    func testExplanation() {
        let explanation = "I got banned from the county fair for handing out Helium-2 balloons. Apparently the instant massive plasma explosions violated some local ordinance or something."
        XCTAssertEqual(viewModel.explanation, explanation)
    }
    
    func testShareInformation() {
        let shareInformation = "Physics Cost-Saving Tips\n"
        XCTAssertEqual(viewModel.shareInformation, shareInformation)
    }
    
    func testFavoriteIcon() {
        let image = UIImage(named: "heart")
        XCTAssertEqual(viewModel.favoriteIcon, image)
    }
    
    func tesetSavedImage() {
        let image = UIImage(named: "no-image")
        XCTAssertEqual(viewModel.savedImage, image)
    }
}

private class MockedViewModel: ComicDetailsViewModel {
    override var comic: Comic! {
        get {
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
        set {}
    }
}
