//
//  StoryViewModel.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/7/24.
//

import SwiftUI
import Observation

@Observable @MainActor final class StoryViewModel {
  private(set) var stories: [Story] = []
  private(set) var isLoading = false
  private(set) var error: Error?
  
  func fetchStories() async {
    isLoading = true
    error = nil
    
    do {
      let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page")!
      var request = URLRequest(url: url)
      request.cachePolicy = .reloadIgnoringLocalCacheData
      
      let (data, _) = try await URLSession.shared.data(for: request)
      
      // Debug: Print the JSON string
//      if let jsonString = String(data: data, encoding: .utf8) {
//        print("Received JSON:", jsonString)
//      }
      
      let response = try JSONDecoder().decode(HNResponse.self, from: data)
      stories = response.hits
    } catch {
      // Enhanced error printing
      print("Decoding error:", error)
      if let decodingError = error as? DecodingError {
        switch decodingError {
        case .keyNotFound(let key, let context):
          print("Missing key:", key, "context:", context)
        case .typeMismatch(let type, let context):
          print("Type mismatch:", type, "context:", context)
        case .valueNotFound(let type, let context):
          print("Value not found:", type, "context:", context)
        default:
          print("Other decoding error:", decodingError)
        }
      }
      self.error = error
    }
    
    isLoading = false
  }
}
