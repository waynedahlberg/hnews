//
//  StoryRow.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/7/24.
//

import SwiftUI

struct StoryRow: View {
  let story: Story
  @State private var thumbnailUrl: URL?
  @State private var isLoadingThumbnail: Bool = false
  @StateObject private var thumbnailLoader = ThumbnailLoader()
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(story.title)
          .font(.headline)
          .lineLimit(2)
        
        HStack {
          HStack(spacing: 4) {
            Image(systemName: "arrow.up")
            Text("\(story.points ?? 0)")
              .opacity(0.5)
          }
          .fontWeight(.semibold)
          .font(.system(size: 10))
          .foregroundStyle(.orange)
          .padding(.trailing, 8)
          .opacity(0.8)
          
          HStack(spacing: 4) {
            Image(systemName: "bubble.left")
            Text("\(story.num_comments ?? 0)")
              .opacity(0.5)
          }
          .fontWeight(.semibold)
          .font(.system(size: 10))
          .foregroundStyle(.orange)
          .opacity(0.8)
          Text("by \(story.author)")
            .foregroundStyle(.secondary)
        }
        .font(.caption)
      }
      .padding(.vertical, 8)
      
      Spacer()
      
      // Thumbnail or placeholder
      Group {
        if isLoadingThumbnail {
          RoundedRectangle(cornerRadius: 4)
            .fill(.gray.opacity(0.1))
            .frame(width: 60, height: 60)
        } else if let thumbnailUrl {
          AsyncImage(url: thumbnailUrl) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fit)
          } placeholder: {
            RoundedRectangle(cornerRadius: 4)
              .fill(.gray.opacity(0.1))
          }
          .frame(width: 40, height: 40)
        } else {
          RoundedRectangle(cornerRadius: 4)
            .fill(.gray.opacity(0.1))
            .stroke(Color(.tertiarySystemFill))
            .frame(width: 40, height: 40)
        }
      }
      .task {
        isLoadingThumbnail = true
        thumbnailUrl = await thumbnailLoader.thumbnailURL(for: story)
        isLoadingThumbnail = false
      }
    }
  }
}

#Preview {
  StoryRow(story: Story(objectID: "1", title: "Lorem ipsum dolar sit amet", points: 32, url: "https://google.com", author: "Wayne Dahlberg", created_at: "", num_comments: 13, story_id: 2, _tags: ["tech"]))
}
