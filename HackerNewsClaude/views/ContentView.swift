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
  
  var body: some View {
    NavigationStack {
      List(viewModel.stories) { story in
        StoryRow(story: story)
          .contentShape(Rectangle())
          .onTapGesture {
            selectedStory = story
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
      
      if viewModel.isLoading {
        ProgressView()
      }
    }
  }
}

#Preview {
  ContentView()
}
