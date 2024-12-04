//
//  NewsListView.swift
//  mobile_challenge
//
//  Created by Pablo Benzo on 03/12/2024.
//

import SwiftUI

struct NewsListView: View {
    
    private let challengeVM = ChallengeViewModel()
    @State private var isSheetViewPresented = false
    @State private var searchBar = ""
    
    var body: some View {
        NavigationView {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(filteredSearch, id: \.id) { news in
                    newsImage(for: news.image)
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button {
                        isSheetViewPresented = true
                    } label: {
                        Text(news.title)
                    }
                    Spacer()
                    Text(news.category)
                }
            }
            .padding(.leading, 10)
            .sheet(isPresented: $isSheetViewPresented) {
                DetailsView()
                    .presentationDetents([.large])
            }
        }
        .navigationTitle("News")
        .font(.headline)
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchBar, prompt: "Search")
    }
        .onAppear {
            Task {
                await challengeVM.getPosts()
            }
        }
        
        if filteredNews.isEmpty && !searchBar.isEmpty {
            Text("No hay resultados.")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, UIScreen.main.bounds.height / 2)
        } else if filteredNews.isEmpty {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
                .padding(.bottom, UIScreen.main.bounds.height / 2)
        }
    }
    
    var filteredSearch: [ChallengeResponse.News]  {
        if searchBar.isEmpty {
            return challengeVM.newsResult
        }
        return filteredNews
    }
    
    var filteredNews: [ChallengeResponse.News] {
        guard !searchBar.isEmpty else { return challengeVM.newsResult }
        return challengeVM.newsResult.filter { $0.title.lowercased().hasPrefix(searchBar.lowercased()) }
    }
}


private func newsImage(for news: String) -> some View {
    AsyncImage(url: URL(string: news)) { post in
        switch post {
        case .empty:
            Rectangle()
                .fill(Color(.gray))
        case .failure:
            Rectangle()
                .fill(Color(.red))
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        default:
            EmptyView()
        }
    }
    .frame(width: 90, height: 60)
    .cornerRadius(10)
    .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(.gray)
    )
}

#Preview {
    NewsListView()
}
