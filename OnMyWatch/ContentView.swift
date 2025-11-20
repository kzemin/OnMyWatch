//
//  ContentView.swift
//  OnMyWatch
//
//  Created by Facundo Kzemin on 20/11/2025.
//

import SwiftUI

struct ContentView: View {
    let watches = [
        (image: "applewatch", title: "Classic Sport", subtitle: "Perfect for daily wear"),
        (image: "applewatch.side.right", title: "Modern Elite", subtitle: "Premium design"),
        (image: "applewatch.watchface", title: "Digital Pro", subtitle: "Tech enthusiast choice"),
        (image: "applewatch.radiowaves.left.and.right", title: "Smart Connect", subtitle: "Always connected"),
        (image: "applewatch.slash", title: "Minimalist", subtitle: "Simple elegance")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Welcome 👋")
                    .font(.title)
                    .bold()
                Text("Try on over +100 watch faces on your wrist!")
                    .padding(.bottom)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Trending")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(watches.indices, id: \.self) { index in
                                WatchCard(
                                    imageName: watches[index].image,
                                    title: watches[index].title,
                                    subtitle: watches[index].subtitle
                                )
                            }
                        }
                        .frame(height: 210)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Classic")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(watches.indices, id: \.self) { index in
                                WatchCard(
                                    imageName: watches[index].image,
                                    title: watches[index].title,
                                    subtitle: watches[index].subtitle
                                )
                            }
                        }
                        .frame(height: 210)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Favorites")
                        .font(.title2)
                        .bold()
                        .padding(.vertical, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(watches.indices, id: \.self) { index in
                                WatchCard(
                                    imageName: watches[index].image,
                                    title: watches[index].title,
                                    subtitle: watches[index].subtitle
                                )
                            }
                        }
                        .frame(height: 210)
                    }
                }
            }
        }
        .scrollIndicators(.never)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
}

struct WatchCard: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            
            Text(title)
                .font(.headline)
                .lineLimit(1)
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .frame(width: 150)
    }
}

#Preview {
    ContentView()
}
