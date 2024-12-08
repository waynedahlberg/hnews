//
//  ContentView.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/7/24.
//

import SwiftUI

struct ContentView: View {
  @State private var viewModel = StoryViewModel()
  @State private var selectedStory: Story?
  // Last significant refresh
  @State private var lastActiveTimestamp: Date = Date()
  @Environment(\.scenePhase) var scenePhase
  
  var body: some View {
    NavigationStack {
      List {
        if viewModel.isLoading {
          // Display a fixed number of ghost rows
          ForEach(0..<20, id: \.self) { _ in
              GhostStoryRow()
              .redacted(reason: .placeholder)
              .shimmering()
          }
        } else {
          ForEach(viewModel.stories.indices, id: \.self) { index in
            StoryRow(story: viewModel.stories[index])
              .contentShape(Rectangle())
              .onTapGesture {
                selectedStory = viewModel.stories[index]
              }
          }
        }
      }
      .scrollIndicators(.hidden)
      .listStyle(.plain)
      .navigationTitle("Hacker News")
      .refreshable {
        await viewModel.fetchStories()
      }
      .task {
        await viewModel.fetchStories()
      }
      .sheet(item: $selectedStory) { story in
        StoryDetailView(story: story)
      }
    }
    .onChange(of: scenePhase) { oldPhase, newPhase in
      if newPhase == .active {
        let timeSinceLastActive = Date().timeIntervalSince(lastActiveTimestamp)
        if timeSinceLastActive > 300 { // five minutes
          Task {
            await viewModel.fetchStories()
          }
        }
        lastActiveTimestamp = Date()
      }
    }
  }
}

#Preview {
  ContentView()
}
