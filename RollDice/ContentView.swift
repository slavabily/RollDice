//
//  ContentView.swift
//  RollDice
//
//  Created by slava bily on 4/7/20.
//  Copyright © 2020 slava bily. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [NSSortDescriptor(key: "diceNumber", ascending: true)]) var resultsData: FetchedResults<Roll>
    
    @State private var timer: Timer?
    var dice = Dice()
    
    @State private var rotationAmount = 0.0
    @State private var diceSideSelection = 0
    @State private var diceQuantitySelection = 0
    @State private var results = [Int]()
    @State private var feedback = UINotificationFeedbackGenerator()
    
    let diceQuantity = ["1", "2", "3"]
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("Select the type of dice").font(.headline)) {
                            Picker(selection: $diceSideSelection, label: Text("")) {
                                ForEach(0..<dice.sides.count) {
                                    Text(self.dice.sides[$0])
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("Select the quantity of dices").font(.headline)) {
                            Picker(selection: $diceQuantitySelection, label: Text("")) {
                                ForEach(0..<diceQuantity.count) {
                                    Text(self.diceQuantity[$0])
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section {
                            Button(action: {
                                self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
                                    let counter = Int.random(in: 1...Int(self.dice.sides[self.diceSideSelection])!)
                                    self.rollDices()
                                    self.rollTapped()
                                    
                                    if  counter >= Int(self.dice.sides[self.diceSideSelection])! {
                                        timer.invalidate()
                                    }
                                })
                            }, label: {
                                HStack {
                                    Text("Roll")
                                        .font(.largeTitle)
                                    Spacer()
                                         if diceQuantitySelection == 0 {
                                            Image(systemName: "hexagon")
                                                .scaleEffect(2)
                                                .rotationEffect(Angle(degrees: rotationAmount))
                                        } else if diceQuantitySelection == 1 {
                                            Image(systemName: "hexagon")
                                                .scaleEffect(2)
                                                .rotationEffect(Angle(degrees: rotationAmount))
                                            Spacer()
                                            Image(systemName: "hexagon")
                                                .scaleEffect(2)
                                                .rotationEffect(Angle(degrees: rotationAmount))
                                        } else {
                                            Image(systemName: "hexagon")
                                                .scaleEffect(2)
                                                .rotationEffect(Angle(degrees: rotationAmount))
                                            Spacer()
                                            Image(systemName: "hexagon")
                                                .scaleEffect(2)
                                                .rotationEffect(Angle(degrees: rotationAmount))
                                            Spacer()
                                            Image(systemName: "hexagon")
                                                .scaleEffect(2)
                                                .rotationEffect(Angle(degrees: rotationAmount))
                                        }
                                }
                            })
                                .onAppear {
                                    self.feedback.prepare()
                            }
                        }
                        Section {
                            ForEach(resultsData, id: \.id) { roll in
                                Text("Dice \(roll.diceNumber):     \(roll.result)")
                            }
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
                        ForEach(resultsData, id: \.id) { roll in
                            Text("Dice \(roll.diceNumber):     \(roll.result)")
                        }
                        .onDelete(perform: removeResults(at:))
                        .onAppear {
                            self.results.removeAll()
                            for roll in self.resultsData {
                                self.results.append(Int(roll.result))
                            }
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
    
    func rollTapped() {
        withAnimation(.easeOut(duration: 0.5)) {
            self.rotationAmount += 360
        }
        feedback.notificationOccurred(.success)
    }
    
    func removeResults(at offsets: IndexSet) {
        for index in offsets {
            let roll = resultsData[index]
            moc.delete(roll)
        }
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func rollDices() {
        removeResults(at: IndexSet(integersIn: 0..<resultsData.count))
      
        switch diceQuantitySelection {
        case 0:
            let roll = Roll(context: moc)
            let number = Int.random(in: 1...Int(dice.sides[diceSideSelection])!)
            roll.id = UUID()
            roll.diceNumber = 1
            roll.result = Int16(number)
            try? moc.save()
        case 1:
            for i in 0...1 {
                let roll = Roll(context: moc)
                let number = Int.random(in: 1...Int(dice.sides[diceSideSelection])!)
                roll.id = UUID()
                roll.diceNumber = Int16(i) + 1
                roll.result = Int16(number)
                try? moc.save()
            }
        case 2:
            for i in 0...2 {
                let roll = Roll(context: moc)
                let number = Int.random(in: 1...Int(dice.sides[diceSideSelection])!)
                roll.id = UUID()
                roll.diceNumber = Int16(i) + 1
                roll.result = Int16(number)
                try? moc.save()
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
