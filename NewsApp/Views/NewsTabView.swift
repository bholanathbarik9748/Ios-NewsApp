//
//  NewsTabView.swift
//  NewsApp
//
//  Created by Bholanath Barik on 25/05/24.
//

import SwiftUI

struct NewsTabView: View {
    @StateObject var articleNewsVM = ArticleNewsViewModel();
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NewsTabView()
}
