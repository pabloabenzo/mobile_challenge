//
//  UsersView.swift
//  mobile_challenge
//
//  Created by Pablo Benzo on 04/12/2024.
//

import SwiftUI

struct UsersView: View {
    private let challengeVM = ChallengeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(challengeVM.usersResult, id: \.id) { user in
                        NavigationLink(destination: UserMapView(listResult: user.address, userResult: user)) {
                            HStack {
                                Text("\(user.firstname), \(user.lastname): Ubicación")
                                    .foregroundStyle(.primary)
                                    .bold()
                                    .tint(.blue)
                                
                                Image(systemName: "arrow.right")
                                    .tint(.indigo)
                                
                            }
                            .padding(.leading, 10)
                        }
                    }
                    .padding(.bottom, 20)
                }
                
            }
            .navigationTitle("Users")
            .font(.headline)
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                Task {
                    await challengeVM.getUsers()
                }
            }
        }
    }
}

#Preview {
    UsersView()
}
