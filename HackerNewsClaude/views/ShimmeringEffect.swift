//
//  ShimmeringEffect.swift
//  HackerNewsClaude
//
//  Created by Wayne Dahlberg on 12/8/24.
//

import SwiftUI

struct ShimmeringEffect: ViewModifier {
  @State private var phase: CGFloat = 0
  
  func body(content: Content) -> some View {
    content
      .modifier(AnimatedMask(phase: phase).animation(
        Animation.linear(duration: 1.5).repeatForever(autoreverses: false)
      ))
      .onAppear {
        phase = 0.8
      }
  }
  
  struct AnimatedMask: AnimatableModifier {
    var phase: CGFloat
    
    var animatableData: CGFloat {
      get { phase }
      set { phase = newValue }
    }
    
    func body(content: Content) -> some View {
      content
        .mask(GradientMask(phase: phase).scaleEffect(3))
    }
  }
  
  struct GradientMask: View {
    let phase: CGFloat
    let centerColor = Color.black
    let edgeColor = Color.clear
    
    var body: some View {
      LinearGradient(gradient:
                      Gradient(stops: [
                        .init(color: edgeColor, location: phase),
                        .init(color: centerColor, location: phase + 0.1),
                        .init(color: edgeColor, location: phase + 0.2)
                      ]), startPoint: .leading, endPoint: .trailing)
    }
  }
}

extension View {
  func shimmering() -> some View {
    modifier(ShimmeringEffect())
  }
}

