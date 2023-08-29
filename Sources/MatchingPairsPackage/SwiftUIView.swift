//
//  SwiftUIView.swift
//
//
//  Created by Sandu Tocan on 27.08.2023.
//

import SwiftUI
import Combine

public struct InLineProgressView: View {
    
    private let progress: Double
    private let colorScheme: ColorScheme
    
    public init(progress: Double,
                colorScheme: ColorScheme
    ) {
        self.progress = progress
        self.colorScheme = colorScheme
    }
    
    public var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 4)
            .foregroundColor(Color.gray)
            .overlay {
                GeometryReader { proxy in
                    (colorScheme == .dark ? Color.white : Color.black)
                        .frame(maxWidth: proxy.size.width * progress)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .cornerRadius(6)
            .onChange(of: progress, perform: { newValue in
                
            })
    }
    
    
}

struct InLineProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InLineProgressView(progress: 1, colorScheme: .light)
    }
}




