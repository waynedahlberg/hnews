//
//  Models.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/7/24.
//

import Foundation

struct HNResponse: Codable {
  let hits: [Story]
  let nbHits: Int
  let page: Int
}

struct Story: Codable, Identifiable {
  let objectId: String
  let title: String
  let points: Int
  let url: String?
  let author: String
  let created_at: String
  let num_comments: Int?
  
  var id: String { objectId }
}


