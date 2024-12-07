//
//  MovieListViewModel.swift
//  OmdbMovieSearch
//
//  Created by Prem Shankar Rajagopalan Nayar on 7/12/24.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    
    private var movieService = MovieApiService()
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1 // For pagination
    private var searchQuery = ""
    private var totalSearchResults = 0 // Total number of results that can be displayed based on the search query
    private var isPaginating = false
    
    var errorMessage: String? = nil
    
    func searchMovies(query: String) {
        debugPrint("1---- Entered Search movies function")
        
        // Reset pagination when search query changes
        if query != searchQuery {
            self.searchQuery = query
            self.movies = [] // Clear previous results
            self.currentPage = 1
            self.totalSearchResults = 0
            self.isPaginating = false
        }
        
        // Clear previous results if query is empty
        guard !query.isEmpty else {
            self.movies = []
            return
        }
        
        fetchMovies()
    }
    
    func fetchMovies() {
        guard !isPaginating else {
            debugPrint("1---- Failed to fetching movies...")
            return
        }
        debugPrint("1---- Fetching movies...")
        
        isPaginating = true
        isLoading = true
        
        movieService.fetchMoviesList(query: searchQuery, page: currentPage)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let failure) = completion {
                    self.errorMessage = failure.localizedDescription
                    debugPrint("1---- Error fetching movies: \(failure.localizedDescription)")
                }
                self.isPaginating = false
            }, receiveValue: { movieResponse in
                if let results = movieResponse.search {
                    debugPrint("1---- Movies fetched successfully!")
                    self.movies.append(contentsOf: results)
                    self.totalSearchResults = Int(movieResponse.totalResults ?? "") ?? 0
                    self.currentPage += 1
                }
            })
            .store(in: &cancellables)
    }
    
    // Load more movies if there are more movies left
    func shouldLoadMoreMovies() -> Bool {
        return movies.count < totalSearchResults
    }
}
