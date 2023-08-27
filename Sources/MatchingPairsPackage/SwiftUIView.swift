//
//  SwiftUIView.swift
//  
//
//  Created by Sandu Tocan on 27.08.2023.
//

import SwiftUI
import Combine

public struct TimerView: View {
    
    private let seconds: Double
    private let onRestartPublisher: PassthroughSubject<Void, Never>
    private let onFinishedInteraction: (() -> Void)
    
    @State private var secondsRemaining: Double
    @State private var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    private var disposeBag = Set<AnyCancellable>()
    
    var fraction: Double {
        secondsRemaining / seconds
    }
    
    public init(seconds: Int,
         onRestartPublisher: PassthroughSubject<Void, Never>,
         onFinishedInteraction: @escaping (() -> Void)
    ) {
        self.secondsRemaining = Double(seconds)
        self.seconds = Double(seconds)
        self.onFinishedInteraction = onFinishedInteraction
        self.onRestartPublisher = onRestartPublisher
    }
    
    public var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 4)
            .foregroundColor(Color.gray)
            .overlay {
                GeometryReader { proxy in
                    Color.black.frame(maxWidth: proxy.size.width * fraction)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .cornerRadius(6)
            .onReceive(timer) { _ in
                if self.secondsRemaining > 0 {
                    withAnimation(.linear(duration: 1)) {
                        self.secondsRemaining -= 1
                    }
                } else {
                    self.timer.upstream.connect().cancel()
                    self.onFinishedInteraction()
                }
            }
            .onReceive(onRestartPublisher) { _ in
                self.secondsRemaining = Double(seconds)
                self.timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
            }
    }
    
    
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(seconds: 10, onRestartPublisher: PassthroughSubject<Void, Never>(), onFinishedInteraction: {})
    }
}

