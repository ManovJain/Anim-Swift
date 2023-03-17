//
//  CameraMenu.swift
//  Anim
//
//  Created by Manovski on 3/17/23.
//

import SwiftUI

import SwiftUI
import Combine

struct CameraMenu: View {

    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    @State private var icon = "settings"
    @State private var anim = "AppIcon" //dynamic
    
    @State var secondsElapsed = 0
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    
    @State var opacity = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.resetCounter()
                    withAnimation {
                        opacity = 1
                    }
                cameraViewModel.addingToFridge = false
            }) {
                if cameraViewModel.addingToFridge == false {
                    Image(systemName: "camera.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color("AnimGreen"))
                }
                else {
                    Image(systemName: "camera")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            
            Button(action: {
                self.resetCounter()
                withAnimation {
                    opacity = 1
                }
                cameraViewModel.addingToFridge = true
            }) {
                if cameraViewModel.addingToFridge == true {
                    Image(systemName: "refrigerator.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color("AnimGreen"))
                }
                else {
                    Image(systemName: "refrigerator")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
        }
        .frame(width: 40,height: 150)
        .background(Color(.lightGray).opacity(0.75))
        .clipShape(Capsule())
        .opacity(opacity)
        .onAppear(){
            self.instantiateTimer()
        }
        
        .onReceive(timer) { _ in
            self.secondsElapsed += 1
            if secondsElapsed >= 5 && opacity > 0.5 {
                withAnimation {
                    opacity = 0.2
                }
                self.resetCounter()
            }
        }
    }
    
    func getIcon() -> String{
        return icon
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



//struct ProfileMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileMenu()
//    }
//}
