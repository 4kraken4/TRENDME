//
//  Intro.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-24.
//

import SwiftUI

struct Intro : Identifiable {
    var id: UUID = .init()
    var text: String
    var textColor: Color
    var circleColor: Color
    var bgColor: Color
    var circleOffset: CGFloat = 0
    var textOffset: CGFloat = 0
}


var intros : [Intro] = [
    .init(text: "Let's fashion",
          textColor: Color.orange,
          circleColor: Color.orange,
          bgColor: Color.brown
     ),
    .init(text: "Create desire",
          textColor: Color.white,
          circleColor: Color.white,
          bgColor: Color.mint
     ),
    .init(text: "Dream fancy",
          textColor: Color.orange,
          circleColor: Color.orange,
          bgColor: Color.pink
     ),
    .init(text: "Shop big",
          textColor: Color.white,
          circleColor: Color.white,
          bgColor: Color.black
     ),
    .init(text: "Let's fashion",
          textColor: Color.orange,
          circleColor: Color.orange,
          bgColor: Color.yellow
     )
    ,.init(text: "Let's fashion",
           textColor: Color.orange,
           circleColor: Color.orange,
           bgColor: Color.brown
   ),
]
