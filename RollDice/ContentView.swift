//
//  ContentView.swift
//  RollDice
//
//  Created by slava bily on 4/7/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var dice = Dice()
    
    @State private var rolledResult = 0
    @State private var score = 0
    @State private var diceSideSelection = 0
    @State private var diceQuantitySelection = 0
    @State private var results = [Int]()
    
    let diceQuantity = ["1", "2", "3"]
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("Select the type of dice")) {
                            Picker(selection: $diceSideSelection, label: Text("")) {
                                ForEach(0..<dice.sides.count) {
                                    Text(self.dice.sides[$0])
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("Select the quantity of dices")) {
                            Picker(selection: $diceQuantitySelection, label: Text("")) {
                                ForEach(0..<diceQuantity.count) {
                                    Text(self.diceQuantity[$0])
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section {
                            Button("Roll") {
                                self.rollDices()
                            }
                            .font(.largeTitle)
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
                    List {
                        ForEach(0..<results.count) {
                            Text("Dice\($0 + 1):  \(self.results[$0])")
                        }
                    }
                    
                    Text("Total: \(results.reduce(0, +))")
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
    
    func rollDices() {
        rolledResult = 0
        
        switch diceQuantitySelection {
        case 0:
            let number = Int.random(in: 1...Int(dice.sides[diceSideSelection])!)
            rolledResult = number
            results.append(rolledResult)
        case 1:
            for _ in 0...1 {
                let number = Int.random(in: 1...Int(dice.sides[diceSideSelection])!)
                rolledResult = number
                results.append(rolledResult)
            }
        case 2:
            for _ in 0...2 {
                let number = Int.random(in: 1...Int(dice.sides[diceSideSelection])!)
                rolledResult = number
                results.append(rolledResult)
            }
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
