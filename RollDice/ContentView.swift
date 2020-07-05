//
//  ContentView.swift
//  RollDice
//
//  Created by slava bily on 4/7/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var rolledNumber = Int()
    @State private var score = 0
    
    var diceTypes = ["4", "6"]
    @State private var diceTypeSelection = 0
    
    var body: some View {
        TabView {
            NavigationView {
                
                VStack {
                    Form {
                        Section {
                            Picker(selection: $diceTypeSelection, label: Text("Select the dice type")) {
                                ForEach(0..<diceTypes.count) {
                                    Text(self.diceTypes[$0])
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section {
                            Button("Roll") {
                                self.randomNumber()
                            }
                            .font(.largeTitle)
                            
                            Text("Number: \(rolledNumber != 0 ? "\(rolledNumber)" : "")")
                                .padding()
                        }
                    }
                   
                    
                    
                }
                .navigationBarTitle("Roll the Dice")
            }
            .tabItem {
                Image(systemName: "hexagon.fill")
                Text("Roll Dice")
            }
            .tag(0)
            
            NavigationView {
                VStack {
                    Text("Score: \(score)")
                        .font(.largeTitle)
                }
                .navigationBarTitle("Results")
            }
            .tabItem {
                Image(systemName: "dollarsign.circle.fill")
                Text("Results")
            }
            .tag(1)
        }
    }
    
    func randomNumber() {
        let number = Int.random(in: 1...6)
        
        rolledNumber = number
        
        score += number
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
