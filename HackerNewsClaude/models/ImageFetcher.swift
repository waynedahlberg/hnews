//
//  ImageFetcher.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/7/24.
//

import SwiftUI

@Observable @MainActor final class ImageFetcher {
  private(set) var image: URL?
  
  func fetchPreviewImage(from urlString: String?) async {
    guard let urlString = urlString,
          let url = URL(string: urlString) else { return }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      guard let htmlString = String(data: data, encoding: .utf8) else { return }
      
      // Look for Open Graph image tag
      if let ogImageURL = htmlString.range(of: "og:image\" content=\"(.+?)\"",
                                           options: .regularExpression)
        .flatMap({ result in
          let start = htmlString.index(result.lowerBound, offsetBy: 19)
          let end = htmlString.index(result.upperBound, offsetBy: -1)
          return String(htmlString[start..<end])
        })
          .flatMap({ URL(string: $0) }) {
        self.image = ogImageURL
      }
    } catch {
      print("Failed to fetch preview: \(error)")
    }
  }
}
