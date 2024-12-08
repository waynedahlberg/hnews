//
//  StoryViewModel.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/7/24.
//

import SwiftUI
import Observation

@Observable @MainActor
final class StoryViewModel {
  private(set) var stories: [Story] = []
  private(set) var isLoading = false
  private(set) var error: Error?
  
  @MainActor
  func fetchStories() async {
    isLoading = true
    error = nil
    
    do {
      let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page")!
      let (data, _) = try await URLSession.shared.data(from: url)
      let response = try JSONDecoder().decode(HNResponse.self, from: data)
      stories = response.hits
    } catch {
      self.error = error
      print(error.localizedDescription)
    }
    isLoading = false
  }
}
