//
//  ChallengeViewModel.swift
//  mobile_challenge
//
//  Created by Pablo Benzo on 03/12/2024.
//

import Foundation
import SwiftUI
import Observation

@Observable
class ChallengeViewModel {
    
    var newsResult = [ChallengeResponse.News]()
    var usersResult = [ChallengeResponse.User]()
    
    func getPosts() async {
        guard let url = URL(string: "https://jsonplaceholder.org/posts") else { return }
        let (data, _) = try! await URLSession.shared.data(from: url)
        let result = try! JSONDecoder().decode([ChallengeResponse.News].self, from: data)
        newsResult = result
    }
    
    func getUsers() async {
        guard let url = URL(string: "https://jsonplaceholder.org/users") else { return }
        let (data, _) = try! await URLSession.shared.data(from: url)
        let result = try! JSONDecoder().decode([ChallengeResponse.User].self, from: data)
        usersResult = result
    }
    
}
