//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Bholanath Barik on 12/05/24.
//

import SwiftUI

struct ArticleListView: View {
    let articles : [Article];
    @State private var selectedArticle: Article?
    
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(aricle: article)
                    .onTapGesture {
                        selectedArticle = article;
                    }
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        ))
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .sheet(
                item: $selectedArticle) { articles in
                    SafariView(url: articles.articleURL)
                        .edgesIgnoringSafeArea(.bottom)
                }
        }
    }
}

#Preview {
    NavigationView {
        ArticleListView(articles: Article.previewData);
    }
}
