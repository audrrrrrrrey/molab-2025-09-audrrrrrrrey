//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Audrey Guo on 9/27/25.
//

import SwiftUI

struct ContentView: View {
//      for project 2 part 1
//    @State private var showingAlert = false
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            //            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            //                .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: .blue, location: 0.3),
                .init(color: .red, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack (spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.heavy))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            //flag was tapped
                            flagTapped(number)
                        } label :  {
                            Image (countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: ???")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message : {
                Text("Your score is ???")
            }
        }
    }
        
        func flagTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "You got it!"
            } else {
                scoreTitle = "Try again..."
            }
            showingScore = true;
        }
        
        func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        
        //project 2 part 1, just learning
        /*
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }
            Text("Hello, world!")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
        */
        
        /*
        ZStack {
            
            LinearGradient(stops: [Gradient.Stop(color: .white, location: 0.45), Gradient.Stop(color: .black, location: 0.55)], startPoint: .top, endPoint: .bottom)
            
            RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
            
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
             
            
            Text("Hi")
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red.gradient)
            
            .ignoresSafeArea()
        }
         */
        
        /*
        //three ways to do buttons, and images
        VStack {
            //buttons
            Button("Delete selection", role: .destructive, action: executeDelete)
            
            Button("Button 1") {}
                .buttonStyle(.bordered)
                .tint(.indigo)
            
            
            Button {
                print ("Button was tapped")
            } label: {
                Text("Tap me!")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.red)
            }
            
            //images
            Image(systemName: "pencil.circle")
            
            //button with image
            Button {
                print ("Button was tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.red)
            }
        }
        */
        
        /*
        Button("Show alert") {
            showingAlert = true
        }
            .alert("Important message", isPresented: $showingAlert) {
                Button("OK") { }
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please read this")
            }
        */
        
//    }
//    
//    func executeDelete() {
//        print("Deleting...")
//    }
}

#Preview {
    ContentView()
}
