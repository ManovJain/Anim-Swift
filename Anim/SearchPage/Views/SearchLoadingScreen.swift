//
//  SearchLoadingScreen.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 2/23/23.
//

import SwiftUI
import Combine

struct SearchLoadingScreen: View {
    
    @State var secondsElapsed = 0.0
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    
    @State var searchText: String = "Searching"
    
    @State var numDots = 0
    
    var body: some View {
        Text(searchText)
            .foregroundColor(Color("AnimGreen"))
            .font(Font.custom("DMSans-Medium", size: 15))
            .onAppear(){
                self.instantiateTimer()
            }
            .onReceive(timer) { _ in
                if numDots != 3 {
                    searchText += "."
                    numDots += 1
                }
                else {
                    searchText = "Searching"
                    numDots = 0
                }
            }
    }
    
    func instantiateTimer() {
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common)
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
