//
//  OmdbMovieSearchTests.swift
//  OmdbMovieSearchTests
//
//  Created by Prem Shankar Rajagopalan Nayar on 7/12/24.
//

import XCTest
@testable import OmdbMovieSearch

final class OmdbMovieSearchTests: XCTestCase {
    
    var viewModel: MovieListViewModel!
    var mockApiService: MockMovieApiService!
    
    override func setUp() {
        super.setUp()
        mockApiService = MockMovieApiService()
        viewModel = MovieListViewModel()
        // Inject the mock service into the view model
        viewModel.movieService = mockApiService
    }
    
    override func tearDown() {
        viewModel = nil
        mockApiService = nil
        super.tearDown()
    }
    
    // Testing initial State
    func testInitialState() {
        XCTAssertTrue(viewModel.movies.isEmpty, "Movies should be empty initially")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false initially")
        XCTAssertEqual(viewModel.currentPage, 1, "Initial page should be 1")
    }
    
    // Testing movies search with ""
    func test_searchMovies_withEmptyQuery() {
        viewModel.searchMovies(query: "")
        
        XCTAssertTrue(viewModel.movies.isEmpty, "Movies should be cleared when query is empty")
    }
    
    // Testing out movie fetching success
    func test_fetchMovies_success() {
        let movie1 = Movie(title: "Movie 1", year: "2021", id: "1", type: "movie", poster: "")
        let movie2 = Movie(title: "Movie 2", year: "2022", id: "2", type: "movie", poster: "")
        
        mockApiService.mockMovies = [movie1, movie2]
        viewModel.searchMovies(query: "Avengers")
        
        let expectation = XCTestExpectation(description: "Movies should be fetched successfully")
        
        // Simulate asynchronous movie fetch
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading, "isLoading should be false after fetching")
            XCTAssertEqual(self.viewModel.movies.count, 2, "There should be 2 movies in the list")
            XCTAssertEqual(self.viewModel.totalSearchResults, 100, "Total search results should be 100")
            XCTAssertEqual(self.viewModel.currentPage, 2, "Current page should increment after successful fetch")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
