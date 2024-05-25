//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Bholanath Barik on 11/05/24.
//

import SwiftUI

struct ArticleRowView: View {
    let aricle: Article;
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            AsyncImage(url: aricle.imageURL){
                Phase in
                switch Phase {
                case .empty:
                    HStack{
                        Spacer();
                        ProgressView();
                        Spacer();
                    }
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        
                case .failure(_):
                    HStack {
                        Spacer();
                            Image(systemName: "photo")
                                   .imageScale(.large)
                        Spacer();
                    }
                    
                @unknown default:
                    fatalError();
                }
            }
            .frame(minWidth: 200, minHeight: 200)
            .background(Color.gray.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(aricle.title)
                    .font(.headline)
                    .lineLimit(3)
                
                Text(aricle.descriptionText)
                    .font(.subheadline)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Text(aricle.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bookmark")
                    }
                    .buttonStyle(.bordered)
                    .cornerRadius(20)
                    
                    Button {
                        presentShareSheet(url: aricle.articleURL);
                    } label: {
                        Image(systemName: "square.and.arrow.up");
                    }
                    .buttonStyle(.bordered)
                    .cornerRadius(20)
                    
                }
            }
            .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

extension View {
    func presentShareSheet(url : URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}

#Preview {
    List{
        ArticleRowView(aricle: .previewData[0])
            .listRowInsets(
                .init(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
            ))
    }
    .listStyle(.plain)
}
