//
//  mobile_challengeTests.swift
//  mobile_challengeTests
//
//  Created by Pablo Benzo on 03/12/2024.
//

import XCTest
@testable import mobile_challenge

protocol NetworkingService {
    func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

final class mobile_challengeTests: XCTestCase {
    
    var apiClient: NewsAPIClient!
    
    override func setUp() {
        super.setUp()

        let mockNetworkingService = MockNetworkingService()
        apiClient = NewsAPIClient(networkingService: mockNetworkingService)
    }
    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }
    
    func testFetchNewsData() {
        let expectation = self.expectation(description: "Fetch news data")
        apiClient.fetchNewsData { result in
            switch result {
            case .success(let posts):
                XCTAssertFalse(posts.isEmpty, "El resultado no debe estar vacío")
                
                if let firstPost = posts.first {
                    XCTAssertEqual(firstPost.title, "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                    XCTAssertEqual(firstPost.category, "lorem")
                } else {
                    XCTFail("El array está vacío")
                }
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    class MockNetworkingService: NetworkingService {
        func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void) {

            let jsonString = """
               [
                   {
                       "id": 1,
                           "slug": "lorem-ipsum",
                           "url": "https://jsonplaceholder.org/posts/lorem-ipsum",
                           "title": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                           "content": "Ante taciti nulla sit libero orci sed nam. Sagittis suspendisse gravida ornare iaculis cras nullam varius ac ullamcorper. Nunc euismod hendrerit netus ligula aptent potenti. Aliquam volutpat nibh scelerisque at. Ipsum molestie phasellus euismod sagittis mauris, erat ut. Gravida morbi, sagittis blandit quis ipsum mi mus semper dictum amet himenaeos. Accumsan non congue praesent interdum habitasse turpis orci. Ante curabitur porttitor ullamcorper sagittis sem donec, inceptos cubilia venenatis ac. Augue fringilla sodales in ullamcorper enim curae; rutrum hac in sociis! Scelerisque integer varius et euismod aenean nulla. Quam habitasse risus nullam enim. Ultrices etiam viverra mattis aliquam? Consectetur velit vel volutpat eget curae;. Volutpat class mus elementum pulvinar! Nisi tincidunt volutpat consectetur. Primis morbi pulvinar est montes diam himenaeos duis elit est orci. Taciti sociis aptent venenatis dui malesuada dui justo faucibus primis consequat volutpat. Rhoncus ante purus eros nibh, id et hendrerit pellentesque scelerisque vehicula sollicitudin quam. Hac class vitae natoque tortor dolor dui praesent suspendisse. Vehicula euismod tincidunt odio platea aenean habitasse neque ad proin. Bibendum phasellus enim fames risus eget felis et sem fringilla etiam. Integer.",
                           "image": "https://dummyimage.com/800x430/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
                           "thumbnail": "https://dummyimage.com/200x200/FFFFFF/lorem-ipsum.png&text=jsonplaceholder.org",
                           "status": "published",
                           "category": "lorem",
                           "publishedAt": "04/02/2023 13:25:21",
                           "updatedAt": "14/03/2023 17:22:20",
                           "userId": 1
                   }
               ]
            """
            if let data = jsonString.data(using: .utf8) {
                completion(data, nil)
            } else {
                let error = NSError(domain: "MockNetworkingServiceErrorDomain", code: -1, userInfo: nil)
                completion(nil, error)
            }
        }
    }
    
    class NewsAPIClient {
        private let networkingService: NetworkingService

    init(networkingService: NetworkingService) {
            self.networkingService = networkingService
        }
        func fetchNewsData(completion: @escaping (Result<[ChallengeResponse.News], Error>) -> Void) {
            guard let url = URL(string: "https://jsonplaceholder.org/posts") else { return }
            networkingService.fetchData(url: url) { data, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let news = try decoder.decode([ChallengeResponse.News].self, from: data!)
                    completion(.success(news))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
