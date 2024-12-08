//
//  GhostStoryRow.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/8/24.
//

import SwiftUI

struct GhostStoryRow: View {
  var body: some View {
    HStack(spacing: 24) {
      VStack(alignment: .leading, spacing: 8) {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color(.quaternaryLabel))
          .frame(height: 20)
        
        HStack(spacing: 24) {
          HStack {
            Circle()
              .fill(Color(.quaternaryLabel))              .frame(width: 16, height: 16)
            
            RoundedRectangle(cornerRadius: 4)
              .fill(Color(.quaternaryLabel))              .frame(width: 50, height: 16)
          }
          HStack {
            Circle()
              .fill(Color(.quaternaryLabel))              .frame(width: 16, height: 16)
            
            RoundedRectangle(cornerRadius: 4)
              .fill(Color(.quaternaryLabel))              .frame(width: 50, height: 16)
          }
          
          RoundedRectangle(cornerRadius: 4)
            .fill(Color(.quaternaryLabel))
            .frame(width: 64, height: 20)
        }
      }
      
      Spacer()
      
      RoundedRectangle(cornerRadius: 4)
        .fill(Color(.quaternaryLabel))        .frame(width: 48, height: 48)
    }
    .padding(.vertical, 8)
  }
}

#Preview {
  GhostStoryRow()
}

// End of file. No additional code.

#Preview {
  GhostStoryRow()
}


