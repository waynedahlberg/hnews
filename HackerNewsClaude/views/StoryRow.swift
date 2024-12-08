//
//  StoryRow.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/7/24.
//

import SwiftUI

struct StoryRow: View {
  let story: Story
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(story.title)
        .font(.headline)
        .lineLimit(2)
      
      HStack {
        Label("\(story.points)", systemImage: "arrow.up")
          .foregroundStyle(.orange)
        Label("\(String(describing: story.num_comments))", systemImage: "bubble.right")
        Text("by \(story.author)")
          .foregroundStyle(.secondary)
      }
      .font(.caption)
    }
    .padding(.vertical, 8)
  }
}

//#Preview {
//  StoryRow(story: Story(objectId: "1", title: "Two years unenmployed", points: 3, url: "", author: "joe", created_at: "30 minutes ago", num_comments: 3))
//}
