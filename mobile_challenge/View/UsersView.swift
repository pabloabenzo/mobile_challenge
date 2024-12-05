//
//  UsersView.swift
//  mobile_challenge
//
//  Created by Pablo Benzo on 04/12/2024.
//

import SwiftUI

struct UsersView: View {
    
    private let challengeVM = ChallengeViewModel()
    private var deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(challengeVM.usersResult, id: \.id) { user in
                        NavigationLink(destination: UserMapView(listResult: user.address, userResult: user)) {
                            HStack {
                                VStack {
                                    Text("\(user.firstname), \(user.lastname): Location")
                                        .font(.title2)
                                        .bold()
                                        .tint(.orange)
                                    VStack {
                                        Text("User info: ").underline()
                                        Text(user.email)
                                        Text(user.login.username)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("Address: ").underline()
                                        Text(user.address.street)
                                        Text(user.address.suite)
                                        Text(user.address.city)
                                        Text(user.address.zipcode)
                                    }
                                    .tint(.indigo)
                                    
                                    
                                    Divider()
                                        .background(.gray)
                                 
                                }
                                .frame(maxWidth: deviceWidth / 1, alignment: .leading)
                                
                                Image(systemName: "arrow.right")
                                    .tint(.indigo)
                                    .frame(maxWidth: deviceWidth / 9)
                            }
                            Divider()
                                .background(.gray)
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
