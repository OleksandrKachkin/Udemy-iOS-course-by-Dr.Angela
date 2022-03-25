//
//  ContentView.swift
//  Dicee(SwiftUI)
//
//  Created by Oleksandr Kachkin on 24.03.2022.
//

import SwiftUI

struct ContentView: View {
  
  @State var leftSideDice = 1
  @State var rightSideDice = 1
  
  var body: some View {
    ZStack {
      Image("background")
        .resizable()
        .edgesIgnoringSafeArea(.all)
      VStack {
        Image("diceeLogo")
        Spacer()
        HStack {
          DiceView(n: leftSideDice)
          DiceView(n: rightSideDice)
        }
        .padding(.horizontal)
        Spacer()
        Button(action: {
          self.leftSideDice = Int.random(in: 1...6)
          self.rightSideDice = Int.random(in: 1...6)
        }) {
          Text("Roll")
            .font(.system(size: 50))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .padding(.horizontal)
        }
        .background(Color.red)
      }
    }
  }
}

struct DiceView: View {
  let n: Int
  
  var body: some View {
    HStack {
      Image("dice\(n)")
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

