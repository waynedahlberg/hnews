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
    let hitsPerPage: Int
    let processingTimeMS: Int
}

struct Story: Codable, Identifiable {
    let objectID: String
    let title: String
    let points: Int?
    let url: String?
    let author: String
    let created_at: String
    let num_comments: Int?
    let story_id: Int
    let _tags: [String]
    
    var id: String { objectID }
    
    private enum CodingKeys: String, CodingKey {
        case objectID, title, points, url, author, created_at
        case num_comments, story_id, _tags = "_tags"
    }
}
