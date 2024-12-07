//
//  MovieListCell.swift
//  OmdbMovieSearch
//
//  Created by Prem Shankar Rajagopalan Nayar on 7/12/24.
//

import SwiftUI

struct MovieListCell: View {
    
    @State var movie: Movie = .init(title: "Harry Potter and the Deathly Hallows: Part 2", year: "2011", id: "tt1201607", type: "movie", poster: "https://m.media-amazon.com/images/M/MV5BOTA1Mzc2N2ItZWRiNS00MjQzLTlmZDQtMjU0NmY1YWRkMGQ4XkEyXkFqcGc@._V1_SX300.jpg")
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.poster)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("No image available")
                } else {
                    Image.sysImage.placeholderImg
                }
            }
            .frame(width: 100)
            .cornerRadius(15)
            
            VStackLayout(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(Color.blue)
                Text("Year: \(movie.year)")
                    .font(.subheadline)
                    .foregroundColor(Color.themeColor.secondaryText)
            }
            .padding(.leading, 8)
        }
        .padding()
        .background(Color.themeColor.secondaryText)
        .cornerRadius(5)
        .padding(.horizontal)
    }
}

#Preview {
    MovieListCell()
}
