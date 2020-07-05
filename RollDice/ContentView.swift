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
    
    var diceSides = ["4", "6"]
    @State private var diceSideSelection = 0
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("Select the dice type")) {
                            Picker(selection: $diceSideSelection, label: Text("Select the dice type")) {
                                ForEach(0..<diceSides.count) {
                                    Text(self.diceSides[$0])
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section {
                            Button("Roll") {
                                self.rollDice()
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
    
    func rollDice() {
        switch diceSideSelection {
        case 0:
            let number = Int.random(in: 1...4)
            rolledNumber = number
            score += number
        case 1:
            let number = Int.random(in: 1...6)
            rolledNumber = number
            score += number
        default:
            break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
