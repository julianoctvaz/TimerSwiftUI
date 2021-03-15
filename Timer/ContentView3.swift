//
//  TimerView.swift
//  Cloudy
//
//  Created by Juliano Vaz on 11/03/21.
//
//https://betterprogramming.pub/how-to-build-a-timer-using-swift-and-swiftui-e72cd8eb3d3a#_=_

import SwiftUI
//import Combine
import Foundation
import UIKit



struct ContentView3: View {
    
    @State var hours: Int = 12
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true
    
    @State var timer: Timer? = nil
    
    var body: some View {
        VStack {
            Text("\(hours, specifier: "%02i"):\(minutes, specifier: "%02i"):\(seconds, specifier: "%02i")")
            //            Text("\(hours):\(minutes):\(seconds)")
            if timerIsPaused {
                HStack {
                    Button(action:{
                        restartTimer()
                        print("RESTART")
                    }){
                        Image(systemName: "backward.end.alt")
                            .padding(.all)
                    }
                    .padding(.all)
                    Button(action:{
                        self.startTimer()
                        print("START")
                    }){
                        Image(systemName: "play.fill")
                            .padding(.all)
                    }
                    .padding(.all)
                }
            } else {
                Button(action:{
                    print("STOP")
                    self.stopTimer()
                }){
                    Image(systemName: "stop.fill")
                        .padding(.all)
                }
                .padding(.all)
            }
        }
    }
    
    func startTimer(){
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
            if self.seconds == 0 {
                self.seconds = 59
                if self.minutes == 0 {
                    self.minutes = 59
                    self.hours = self.hours - 1
                } else {
                    self.minutes = self.minutes - 1
                }
            } else {
                self.seconds = self.seconds - 1
            }
        }
    }
    
    func stopTimer(){
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func restartTimer(){
        hours = 0
        minutes = 0
        seconds = 0
    }
    
}




struct Time {
    var hour: Int
    var minute: Int
    var second: Int = 0
}

struct TimerView: View {
    
    @State var durationTimerView: TimeInterval = 0.0
    
    var body: some View {
        VStack {
            
            HeaderTimerView()
            
            Spacer()
            
            DurationPicker(duration: $durationTimerView)
            //neede to take thats values and biding it with contentView3 
            ContentView3()
            
            Spacer()
            
            ConcluirButton()
            
            Spacer()
            
        }.background(
            Image("bg-clouds")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            
            
        )
        
    }
    
}

struct HeaderTimerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var closeTimerView: Bool = false
    var selectedPause: String = "Yoga"
    //essa variavel sera do tipo binding recebendo da tela AddPauseView
    
    var body: some View {
        
        VStack{
            
            HStack {
                
                Spacer()
                
                Button(
                    action: {
                        self.closeTimerView.toggle()
                        presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Image("bn-close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width*0.08)
                    })
                
            } .padding(.trailing, 20)
            
            
            Text("\(selectedPause)")
                .font(.custom("AvenirNext-Regular", size:30))
                .foregroundColor(Color.black) //aqui pode pegar a cor do figma e colocar o nome
                .padding(.leading, 40)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            
            Spacer()
            
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 105, alignment: .leading)
        
        
        Text("Você gostaria de fazer uma pausa de quanto tempo?")
            .font(.custom("AvenirNext-Regular", size:17))
            .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
            .frame(width: UIScreen.main.bounds.width*0.60, alignment: .center)
        
        
        
        
    }
    
}

struct DurationPicker: UIViewRepresentable {
    @Binding var duration: TimeInterval
    
    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.updateDuration), for: .valueChanged)
        return datePicker
    }
    
    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        datePicker.countDownDuration = duration
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        let parent: DurationPicker
        
        init(_ parent: DurationPicker) {
            self.parent = parent
        }
        
        @objc func updateDuration(datePicker: UIDatePicker) {
            parent.duration = datePicker.countDownDuration
        }
    }
}

struct ConcluirButton: View {
    var body: some View {
        Button(
            action: {
                //do it
            },
            label: {
                Image("bn-concluir")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width*0.3)
            })
            .foregroundColor(Color.blue)
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
