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
            NewsListView()
                .tabItem {
                    Label("News", systemImage: "newspaper.fill")
                }
            
            UsersView()
                .tabItem {
                    Label("Users", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    HomeView()
}
