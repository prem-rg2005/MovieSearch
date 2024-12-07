//
//  MovieApiService.swift
//  OmdbMovieSearch
//
//  Created by Prem Shankar Rajagopalan Nayar on 7/12/24.
//

import Foundation
import Combine

class MovieApiService {
    private let baseURL = "https://www.omdbapi.com/"
    private let apiKey = "8d6aa4ca"
    
    func fetchMoviesList(query: String, page: Int) -> AnyPublisher<MovieResponse, Error> {
        let urlString = "\(baseURL)?s=\(query)&page=\(page)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
