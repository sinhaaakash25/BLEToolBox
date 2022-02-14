//
//  ProgressBarView.swift
//  BLEToolBox
//
//  Created by Aakash Sinha on 10/02/22.
//

import SwiftUI

struct ProgressBarView: View {
     var progress: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Double(self.progress), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            Text(String(format: "%.0f", min(Double(self.progress), 1.0)))
                .font(.system(size: 10))
            
        }
    }
}


