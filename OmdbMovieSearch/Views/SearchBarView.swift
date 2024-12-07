//
//  SearchBarView.swift
//  OmdbMovieSearch
//
//  Created by Prem Shankar Rajagopalan Nayar on 7/12/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            Image.sysImage.searchImage
                .foregroundColor(
                    searchText.isEmpty
                    ? Color.themeColor.secondaryText
                    : Color.themeColor.primaryText
                )
            TextField("Search movie name...", text: $searchText)
                .foregroundColor(Color.themeColor.primaryText)
                .onChange(of: searchText) { newValue in
                    // This triggers search function when user input changes
                    onSearch()
                }
                .overlay(Image.sysImage.clearSearch
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(Color.themeColor.secondaryText)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        searchText = ""
                    }
                         , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.themeColor.bgColor)
                .shadow(color: Color.themeColor.primaryText.opacity(0.2),
                        radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""), onSearch: {})
        .previewLayout(.sizeThatFits)
}
