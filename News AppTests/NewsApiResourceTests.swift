//
//  NewsApiResourceUnitTests.swift
//  News AppTests
//
//  Created by Adil Yousuf on 08/07/2024.
//

import XCTest
@testable import News_App

class NewsApiResourceTests: XCTestCase {
    
    func test_GetNewsArticles_With_ValidResponse_Returns_News() {
        // ARRANGE
        let viewModel = NewsViewModel()
        let expectation = self.expectation(description: "ValidResponse_Returns_News")
        
        // ACT
        viewModel.getNewsArticles { (news, error) in
            // ASSERT
            XCTAssertNotNil(news)
            XCTAssertNil(error)
            XCTAssertFalse(news!.articles.isEmpty, "Expected non-empty articles array")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_GetNewsArticles_With_Error_Returns_Error() {
        // ARRANGE
        let viewModel = NewsViewModel()
        let expectation = self.expectation(description: "Error_Returns_Error")
        
        // Override the base URL with an invalid URL
        Constants.baseURL = "InvalidURL"
        
        // ACT
        viewModel.getNewsArticles { (news, error) in
            // ASSERT
            XCTAssertNil(news)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, "unsupported URL")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        // Restore the original base URL
        Constants.baseURL = "https://api.nytimes.com"
    }
    
}
