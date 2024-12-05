//
//  ChallengeModel.swift
//  mobile_challenge
//
//  Created by Pablo Benzo on 03/12/2024.
//

import Foundation

struct ChallengeResponse: Codable {
    let news: [News]
    let users: [User]
    
    struct News: Codable {
        var id: Int
        var slug: String
        var url: String
        var title: String
        var content: String
        var image: String
        var thumbnail: String
        var status: String
        var category: String
        var publishedAt: String
        var updatedAt: String
        var userId: Int
    }
    
    struct User: Codable {
        var id: Int
        var firstname: String
        var lastname: String
        var email: String
        var birthDate: String
        var login: Login
        var address: Address
        var phone: String
        var website: String
        var company: Company
        
        struct Login: Codable {
            var uuid: String
            var username: String
            var password: String
            var md5: String
            var sha1: String
            var registered: String
        }
        
        struct Address: Codable {
            var street: String
            var suite: String
            var city: String
            var zipcode: String
            var geo: Geo
            
            struct Geo: Codable {
                var lat: String
                var lng: String
            }
        }
        
        struct Company: Codable {
            var name: String
            var catchPhrase: String
            var bs: String
        }
    }
    
}
