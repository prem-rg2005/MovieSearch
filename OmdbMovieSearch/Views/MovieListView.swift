//
//  MovieListView.swift
//  OmdbMovieSearch
//
//  Created by Prem Shankar Rajagopalan Nayar on 7/12/24.
//

import SwiftUI

struct MovieListView: View {
    
    @State private var searchQuery = ""
    @ObservedObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                SearchBarView(searchText: $searchQuery, onSearch: searchMovies)
                
                if viewModel.isLoading && viewModel.movies.isEmpty {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.movies) { movie in
                            MovieListCell(movie: movie)
                        }
                        
                        if viewModel.shouldLoadMoreMovies() {
                            HStack {
                                Spacer()
                                Text("Loading more movies.....")
                                    .padding()
                                Spacer()
                            }
                            .onAppear {
                                viewModel.fetchMovies()
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Movie List")
        }
    }
    
    private func searchMovies() {
        viewModel.searchMovies(query: searchQuery)
    }
}

#Preview {
    MovieListView()
}
