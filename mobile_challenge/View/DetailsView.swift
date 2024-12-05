//
//  DetailsView.swift
//  mobile_challenge
//
//  Created by Pablo Benzo on 04/12/2024.
//

import SwiftUI

struct DetailsView: View {
    
    @State var news: ChallengeResponse.News
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Content description:")
                        .font(.title)
                        .padding()
                    
                    Text(news.content)
                        .font(.body)
                        .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "x.circle")
                                    .tint(.gray)
                            }
                        }
                    }
                }
            }
        }
    }
}
