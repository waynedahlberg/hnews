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
          
          Text(timeAgoString(from: story.created_at) + " ago")
            .foregroundStyle(.secondary)
            .font(.caption)
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
          .background(Color.white)
          .clipShape(RoundedRectangle(cornerRadius: 4))
          .frame(width: 40, height: 40)
        } else {
          RoundedRectangle(cornerRadius: 4)
            .fill(.gray.opacity(0.1))
            .frame(width: 40, height: 40)
            .overlay(
              RoundedRectangle(cornerRadius: 4)
                .stroke(.orange, lineWidth: 2)
            )
        }
      }
      .task {
        isLoadingThumbnail = true
        thumbnailUrl = await thumbnailLoader.thumbnailURL(for: story)
        isLoadingThumbnail = false
      }
    }
  }
  
  private func timeAgoString(from dateString: String) -> String {
      let formatter = ISO8601DateFormatter()
      formatter.formatOptions = [.withInternetDateTime]
      guard let date = formatter.date(from: dateString) else { return "" }
      
      let now = Date()
      let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
      
      if let year = components.year, year > 0 { return "\(year)y" }
      if let month = components.month, month > 0 { return "\(month)mo" }
      if let day = components.day, day > 0 { return "\(day)d" }
      if let hour = components.hour, hour > 0 { return "\(hour)h" }
      if let minute = components.minute, minute > 0 { return "\(minute)min" }
      if let second = components.second, second > 0 { return "\(second)s" }
      
      return "just now"
    }
}

#Preview {
  StoryRow(story: Story(objectID: "1", title: "Lorem ipsum dolar sit amet", points: 32, url: "https://google.com", author: "Wayne Dahlberg", created_at: "", num_comments: 13, story_id: 2, _tags: ["tech"]))
}
