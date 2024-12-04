//
//  HomeView.swift
//  mobile_challenge
//
//  Created by Pablo Benzo on 04/12/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ChallengeView()
                .tabItem {
                    Label("News", systemImage: "house")
                }
            
            UsersView()
                .tabItem {
                    Label("Users", systemImage: "square.grid.2x2")
                }
        }
    }
}

#Preview {
    HomeView()
}
