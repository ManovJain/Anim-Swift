//
//  AnimEarnedAlert.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 2/14/23.
//

import SwiftUI
import Combine

struct AnimEarnedAlert: View {
    
    @State var secondsElapsed = 0
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    
    @Binding var icon: String
    
    @State var opacity = 0.0
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            VStack {
                Image(icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("New anim earned!")
            }
            .padding()
        }
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("AnimGreen"), lineWidth: 2)
            )
        .frame(width: 180, height: 45)
        .padding()
        .opacity(opacity)
        .onReceive(timer) { _ in
            self.secondsElapsed += 1
            if secondsElapsed == 2 {
                withAnimation {
                    opacity = 1.0
                }
            }
            if secondsElapsed >= 5 {
                withAnimation {
                    opacity = 0.0
                }
                self.cancelTimer()
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.showAnimAlert)) { object in
            self.instantiateTimer()
        }
        
    }
    
    func instantiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.connectedTimer = self.timer.connect()
        return
    }
    
    func cancelTimer() {
        self.connectedTimer?.cancel()
        return
    }
    
    func resetCounter() {
        self.secondsElapsed = 0
        return
    }
    
    func restartTimer() {
        self.secondsElapsed = 0
        self.cancelTimer()
        self.instantiateTimer()
        return
    }
}
