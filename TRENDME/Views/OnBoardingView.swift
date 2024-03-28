//
//  onBoarding.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-24.
//

import SwiftUI

struct onBoarding: View {
    
    @State private var captions: [Intro] = intros
    @State private var activateIntro: Intro?
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            VStack(spacing: 0) {
                if let activateIntro {
                    Rectangle().fill(activateIntro.bgColor)
                        .overlay {
                            Circle()
                                .fill(activateIntro.circleColor)
                                .frame(width: 35, height: 35)
                                .background(alignment: .leading, content: {
                                    Capsule()
                                        .fill(activateIntro.bgColor)
                                        .frame(width: size.width, height: 40)
                                })
                                .background(alignment: .leading){
                                    Text(activateIntro.text)
                                        .font(.largeTitle)
                                        .foregroundStyle(activateIntro.textColor)
                                        .frame(width: textSize(activateIntro.text))
                                        .offset(x: 20)
                                        .offset(x: activateIntro.textOffset)
                                }
                                .offset(x: -activateIntro.circleOffset)
                         }
                }
            }.ignoresSafeArea()
        }
        .task {
            if activateIntro == nil {
                activateIntro = captions.first
                let oneSecond = UInt64(1_000_000_000)
                try? await Task.sleep(nanoseconds: oneSecond * UInt64(0.15))
                animate(0)
            }
        }
    }
    
    func animate(_ index: Int, _ loop: Bool = true) {
        if captions.indices.contains(index + 1) {
            activateIntro?.text = captions[index].text
            activateIntro?.textColor = captions[index].textColor
            
            withAnimation(.snappy(duration: 1), completionCriteria: .removed){
                activateIntro?.textOffset = -(textSize(captions[index].text) + 20)
                activateIntro?.circleOffset = -(textSize(captions[index].text) + 20) / 2
            } completion: {

                withAnimation(.spring(duration: 0.5), completionCriteria: .logicallyComplete){
                    activateIntro?.textOffset = 0
                    activateIntro?.circleOffset = 0
                    activateIntro?.circleColor = captions[index + 1].circleColor
                    activateIntro?.bgColor = captions[index + 1].bgColor
                } completion: {
                    animate(index + 1, loop)
                }
                
            }
            
        } else {
            if loop {
                animate(0, loop)
            }
        }
    }
    
    func textSize(_ text: String) ->CGFloat{
        return NSString(string: text).size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle)]).width
    }
}

#Preview {
    onBoarding()
}
