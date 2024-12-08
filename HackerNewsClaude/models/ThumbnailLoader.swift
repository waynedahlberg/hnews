//
//  ThumbnailLoader.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/7/24.
//

import SwiftUI

@Observable @MainActor final class ThumbnailLoader: ObservableObject {
  private var cache: [String: URL?] = [:]
  
  func thumbnailURL(for story: Story) async -> URL? {
    // Check cache first
    if let cached = cache[story.objectID] {
      return cached
    }
    
    guard let urlString = story.url,
          let url = URL(string: urlString) else {
      cache[story.objectID] = nil
      return nil
    }
    
    // Get the domain favicon (very lightweight approach)
    let faviconURL = url.scheme! + "://" + url.host! + "/favicon.ico"
    if let faviconURL = URL(string: faviconURL) {
      // Quick check if favicon exists
      do {
        let (_, response) = try await URLSession.shared.data(from: faviconURL)
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 200 {
          cache[story.objectID] = faviconURL
          return faviconURL
        }
      } catch {
        // Favicon not found, fall back to Google Favicon service
        let googleFaviconURL = "https://www.google.com/s2/favicons?domain=\(url.host!)"
        cache[story.objectID] = URL(string: googleFaviconURL)
        return URL(string: googleFaviconURL)
      }
    }
    
    cache[story.objectID] = nil
    return nil
  }
}
