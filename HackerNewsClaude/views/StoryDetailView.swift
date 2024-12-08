//
//  StoryDetailView.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/7/24.
//

import SwiftUI

struct StoryDetailView: View {
  let story: Story
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
      VStack {
        if let url = story.url.flatMap({ URL(string: $0) }) {
          WebView(url: url)
        } else {
          let hnURL = URL(string: "https://news.ycombinator.com/item?id=\(story.objectID)")!
                              WebView(url: hnURL)
        }
      }
      .navigationTitle("Story")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Done") {
            dismiss()
          }
        }
      }
    }
  }
}

//#Preview {
//  StoryDetailView()
//}
