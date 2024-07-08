//
//  NewsViewModelTests.swift
//  News AppTests
//
//  Created by Adil Yousuf on 08/07/2024.
//

import XCTest
@testable import News_App

final class NewsViewModelTests: XCTestCase {
    
    func test_createMostPopularResource_WithValidURL_ReturnsCorrectResource() {
        // ARRANGE
        let expectedURLString = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=NetlDvAkuIt0OUlB73LpcvHKSqPv8beJ"
        let expectedURL = URL(string: expectedURLString)!
        
        // ACT
        let resource = NewsViewModel.createMostPopularResource()
        
        // ASSERT
        XCTAssertNotNil(resource)
        XCTAssertEqual(resource!.url, expectedURL, "The URL should match the expected URL.")
        XCTAssertEqual(resource!.httpMethod, HttpMethod.get, "The HTTP method should be GET.")
    }
    
    func test_CreateMostPopularResource_ReturnsNil_WhenBaseURLIsInvalid() {
        // Arrange
        let invalidURLString = "InvalidURL"
        
        // Backup the current base URL
        let originalBaseURL = Constants.baseURL
        
        // Override the base URL with an invalid URL
        Constants.baseURL = invalidURLString
        
        // Act
        let resource = NewsViewModel.createMostPopularResource()
        
        // Assert
        XCTAssertNotEqual(resource!.url.absoluteString, "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=NetlDvAkuIt0OUlB73LpcvHKSqPv8beJ")
        
        // Restore the original base URL
        Constants.baseURL = originalBaseURL
    }
    
    func test_GetNewsArticles_ReturnsInvalidResourceError() {
        // Arrange
        let viewModel = NewsViewModel()
        
        // Backup the current base URL
        let originalBaseURL = Constants.baseURL
        
        // Override the base URL with an invalid URL
        Constants.baseURL = "InvalidURL"
        
        let expectation = self.expectation(description: "Completion handler called")
        var response: News?
        var error: String?
        
        // Act
        viewModel.getNewsArticles { (news, err) in
            response = news
            error = err
            expectation.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(response)
        XCTAssertNotNil(error)
        XCTAssertEqual(error, "unsupported URL")
        
        // Restore the original base URL
        Constants.baseURL = originalBaseURL
    }
}
